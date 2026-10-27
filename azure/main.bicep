// Deploys the LI-generated Harbor Lane application (../after/infra/main.bicep) into its own
// resource group. Everything Azure creates for the sample comes from this template: the resource
// group, and through the generated template the Logic App, its plan, storage (with one blob
// container per BizTalk folder), Key Vault, Log Analytics and Application Insights.
// The generated template is used unchanged; this file only creates the resource group and
// passes the values LI left for the owner (REPLACE_* in ../after/README.FIRST.md): the region,
// the blob container and folder that replace each BizTalk file location, and the HTTP status
// for oversize shipment notices. They are the same values as the local test contract,
// ../after/tests/workflow-runs.json.
targetScope = 'subscription'

@description('Resource group for the sample. Delete it to remove everything the sample created.')
param resourceGroupName string = 'rg-li-sample-harborlane-dev-cac'

@description('Azure region for the resource group and every resource in it.')
param location string = 'canadacentral'

@allowed([
  'dev'
  'uat'
  'prod'
])
param environmentName string = 'dev'

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: {
    purpose: 'li-biztalk-sample'
    source: 'https://github.com/lambogenius/li-biztalk-sample'
  }
}

module app '../after/infra/main.bicep' = {
  name: 'harborlane-${environmentName}'
  scope: rg
  params: {
    location: location
    environmentName: environmentName
    appServicePlanSku: 'WS1'
    orderInputContainer: 'orders-in' // C:\HarborLane\In\Orders
    orderInputFolder: 'Orders'
    orderApprovalContainer: 'orders-approval' // C:\HarborLane\Out\Approval
    orderApprovalFolder: 'Approval'
    orderFulfilmentContainer: 'orders-fulfilment' // C:\HarborLane\Out\Fulfilment
    orderFulfilmentFolder: 'Fulfilment'
    orderErrorContainer: 'orders-error' // C:\HarborLane\Out\Errors
    orderErrorFolder: 'Errors'
    inventoryInputContainer: 'inventory-in' // C:\HarborLane\In\Inventory
    inventoryInputFolder: 'Inventory'
    inventoryOutputContainer: 'inventory-out' // C:\HarborLane\Out\Inventory
    inventoryOutputFolder: 'InventoryUpdate'
    shipmentArchiveContainer: 'shipments-archive' // C:\HarborLane\Out\Shipments
    shipmentArchiveFolder: 'Shipments'
    shipmentOversizeStatusCode: '413'
  }
}

output resourceGroupName string = rg.name
output logicAppName string = app.outputs.logicAppResourceName
output storageAccountName string = app.outputs.storageResourceName
