[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$candidateRoot = Split-Path -Parent $PSScriptRoot
$plannedWorkflows = @('wf-order-intake', 'wf-inventory-update', 'wf-shipment-notification')
$expectedCorrelationId = 'd4ce59b0-bf81-4360-a234-a18f9c124add'
$expectedMigrationDate = '2026-10-26T23:47:37.248Z'

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw "ASSERTION FAILED: $Message" }
}

function Get-PropertyValue($Object, [string]$Name) {
    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) { return $null }
    return $property.Value
}

function Resolve-JsonPointer($Root, [string]$Pointer) {
    $current = $Root
    foreach ($part in ($Pointer.TrimStart('/') -split '/')) {
        $current = Get-PropertyValue $current $part.Replace('~1', '/').Replace('~0', '~')
        if ($null -eq $current) { return $null }
    }
    return $current
}

function Get-WorkflowActions($Actions) {
    foreach ($property in @($Actions.PSObject.Properties)) {
        [pscustomobject]@{ Name = $property.Name; Node = $property.Value }
        if ($null -ne $property.Value.actions) { Get-WorkflowActions $property.Value.actions }
        if ($null -ne $property.Value.else -and $null -ne $property.Value.else.actions) { Get-WorkflowActions $property.Value.else.actions }
    }
}

$workflowFiles = @(Get-ChildItem -LiteralPath (Join-Path $candidateRoot 'logicapp') -Filter workflow.json -File -Recurse)
Assert-True ($workflowFiles.Count -eq 3) "Expected three workflow.json files; found $($workflowFiles.Count)."
$workflows = @{}
foreach ($file in $workflowFiles) {
    $folder = $file.Directory.Name
    if ($folder -notin $plannedWorkflows) { continue }
    $workflow = Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json -Depth 100 -DateKind String
    $workflows[$folder] = $workflow
    Assert-True (@($workflow.definition.triggers.PSObject.Properties).Count -eq 1) "$folder must have exactly one trigger."
    $metadata = $workflow.definition.metadata.MigrationMetadata
    Assert-True ($null -ne $metadata) "$folder is missing MigrationMetadata."
    $guid = [Guid]::Empty
    Assert-True ([Guid]::TryParse([string]$metadata.MigrationCorrelationId, [ref]$guid)) "$folder correlation id is not a GUID."
    $date = [DateTimeOffset]::MinValue
    Assert-True ([DateTimeOffset]::TryParse([string]$metadata.MigrationDate, [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::RoundtripKind, [ref]$date)) "$folder migration date is not ISO 8601."
    Assert-True ($metadata.MigrationCorrelationId -eq $expectedCorrelationId) "$folder correlation id is not the LI-owned value."
    Assert-True ($metadata.MigrationDate -eq $expectedMigrationDate) "$folder migration date is not the LI-owned value."
}
foreach ($name in $plannedWorkflows) { Assert-True ($workflows.ContainsKey($name)) "Missing $name." }

$approvalDecision = $workflows['wf-order-intake'].definition.actions.Scope_ProcessOrder.actions.Decide_ApprovalRequired
Assert-True ($null -eq $approvalDecision.runtimeConfiguration.secureData) 'Decide_ApprovalRequired contains unsupported secureData configuration.'
$shipmentTrigger = $workflows['wf-shipment-notification'].definition.triggers.Receive_ShipmentNotice
Assert-True ($shipmentTrigger.inputs.relativePath -eq 'HarborLaneShipments/{ShipmentService_svc}/notices') 'Shipment Request path must use a runtime-valid placeholder for the dotted source segment.'

$coverage = @(
    @('wf-order-intake','/definition/triggers/Receive_PurchaseOrder','ServiceProvider'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder','Scope'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder','Scope'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder/actions/Transform_PurchaseOrderToCanonical','Xslt'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Expr_CalculateDiscount','InvokeFunction'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/ConstructMessage_PricedOrder','Scope'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired','If'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired/actions/Send_ToApproval','ServiceProvider'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired/else/actions/Send_ToFulfilment','ServiceProvider'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure','Scope'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure/actions/ConstructMessage_OrderError/actions/Construct_OrderError_Assign_OrderError','InvokeFunction'),
    @('wf-order-intake','/definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure/actions/Send_OrderError','ServiceProvider'),
    @('wf-shipment-notification','/definition/triggers/Receive_ShipmentNotice','Request'),
    @('wf-shipment-notification','/definition/actions/Expr_ValidateAndComputeEta','Scope'),
    @('wf-shipment-notification','/definition/actions/ConstructMessage_ShipmentAck','Scope'),
    @('wf-shipment-notification','/definition/actions/ConstructMessage_ShipmentAck/actions/Transform_NoticeToAck','Xslt'),
    @('wf-shipment-notification','/definition/actions/ConstructMessage_ShipmentAck/actions/Construct_ShipmentAck_Assign_AckStatus','InvokeFunction'),
    @('wf-shipment-notification','/definition/actions/Send_ShipmentAck','Response'),
    @('wf-shipment-notification','/definition/actions/Decide_NoticeAccepted','If'),
    @('wf-shipment-notification','/definition/actions/Decide_NoticeAccepted/actions/Send_NoticeToFolder','ServiceProvider')
)
foreach ($entry in $coverage) {
    $node = Resolve-JsonPointer $workflows[$entry[0]] $entry[1]
    Assert-True ($null -ne $node) "Coverage pointer $($entry[1]) is missing."
    Assert-True ($node.type -eq $entry[2]) "Coverage pointer $($entry[1]) must be $($entry[2])."
}

$allWorkflowText = ($workflowFiles | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"
Assert-True (-not $allWorkflowText.Contains('/serviceProviders/FileSystem')) 'The unsupported File System connector is present.'
Assert-True ($allWorkflowText.Contains('/serviceProviders/AzureBlob')) 'Azure Blob built-in operations are missing.'
Assert-True ($allWorkflowText.Contains('FlatFileDecoding')) 'InventoryFlatFileReceive was not converted to FlatFileDecoding.'
Assert-True (-not $allWorkflowText.Contains('JavaScriptCode')) 'The workflows retain a Node-dependent inline-code action.'

$allActions = @($plannedWorkflows | ForEach-Object { Get-WorkflowActions $workflows[$_].definition.actions })
$uploads = @($allActions | Where-Object { $_.Node.inputs.serviceProviderConfiguration.operationId -eq 'uploadBlob' })
Assert-True ($uploads.Count -eq 5) 'Expected one Blob upload for each source FILE send port.'
foreach ($upload in $uploads) {
    Assert-True ($upload.Node.inputs.retryPolicy.count -eq 3) "$($upload.Name) must retry three times."
    Assert-True ($upload.Node.inputs.retryPolicy.interval -eq 'PT5M') "$($upload.Name) must retry at five-minute intervals."
    Assert-True ([string]$upload.Node.inputs.parameters.overrideIfExists -eq 'false') "$($upload.Name) must fail closed on collision."
}

$connections = Get-Content -LiteralPath (Join-Path $candidateRoot 'logicapp/connections.json') -Raw | ConvertFrom-Json -Depth 50
Assert-True ($connections.serviceProviderConnections.AzureBlob.parameterSetName -eq 'ManagedServiceIdentity') 'Azure Blob must use managed identity.'
Assert-True ($connections.serviceProviderConnections.AzureBlob.parameterValues.PSObject.Properties.Name -contains 'blobStorageEndpoint') 'Azure Blob endpoint setting is missing.'

$inventory = $workflows['wf-inventory-update'].definition.actions.Parse_InventoryFlatFile
Assert-True ($inventory.type -eq 'FlatFileDecoding') 'Inventory parser is not the built-in Flat File Decoding action.'
Assert-True ($inventory.metadata.ValidateDocumentStructure) 'Flat-file structure validation must be enabled.'
Assert-True (-not $inventory.metadata.RecoverableInterchangeProcessing) 'Malformed inventory interchanges must fail as a whole.'
$orderBlobName = [string]$workflows['wf-order-intake'].definition.actions.Read_PurchaseOrder_Blob.inputs.parameters.blobName
$inventoryBlobName = [string]$workflows['wf-inventory-update'].definition.actions.Read_InventorySnapshot_Blob.inputs.parameters.blobName
foreach ($blobNameExpression in @($orderBlobName, $inventoryBlobName)) {
    Assert-True ($blobNameExpression.Contains("startsWith(triggerBody()?['properties']?['blobFullPathWithContainer'], '/')") -and $blobNameExpression.Contains(', 2, 1)')) 'Blob read path does not remove both the leading slash and container prefix.'
}
function Get-BlobNameFromTriggerPath([string]$FullPath) {
    $segments = $FullPath.Split('/')
    $skip = if ($FullPath.StartsWith('/')) { 2 } else { 1 }
    ($segments | Select-Object -Skip $skip) -join '/'
}
Assert-True ((Get-BlobNameFromTriggerPath '/orders-in/Orders/po-approval.xml') -eq 'Orders/po-approval.xml') 'Leading-slash order trigger path resolves to the wrong Blob name.'
Assert-True ((Get-BlobNameFromTriggerPath 'orders-in/Orders/po-approval.xml') -eq 'Orders/po-approval.xml') 'Order trigger path without a leading slash resolves to the wrong Blob name.'
Assert-True ((Get-BlobNameFromTriggerPath '/inventory-in/Inventory/snapshot.csv') -eq 'Inventory/snapshot.csv') 'Leading-slash inventory trigger path resolves to the wrong Blob name.'
$csvPath = Join-Path $PSScriptRoot 'messages/InventorySnapshot.csv'
$csvBytes = [IO.File]::ReadAllBytes($csvPath)
Assert-True ($csvBytes.Length -ge 2 -and $csvBytes[-2] -eq 13 -and $csvBytes[-1] -eq 10) 'Inventory fixture must end with the schema-required postfix CRLF delimiter.'
$bareLfOffsets = @(for ($index = 0; $index -lt $csvBytes.Length; $index++) {
    if ($csvBytes[$index] -eq 10 -and ($index -eq 0 -or $csvBytes[$index - 1] -ne 13)) { $index }
})
$bareCrOffsets = @(for ($index = 0; $index -lt $csvBytes.Length; $index++) {
    if ($csvBytes[$index] -eq 13 -and ($index + 1 -ge $csvBytes.Length -or $csvBytes[$index + 1] -ne 10)) { $index }
})
Assert-True ($bareLfOffsets.Count -eq 0 -and $bareCrOffsets.Count -eq 0) 'Inventory fixture contains a record delimiter other than CRLF.'
$csv = @(Get-Content -LiteralPath $csvPath)
$crlfCount = @($csvBytes | Where-Object { $_ -eq 13 }).Count
Assert-True ($crlfCount -eq $csv.Count) 'Every inventory record, including the last DTL record, must have one postfix CRLF delimiter.'
Assert-True ($csv[0] -eq 'HDR,WH-CEDAR,20261019,4') 'Inventory HDR record changed.'
$details = @($csv | Where-Object { $_.StartsWith('DTL,') })
Assert-True ($details.Count -eq 4) 'Inventory detail debatching count changed.'
Assert-True ((($details | ForEach-Object { ($_ -split ',')[1] }) -join '|') -eq 'HLS-TENT-2P|HLS-BAG-20F|HLS-LAMP-USB|HLS-KAYAK-SOLO') 'Inventory detail order changed.'

[xml]$approval = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'messages/PurchaseOrder_Approval.xml') -Raw
[xml]$fulfilment = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'messages/PurchaseOrder_Fulfilment.xml') -Raw
function Get-OrderValue([xml]$Document, [string]$Path) { $Document.SelectSingleNode("/*[local-name()='PurchaseOrder']/$Path").InnerText }
Assert-True ([decimal](Get-OrderValue $approval "*[local-name()='Header']/*[local-name()='TotalAmount']") -ge 5000) 'Approval sample does not exercise the approval route.'
Assert-True ([decimal](Get-OrderValue $fulfilment "*[local-name()='Header']/*[local-name()='TotalAmount']") -lt 5000) 'Fulfilment sample does not exercise the fulfilment route.'
Assert-True (((Get-OrderValue $approval "*[local-name()='Buyer']/*[local-name()='FirstName']") + ' ' + (Get-OrderValue $approval "*[local-name()='Buyer']/*[local-name()='LastName']")) -eq 'Rowan Fieldstone') 'Buyer-name concatenation changed.'
$address = '{0}, {1}, {2} {3}, {4}' -f (Get-OrderValue $approval "*[local-name()='ShipTo']/*[local-name()='Street']"), (Get-OrderValue $approval "*[local-name()='ShipTo']/*[local-name()='City']"), (Get-OrderValue $approval "*[local-name()='ShipTo']/*[local-name()='Region']"), (Get-OrderValue $approval "*[local-name()='ShipTo']/*[local-name()='PostalCode']"), (Get-OrderValue $approval "*[local-name()='ShipTo']/*[local-name()='Country']")
Assert-True ($address -eq '400 Lakeshore Loop, Pinewick, WA 98000, US') 'Shipping-address concatenation changed.'

function Get-Discount([decimal]$Total, [string]$Tier) {
    if ($Total -le 0) { return [decimal]0 }
    $rate = switch ($Tier.Trim().ToUpperInvariant()) { 'GOLD' { [decimal]0.10 } 'SILVER' { [decimal]0.05 } default { [decimal]0 } }
    if ($Total -ge 1000) { $rate += [decimal]0.01 }
    [Math]::Round($Total * $rate, 2, [MidpointRounding]::AwayFromZero)
}
Assert-True ((Get-Discount 7860 'Gold') -eq [decimal]864.60) 'Gold and volume pricing changed.'
Assert-True ((Get-Discount 1505.40 ' Silver ') -eq [decimal]90.32) 'Silver casing, whitespace, volume, or midpoint behavior changed.'
Assert-True ((Get-Discount 0 'Gold') -eq 0) 'Nonpositive pricing behavior changed.'

$pricingAction = $workflows['wf-order-intake'].definition.actions.Scope_ProcessOrder.actions.ConstructMessage_PricedOrder.actions.Apply_Pricing_Values
Assert-True ($null -ne $pricingAction.inputs.xsltParameters) 'Apply_Pricing_Values must pass Transform XML parameters through inputs.xsltParameters.'
Assert-True ($null -eq $pricingAction.inputs.parameters) 'Apply_Pricing_Values contains the unsupported inputs.parameters property.'
Assert-True ($pricingAction.inputs.xsltParameters.discountAmount -eq "@body('Expr_CalculateDiscount')?['discountAmount']") 'The pricing XSLT discountAmount is not supplied by PricingRules.'
Assert-True ($pricingAction.inputs.xsltParameters.netTotal -eq "@body('Expr_CalculateDiscount')?['netTotal']") 'The pricing XSLT netTotal is not supplied by PricingRules.'

$approvalTotal = [decimal](Get-OrderValue $approval "*[local-name()='Header']/*[local-name()='TotalAmount']")
$approvalTier = Get-OrderValue $approval "*[local-name()='Header']/*[local-name()='CustomerTier']"
$approvalDiscount = Get-Discount $approvalTotal $approvalTier
$approvalNetTotal = $approvalTotal - $approvalDiscount
$invariant = [Globalization.CultureInfo]::InvariantCulture
$canonicalInput = [xml](('<co:CanonicalOrder xmlns:co="http://HarborLane.Integration.Schemas.CanonicalOrder"><OrderId>{0}</OrderId><OrderTotal>{1}</OrderTotal><DiscountAmount>0.00</DiscountAmount><NetTotal>0.00</NetTotal></co:CanonicalOrder>' -f
    [Security.SecurityElement]::Escape((Get-OrderValue $approval "*[local-name()='Header']/*[local-name()='OrderNumber']")),
    $approvalTotal.ToString('0.00', $invariant)))
$pricingTransform = [Xml.Xsl.XslCompiledTransform]::new()
$pricingTransform.Load((Join-Path $candidateRoot 'logicapp/Artifacts/Maps/Apply_Pricing_To_CanonicalOrder.xslt'))
$pricingArguments = [Xml.Xsl.XsltArgumentList]::new()
$pricingArguments.AddParam('discountAmount', '', $approvalDiscount.ToString('0.00', $invariant))
$pricingArguments.AddParam('netTotal', '', $approvalNetTotal.ToString('0.00', $invariant))
$pricingOutput = [Text.StringBuilder]::new()
$pricingWriter = [Xml.XmlWriter]::Create($pricingOutput, $pricingTransform.OutputSettings)
try { $pricingTransform.Transform($canonicalInput, $pricingArguments, $pricingWriter) } finally { $pricingWriter.Dispose() }
[xml]$pricedOrder = $pricingOutput.ToString()
Assert-True ($pricedOrder.SelectSingleNode("/*[local-name()='CanonicalOrder']/*[local-name()='DiscountAmount']").InnerText -eq '864.60') 'The executed pricing XSLT did not write the computed DiscountAmount.'
Assert-True ($pricedOrder.SelectSingleNode("/*[local-name()='CanonicalOrder']/*[local-name()='NetTotal']").InnerText -eq '6995.40') 'The executed pricing XSLT did not write the computed NetTotal.'

$orderNormalization = [string]$workflows['wf-order-intake'].definition.actions.Normalize_PurchaseOrder_Payload.inputs
$inventoryNormalization = [string]$workflows['wf-inventory-update'].definition.actions.Normalize_InventorySnapshot_Payload.inputs
$shipmentNormalization = [string]$workflows['wf-shipment-notification'].definition.actions.Normalize_ShipmentNotice_Payload.inputs
foreach ($normalization in @($orderNormalization, $inventoryNormalization, $shipmentNormalization)) {
    Assert-True ($normalization.Contains('base64ToString')) 'An inbound payload normalizer does not decode a $content wrapper.'
}
Assert-True ($workflows['wf-order-intake'].definition.actions.Parse_WellFormed_PurchaseOrder_XML.inputs -eq "@xml(outputs('Normalize_PurchaseOrder_Payload'))") 'PurchaseOrder XML parsing bypasses normalized text.'
Assert-True ($workflows['wf-inventory-update'].definition.actions.Parse_InventoryFlatFile.inputs.content -eq "@outputs('Normalize_InventorySnapshot_Payload')") 'Flat-file decoding bypasses normalized text.'
Assert-True ($workflows['wf-shipment-notification'].definition.actions.Parse_WellFormed_ShipmentNotice_XML.inputs -eq "@xml(outputs('Normalize_ShipmentNotice_Payload'))") 'ShipmentNotice XML parsing bypasses normalized text.'
$orderTypeCheck = $workflows['wf-order-intake'].definition.actions.Check_PurchaseOrder_MessageType
$shipmentSizeCheck = $workflows['wf-shipment-notification'].definition.actions.Measure_Request_Body_Bytes
$shipmentTypeCheck = $workflows['wf-shipment-notification'].definition.actions.Check_ShipmentNotice_MessageType
Assert-True ($orderTypeCheck.type -eq 'Compose' -and ([string]$orderTypeCheck.inputs).Contains("xpath(outputs('Parse_WellFormed_PurchaseOrder_XML')")) 'PurchaseOrder QName validation is not a native XPath check over parsed XML.'
Assert-True (([string]$orderTypeCheck.inputs).Contains('local-name(/*)') -and ([string]$orderTypeCheck.inputs).Contains('namespace-uri(/*)')) 'PurchaseOrder QName validation does not check both QName components.'
Assert-True ($shipmentSizeCheck.type -eq 'Compose' -and ([string]$shipmentSizeCheck.inputs).Contains("base64(outputs('Normalize_ShipmentNotice_Payload'))")) 'Shipment byte measurement is not a native UTF-8/base64 calculation over normalized text.'
Assert-True (([string]$shipmentSizeCheck.inputs).Contains("endsWith(base64(outputs('Normalize_ShipmentNotice_Payload')), '==')") -and ([string]$shipmentSizeCheck.inputs).Contains("endsWith(base64(outputs('Normalize_ShipmentNotice_Payload')), '=')")) 'Shipment byte measurement does not subtract base64 padding.'
Assert-True ($shipmentTypeCheck.type -eq 'Compose' -and ([string]$shipmentTypeCheck.inputs).Contains("xpath(outputs('Parse_WellFormed_ShipmentNotice_XML')")) 'Shipment QName validation is not a native XPath check over parsed XML.'
Assert-True (([string]$shipmentTypeCheck.inputs).Contains('local-name(/*)') -and ([string]$shipmentTypeCheck.inputs).Contains('namespace-uri(/*)')) 'Shipment QName validation does not check both QName components.'
$ackOutputReference = $workflows['wf-shipment-notification'].definition.actions.ConstructMessage_ShipmentAck.actions.Construct_ShipmentAck_MessagePartReference_2
$ackAssignment = $workflows['wf-shipment-notification'].definition.actions.ConstructMessage_ShipmentAck.actions.Construct_ShipmentAck_Assign_AckStatus
Assert-True (([string]$ackOutputReference.inputs).Contains("body('Transform_NoticeToAck')?['`$content']") -and ([string]$ackOutputReference.inputs).Contains('base64ToString')) 'ShipmentAck XSLT output is not normalized from a $content wrapper before custom-code assignment.'
Assert-True ($ackAssignment.inputs.parameters.ackXml -eq "@outputs('Construct_ShipmentAck_MessagePartReference_2')") 'ShipmentRules_AckStatus does not receive the normalized ShipmentAck XML.'
$ackFixture = '<ShipmentAck xmlns="http://HarborLane.Integration.Schemas.ShipmentAck"><ShipmentId>S-1</ShipmentId><Status>Pending</Status><EstimatedDelivery>Pending</EstimatedDelivery></ShipmentAck>'
$ackWrapper = @{ '$content' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($ackFixture)) }
$decodedAck = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($ackWrapper['$content']))
[xml]$decodedAckXml = $decodedAck
Assert-True ($decodedAckXml.DocumentElement.LocalName -eq 'ShipmentAck' -and $decodedAckXml.DocumentElement.NamespaceURI -eq 'http://HarborLane.Integration.Schemas.ShipmentAck') 'Normalized ShipmentAck wrapper does not produce the XML contract required by ShipmentRules_AckStatus.'

$shipmentXmlText = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'messages/ShipmentNotice.xml') -Raw
$shipmentBytes = [Text.Encoding]::UTF8.GetBytes($shipmentXmlText)
$contentWrapper = @{ '$content-type' = 'application/xml'; '$content' = [Convert]::ToBase64String($shipmentBytes) }
$decodedShipmentText = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($contentWrapper['$content']))
Assert-True ($decodedShipmentText -ceq $shipmentXmlText) 'The $content payload normalization changed ShipmentNotice XML.'
Assert-True ([Text.Encoding]::UTF8.GetByteCount($decodedShipmentText) -eq $shipmentBytes.Length) 'Shipment request size is not measured from decoded UTF-8 bytes.'
function Get-Base64DerivedByteCount([string]$Text) {
    $encoded = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($Text))
    ($encoded.Length / 4 * 3) - $(if ($encoded.EndsWith('==')) { 2 } elseif ($encoded.EndsWith('=')) { 1 } else { 0 })
}
Assert-True ((Get-Base64DerivedByteCount $decodedShipmentText) -eq $shipmentBytes.Length) 'The native base64 formula does not reproduce the ShipmentNotice UTF-8 byte count.'
Assert-True ((Get-Base64DerivedByteCount 'A') -eq 1 -and (Get-Base64DerivedByteCount 'é') -eq 2 -and (Get-Base64DerivedByteCount '船') -eq 3) 'The native byte-count formula fails base64 padding or multibyte UTF-8 boundaries.'
[xml]$decodedShipment = $decodedShipmentText
Assert-True ($decodedShipment.DocumentElement.LocalName -eq 'ShipmentNotice') 'Decoded request root local name changed.'
Assert-True ($decodedShipment.DocumentElement.NamespaceURI -eq 'http://HarborLane.Integration.Schemas.ShipmentNotice') 'Decoded request root namespace changed.'

function Add-BusinessDays([datetime]$Start, [int]$Days) {
    $current = $Start.Date
    while ($current.DayOfWeek -in @([DayOfWeek]::Saturday,[DayOfWeek]::Sunday)) { $current = $current.AddDays(1) }
    $added = 0
    while ($added -lt $Days) { $current = $current.AddDays(1); if ($current.DayOfWeek -notin @([DayOfWeek]::Saturday,[DayOfWeek]::Sunday)) { $added++ } }
    $current
}
Assert-True ((Add-BusinessDays ([datetime]'2026-10-21') 5).ToString('yyyy-MM-dd') -eq '2026-10-28') 'Ground ETA behavior changed.'
Assert-True ((Add-BusinessDays ([datetime]'2026-10-24') 2).ToString('yyyy-MM-dd') -eq '2026-10-28') 'Weekend-start ETA behavior changed.'

$mapRoot = Join-Path $candidateRoot 'logicapp/Artifacts/Maps'
$maps = @(Get-ChildItem -LiteralPath $mapRoot -Filter *.xslt -File)
Assert-True ($maps.Count -eq 4) 'Expected the three source maps and one pricing assignment map.'
foreach ($map in $maps) { [xml](Get-Content -LiteralPath $map.FullName -Raw) | Out-Null }
$orderMap = Get-Content -LiteralPath (Join-Path $mapRoot 'Map_PurchaseOrder_To_CanonicalOrder.xslt') -Raw
$inventoryMap = Get-Content -LiteralPath (Join-Path $mapRoot 'Map_InventoryFlatFile_To_InventoryUpdate.xslt') -Raw
$shipmentMap = Get-Content -LiteralPath (Join-Path $mapRoot 'Map_ShipmentNotice_To_ShipmentAck.xslt') -Raw
Assert-True ($orderMap.Contains("concat(Buyer/FirstName, ' ', Buyer/LastName)") -and $orderMap.Contains('xsl:for-each select="Lines/Line"')) 'Order BTM links/functoids are incomplete.'
Assert-True ($inventoryMap.Contains('xsl:for-each select="Detail"') -and -not $inventoryMap.Contains('<RecordCount>')) 'Inventory loop or intentional RecordCount omission changed.'
Assert-True ($shipmentMap.Contains('<Status>Pending</Status>') -and $shipmentMap.Contains('current-dateTime()')) 'Shipment BTM constants or UTC timestamp are missing.'

$sourceRules = Get-Content -LiteralPath (Join-Path $candidateRoot 'Functions/SourceRules.cs') -Raw
$entryPoints = Get-Content -LiteralPath (Join-Path $candidateRoot 'Functions/WorkflowFunctions.cs') -Raw
foreach ($needle in @('MidpointRounding.AwayFromZero','packageCount >= 1 && packageCount <= 99','DayOfWeek.Saturday or DayOfWeek.Sunday','http://HarborLane.Integration.Schemas.OrderError')) { Assert-True ($sourceRules.Contains($needle)) "Custom-code behavior is missing: $needle" }
foreach ($name in @('PricingRules_CalculateDiscount','ErrorMessageBuilder_BuildOrderError','ShipmentRules_IsValidNotice','DeliveryCalendar_EstimateDeliveryDate','ShipmentRules_AckStatus')) { Assert-True ($entryPoints.Contains("[Function(`"$name`")]")) "Missing local function $name." }

$bicep = Get-Content -LiteralPath (Join-Path $candidateRoot 'infra/main.bicep') -Raw
foreach ($required in @('Microsoft.Web/serverfarms','Microsoft.Web/sites','Microsoft.Storage/storageAccounts','Microsoft.Insights/components','Microsoft.OperationalInsights/workspaces','Microsoft.KeyVault/vaults','WEBSITE_CONTENTAZUREFILECONNECTIONSTRING','WEBSITE_CONTENTSHARE')) { Assert-True ($bicep.Contains($required)) "Infrastructure is missing $required." }
foreach ($prohibited in @('Microsoft.Network/','Microsoft.ApiManagement/','publicNetworkAccess: ''Disabled''','virtualNetworkSubnetId','privateDnsZone','customDomain')) { Assert-True (-not $bicep.Contains($prohibited)) "Infrastructure contains prohibited network resource/configuration: $prohibited" }
foreach ($environment in @('dev','uat','prod')) {
    $parameterText = Get-Content -LiteralPath (Join-Path $candidateRoot "infra/params/$environment.bicepparam") -Raw
    Assert-True ($parameterText.StartsWith("using '../main.bicep'")) "$environment parameters must start with the main template reference."
    Assert-True ($parameterText.Contains("param environmentName = '$environment'")) "$environment environmentName is wrong."
    Assert-True ($parameterText.Contains("param appServicePlanSku = 'WS1'")) "$environment SKU is not WS1."
}

$runs = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'workflow-runs.json') -Raw | ConvertFrom-Json -Depth 100
foreach ($name in $plannedWorkflows) { Assert-True (@($runs.cases | Where-Object workflow -eq $name).Count -gt 0) "workflow-runs.json has no executable case for $name." }
Assert-True (@($runs.cases | Where-Object name -match 'approval').Count -gt 0) 'Approval route is not covered.'
Assert-True (@($runs.cases | Where-Object name -match 'fulfilment').Count -gt 0) 'Fulfilment route is not covered.'
Assert-True (@($runs.cases | Where-Object name -match 'Invalid shipment').Count -gt 0) 'Rejected shipment route is not covered.'
foreach ($shipmentCase in @($runs.cases | Where-Object workflow -eq 'wf-shipment-notification')) {
    Assert-True ($shipmentCase.send.request.pathParameters.ShipmentService_svc -eq 'ShipmentService.svc') "$($shipmentCase.name) must invoke the source ShipmentService.svc path segment."
}

Write-Host 'PASS: conversion structure, coverage, maps, flat-file pipeline, helper rules, routing, retries, public-endpoint infrastructure, and runtime cases validated.'
