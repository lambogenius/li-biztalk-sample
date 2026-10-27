<#
.SYNOPSIS
    Deploys the converted Harbor Lane application to Azure and publishes its workflows.

.DESCRIPTION
    1. Creates the resource group and every resource from azure/main.bicep.
    2. Builds the local functions project into after/logicapp/lib/custom.
    3. Zip-deploys after/logicapp to the Logic App.

    Requires the Azure CLI (signed in with `az login`), the .NET 8 SDK and PowerShell 7.
    Costs money while the resources exist (mainly the WS1 plan); run teardown.ps1 to remove them.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $SubscriptionId,
    [string] $Location = 'canadacentral',
    [string] $ResourceGroupName = 'rg-li-sample-harborlane-dev-cac'
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$logicAppRoot = Join-Path $repo 'after/logicapp'

function Invoke-Az {
    $output = & az @args
    if ($LASTEXITCODE -ne 0) { throw "az $($args -join ' ') failed." }
    return $output
}

Invoke-Az account set --subscription $SubscriptionId | Out-Null

# A new subscription has none of these registered; registering is free and idempotent.
$providers = 'Microsoft.Web', 'Microsoft.Storage', 'Microsoft.KeyVault', 'Microsoft.Insights', 'Microsoft.OperationalInsights'
foreach ($provider in $providers) {
    if ((Invoke-Az provider show --namespace $provider --query registrationState -o tsv) -ne 'Registered') {
        Write-Host "Registering $provider..."
        Invoke-Az provider register --namespace $provider --wait | Out-Null
    }
}

# The vault enables purge protection, so after teardown.ps1 it stays soft-deleted for 90 days and
# its name cannot be reused. Deploying again to the same group recovers it instead.
$deletedVaults = @(Invoke-Az keyvault list-deleted --resource-type vault -o json | ConvertFrom-Json |
    Where-Object { $_.properties.vaultId -match "/resourceGroups/$([regex]::Escape($ResourceGroupName))/" })
if ($deletedVaults) {
    Invoke-Az group create --name $ResourceGroupName --location $Location | Out-Null
    foreach ($vault in $deletedVaults) {
        Write-Host "Recovering soft-deleted Key Vault $($vault.name)..."
        Invoke-Az keyvault recover --name $vault.name | Out-Null
    }
}

Write-Host "Deploying infrastructure to $ResourceGroupName ($Location)..."
$deployment = Invoke-Az deployment sub create `
    --name "li-sample-harborlane-$(Get-Date -Format yyyyMMddHHmmss)" `
    --location $Location `
    --template-file (Join-Path $PSScriptRoot 'main.bicep') `
    --parameters resourceGroupName=$ResourceGroupName location=$Location `
    --query properties.outputs --output json | ConvertFrom-Json
$logicAppName = $deployment.logicAppName.value
Write-Host "Logic App: $logicAppName"

Write-Host 'Building the local functions...'
# The functions project is the one that references the Logic Apps workflows SDK; building it
# publishes the functions into after/logicapp/lib/custom.
$project = Get-ChildItem (Join-Path $repo 'after/Functions') -Filter '*.csproj' |
    Where-Object { (Get-Content $_.FullName -Raw) -match 'Microsoft\.Azure\.Workflows\.Webjobs\.Sdk' } |
    Select-Object -First 1
if (-not $project) { throw 'No project in after/Functions references Microsoft.Azure.Workflows.Webjobs.Sdk.' }
dotnet build $project.FullName --configuration Release --nologo
if ($LASTEXITCODE -ne 0) { throw 'The Functions build failed.' }

Write-Host 'Publishing the workflows...'
$zip = Join-Path ([System.IO.Path]::GetTempPath()) "harborlane-logicapp-$([guid]::NewGuid()).zip"
try {
    Compress-Archive -Path (Join-Path $logicAppRoot '*') -DestinationPath $zip
    Invoke-Az logicapp deployment source config-zip `
        --resource-group $ResourceGroupName --name $logicAppName --src $zip | Out-Null
} finally {
    Remove-Item $zip -ErrorAction SilentlyContinue
}

Write-Host "Deployed. Run ./azure/smoke-test.ps1 -SubscriptionId $SubscriptionId to send the test messages."
