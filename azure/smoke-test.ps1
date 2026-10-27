<#
.SYNOPSIS
    Sends the sample's test messages through the three deployed flows and checks the results.

.DESCRIPTION
    - Order intake: uploads both purchase orders to orders-in; expects one blob in
      orders-approval (total of 5000 or more) and one in orders-fulfilment.
    - Inventory update: uploads the CSV snapshot to inventory-in; expects an XML document in
      inventory-out.
    - Shipment notification: POSTs the shipment notice to the workflow's HTTP trigger; expects
      an acknowledgement and an archived notice in shipments-archive.

    Uploads use your Azure sign-in (`--auth-mode login`), so your account needs the Storage Blob
    Data Contributor role on the sample's storage account; the script grants it if missing.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $SubscriptionId,
    [string] $ResourceGroupName = 'rg-li-sample-harborlane-dev-cac',
    [int] $TimeoutSeconds = 300
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$messages = Join-Path $repo 'before/TestMessages'

function Invoke-Az {
    $output = & az @args
    if ($LASTEXITCODE -ne 0) { throw "az $($args -join ' ') failed." }
    return $output
}

Invoke-Az account set --subscription $SubscriptionId | Out-Null
$storage = Invoke-Az storage account list --resource-group $ResourceGroupName --query '[0].name' -o tsv
$storageId = Invoke-Az storage account show --name $storage --resource-group $ResourceGroupName --query id -o tsv
$logicApp = Invoke-Az logicapp list --resource-group $ResourceGroupName --query '[0].name' -o tsv

# Your sign-in uploads and reads the test blobs.
$me = Invoke-Az ad signed-in-user show --query id -o tsv
# Count in PowerShell: on Windows az runs through cmd.exe, which breaks on parentheses in --query.
$assignments = @(Invoke-Az role assignment list --assignee $me --scope $storageId `
        --role 'Storage Blob Data Contributor' -o json | ConvertFrom-Json)
if ($assignments.Count -eq 0) {
    Invoke-Az role assignment create --assignee-object-id $me --assignee-principal-type User `
        --role 'Storage Blob Data Contributor' --scope $storageId | Out-Null
    Write-Host 'Granted you Storage Blob Data Contributor; waiting 60s for it to apply...'
    Start-Sleep -Seconds 60
}

function Get-BlobNames([string] $container) {
    @(Invoke-Az storage blob list --account-name $storage --container-name $container `
            --auth-mode login --query '[].name' -o json | ConvertFrom-Json)
}

function Send-Blob([string] $container, [string] $folder, [string] $file) {
    $name = "$folder/smoke-$(Get-Date -Format yyyyMMddHHmmss)-$(Split-Path $file -Leaf)"
    Invoke-Az storage blob upload --account-name $storage --container-name $container `
        --name $name --file $file --auth-mode login --overwrite | Out-Null
    Write-Host "  uploaded $container/$name"
}

function Wait-ForNewBlob([string] $container, [string[]] $before) {
    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    while ((Get-Date) -lt $deadline) {
        $new = @(Get-BlobNames $container | Where-Object { $_ -notin $before })
        if ($new.Count) { return $new }
        Start-Sleep -Seconds 15
    }
    return @()
}

$results = [ordered]@{}
$watched = 'orders-approval', 'orders-fulfilment', 'orders-error', 'inventory-out', 'shipments-archive'
$before = @{}
foreach ($container in $watched) { $before[$container] = Get-BlobNames $container }

Write-Host 'Order intake and inventory update: uploading test files...'
Send-Blob 'orders-in' 'Orders' (Join-Path $messages 'PurchaseOrder_Approval.xml')
Send-Blob 'orders-in' 'Orders' (Join-Path $messages 'PurchaseOrder_Fulfilment.xml')
Send-Blob 'inventory-in' 'Inventory' (Join-Path $messages 'InventorySnapshot.csv')

Write-Host 'Shipment notification: posting the notice...'
$workflowApi = "https://management.azure.com/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Web/sites/$logicApp/hostruntime/runtime/webhooks/workflow/api/management/workflows/wf-shipment-notification"
$definition = Get-Content (Join-Path $repo 'after/logicapp/wf-shipment-notification/workflow.json') -Raw | ConvertFrom-Json
$trigger = @($definition.definition.triggers.PSObject.Properties)[0].Name
$listed = Invoke-Az rest --method post --uri "$workflowApi/triggers/$trigger/listCallbackUrl?api-version=2023-12-01" -o json |
    ConvertFrom-Json
# The callback URL's value leaves out the trigger's relativePath; callers post to basePath/relativePath.
# Path placeholders such as {ShipmentService_svc} take the values the local test contract sends.
$contract = Get-Content (Join-Path $repo 'after/tests/workflow-runs.json') -Raw | ConvertFrom-Json
$pathParameters = @($contract.cases | Where-Object { $_.workflow -eq 'wf-shipment-notification' })[0].send.request.pathParameters
$callback = $listed.value
if ($listed.relativePath) {
    $relative = [regex]::Replace($listed.relativePath.TrimStart('/'), '\{([^}]+)\}', {
            param($m)
            $value = $pathParameters.($m.Groups[1].Value)
            if (-not $value) { throw "No value for path parameter $($m.Value) in after/tests/workflow-runs.json." }
            [uri]::EscapeDataString($value)
        })
    $query = ($listed.queries.PSObject.Properties | ForEach-Object { "$($_.Name)=$([uri]::EscapeDataString($_.Value))" }) -join '&'
    $callback = "$($listed.basePath.TrimEnd('/'))/$relative`?$query"
}
Write-Host "  POST $($callback -replace '([?&]sig=)[^&]+', '$1***')"
$response = Invoke-WebRequest -Method Post -Uri $callback -ContentType 'application/xml' `
    -InFile (Join-Path $messages 'ShipmentNotice.xml') -SkipHttpErrorCheck
Write-Host "  HTTP $($response.StatusCode)"
$results['Shipment acknowledgement (HTTP 200)'] = $response.StatusCode -eq 200
if ($response.StatusCode -eq 200) { Write-Host $response.Content }

Write-Host "Waiting up to $TimeoutSeconds s for the workflows (blob triggers poll every 60 s)..."
$results['Order of 5000 or more -> orders-approval'] = (Wait-ForNewBlob 'orders-approval' $before['orders-approval']).Count -ge 1
$results['Order below 5000 -> orders-fulfilment'] = (Wait-ForNewBlob 'orders-fulfilment' $before['orders-fulfilment']).Count -ge 1
$results['Inventory CSV -> inventory-out'] = (Wait-ForNewBlob 'inventory-out' $before['inventory-out']).Count -ge 1
$results['Accepted notice -> shipments-archive'] = (Wait-ForNewBlob 'shipments-archive' $before['shipments-archive']).Count -ge 1
$errors = @(Get-BlobNames 'orders-error' | Where-Object { $_ -notin $before['orders-error'] })
$results['No order errors'] = $errors.Count -eq 0

$results.GetEnumerator() | ForEach-Object {
    Write-Host ("{0}  {1}" -f ($(if ($_.Value) { 'PASS' } else { 'FAIL' }), $_.Key))
}
if ($results.Values -contains $false) {
    Write-Host 'Inspect the runs in the Azure portal: Logic App > Workflows > Run history.'
    exit 1
}
