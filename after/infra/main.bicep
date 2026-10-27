targetScope = 'resourceGroup'

@description('Azure region approved for this environment.')
param location string

@description('Environment name used to derive resource names.')
param environmentName string

@allowed(['WS1', 'WS2', 'WS3'])
param appServicePlanSku string = 'WS1'

param orderInputContainer string = 'REPLACE_ORDER_INPUT_CONTAINER'
param orderInputFolder string = 'REPLACE_ORDER_INPUT_FOLDER'
param orderApprovalContainer string = 'REPLACE_ORDER_APPROVAL_CONTAINER'
param orderApprovalFolder string = 'REPLACE_ORDER_APPROVAL_FOLDER'
param orderFulfilmentContainer string = 'REPLACE_ORDER_FULFILMENT_CONTAINER'
param orderFulfilmentFolder string = 'REPLACE_ORDER_FULFILMENT_FOLDER'
param orderErrorContainer string = 'REPLACE_ORDER_ERROR_CONTAINER'
param orderErrorFolder string = 'REPLACE_ORDER_ERROR_FOLDER'
param inventoryInputContainer string = 'REPLACE_INVENTORY_INPUT_CONTAINER'
param inventoryInputFolder string = 'REPLACE_INVENTORY_INPUT_FOLDER'
param inventoryOutputContainer string = 'REPLACE_INVENTORY_OUTPUT_CONTAINER'
param inventoryOutputFolder string = 'REPLACE_INVENTORY_OUTPUT_FOLDER'
param shipmentArchiveContainer string = 'REPLACE_SHIPMENT_ARCHIVE_CONTAINER'
param shipmentArchiveFolder string = 'REPLACE_SHIPMENT_ARCHIVE_FOLDER'
param shipmentOversizeStatusCode string = 'REPLACE_SHIPMENT_OVERSIZE_STATUS_CODE'

var compactEnvironment = toLower(replace(environmentName, '-', ''))
var suffix = uniqueString(resourceGroup().id, environmentName)
var planName = 'asp-harborlane-${environmentName}'
var logicAppName = 'la-harborlane-${environmentName}-${take(suffix, 5)}'
var storageAccountName = take('stharborlane${compactEnvironment}${suffix}', 24)
var logAnalyticsName = 'log-harborlane-${environmentName}'
var appInsightsName = 'appi-harborlane-${environmentName}'
var keyVaultName = take('kv-harborlane-${environmentName}-${suffix}', 24)
var contentShareName = 'harborlane-${compactEnvironment}-content'
var storageConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storage.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storage.listKeys().keys[0].value}'

resource plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: planName
  location: location
  kind: 'elastic'
  sku: { name: appServicePlanSku, tier: 'WorkflowStandard', size: appServicePlanSku, capacity: 1 }
  properties: { reserved: false }
}

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Enabled'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = { parent: storage, name: 'default', properties: {} }
resource fileService 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = { parent: storage, name: 'default', properties: {} }
resource contentShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = { parent: fileService, name: contentShareName, properties: { accessTier: 'TransactionOptimized', shareQuota: 10 } }

resource orderInput 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: orderInputContainer, properties: { publicAccess: 'None' } }
resource orderApproval 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: orderApprovalContainer, properties: { publicAccess: 'None' } }
resource orderFulfilment 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: orderFulfilmentContainer, properties: { publicAccess: 'None' } }
resource orderError 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: orderErrorContainer, properties: { publicAccess: 'None' } }
resource inventoryInput 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: inventoryInputContainer, properties: { publicAccess: 'None' } }
resource inventoryOutput 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: inventoryOutputContainer, properties: { publicAccess: 'None' } }
resource shipmentArchive 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = { parent: blobService, name: shipmentArchiveContainer, properties: { publicAccess: 'None' } }

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsName
  location: location
  properties: { sku: { name: 'PerGB2018' }, retentionInDays: 30, publicNetworkAccessForIngestion: 'Enabled', publicNetworkAccessForQuery: 'Enabled' }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: { Application_Type: 'web', WorkspaceResourceId: logAnalytics.id, publicNetworkAccessForIngestion: 'Enabled', publicNetworkAccessForQuery: 'Enabled' }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: { family: 'A', name: 'standard' }
    enableRbacAuthorization: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enablePurgeProtection: true
    publicNetworkAccess: 'Enabled'
  }
}

resource logicApp 'Microsoft.Web/sites@2024-04-01' = {
  name: logicAppName
  location: location
  kind: 'functionapp,workflowapp'
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'
      alwaysOn: true
      netFrameworkVersion: 'v8.0'
      appSettings: [
        { name: 'FUNCTIONS_EXTENSION_VERSION', value: '~4' }
        { name: 'FUNCTIONS_WORKER_RUNTIME', value: 'dotnet' }
        { name: 'FUNCTIONS_INPROC_NET8_ENABLED', value: '1' }
        { name: 'AzureWebJobsFeatureFlags', value: 'EnableMultiLanguageWorker' }
        { name: 'APP_KIND', value: 'workflowApp' }
        { name: 'AzureWebJobsStorage', value: storageConnectionString }
        { name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING', value: storageConnectionString }
        { name: 'WEBSITE_CONTENTSHARE', value: contentShare.name }
        { name: 'WEBSITE_NODE_DEFAULT_VERSION', value: '~18' }
        { name: 'APPLICATIONINSIGHTS_CONNECTION_STRING', value: appInsights.properties.ConnectionString }
        { name: 'BLOB_STORAGE_ENDPOINT', value: storage.properties.primaryEndpoints.blob }
        { name: 'ORDER_INPUT_CONTAINER', value: orderInputContainer }
        { name: 'ORDER_INPUT_FOLDER', value: orderInputFolder }
        { name: 'ORDER_APPROVAL_CONTAINER', value: orderApprovalContainer }
        { name: 'ORDER_APPROVAL_FOLDER', value: orderApprovalFolder }
        { name: 'ORDER_FULFILMENT_CONTAINER', value: orderFulfilmentContainer }
        { name: 'ORDER_FULFILMENT_FOLDER', value: orderFulfilmentFolder }
        { name: 'ORDER_ERROR_CONTAINER', value: orderErrorContainer }
        { name: 'ORDER_ERROR_FOLDER', value: orderErrorFolder }
        { name: 'INVENTORY_INPUT_CONTAINER', value: inventoryInputContainer }
        { name: 'INVENTORY_INPUT_FOLDER', value: inventoryInputFolder }
        { name: 'INVENTORY_OUTPUT_CONTAINER', value: inventoryOutputContainer }
        { name: 'INVENTORY_OUTPUT_FOLDER', value: inventoryOutputFolder }
        { name: 'SHIPMENT_ARCHIVE_CONTAINER', value: shipmentArchiveContainer }
        { name: 'SHIPMENT_ARCHIVE_FOLDER', value: shipmentArchiveFolder }
        { name: 'SHIPMENT_OVERSIZE_STATUS_CODE', value: shipmentOversizeStatusCode }
      ]
    }
  }
}

resource blobRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storage.id, logicApp.id, 'blob-data-contributor')
  scope: storage
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    principalId: logicApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

resource keyVaultSecretsRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, logicApp.id, 'key-vault-secrets-user')
  scope: keyVault
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')
    principalId: logicApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

output logicAppResourceName string = logicApp.name
output storageResourceName string = storage.name
output keyVaultResourceName string = keyVault.name
