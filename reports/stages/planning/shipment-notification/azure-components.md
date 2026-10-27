# shipment-notification — Azure components

Source contract: [azure-components.json](azure-components.json)

- **Flow Id:** shipment-notification

## Components

### Item 1

- **Type:** Microsoft.Web/serverfarms

- **Purpose:** Multitenant Workflow Standard plan

- **Sku:** REPLACE_WORKFLOW_STANDARD_SKU

- **Public Network Access:** Enabled

### Item 2

- **Type:** Microsoft.Web/sites

- **Kind:** functionapp,workflowapp

- **Purpose:** Stateful Logic Apps Standard HTTP workflow and local helper functions

- **Identity:** SystemAssigned

- **Https Only:** Yes

- **Public Network Access:** Enabled

- **Request Callback Url Shape:** https://<workflow-host>/api/wf-shipment-notification/triggers/Receive_ShipmentNotice/invoke/<relativePath>?api-version=<version>&sig=<secret>

- **Source Relative Path Evidence:** /HarborLaneShipments/ShipmentService.svc/notices is carried as relativePath but is not the complete deployed callback URL

### Item 3

- **Type:** Microsoft.Storage/storageAccounts

- **Purpose:** Workflow runtime storage and accepted-notice Blob archive

- **Identity Access:** RBAC

- **Public Network Access:** Enabled

#### Containers Or Folders

- REPLACE_SHIPMENT_ARCHIVE_CONTAINER/REPLACE_SHIPMENT_ARCHIVE_FOLDER

### Item 4

- **Type:** Microsoft.KeyVault/vaults

- **Purpose:** Secrets referenced by app settings and the SAS-bearing Request-trigger callback URL distributed to authorized callers

- **Authentication:** ManagedIdentity

- **Public Network Access:** Enabled

### Item 5

- **Type:** Microsoft.Insights/components

- **Purpose:** Workflow telemetry

### Item 6

- **Type:** Microsoft.OperationalInsights/workspaces

- **Purpose:** Central logs

## Connections

### Item 1

- **Api:** /serviceProviders/AzureBlob

- **Authentication:** ManagedIdentity

#### Uses

- accepted-notice upload

## Prohibited

- /serviceProviders/FileSystem

- App Service Environment

- virtual network

- subnet

- private endpoint

- private DNS zone

- VNet integration

- API Management

- custom domain

- source-absent caller authentication
