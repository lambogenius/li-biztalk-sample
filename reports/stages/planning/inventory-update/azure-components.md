# inventory-update — Azure components

Source contract: [azure-components.json](azure-components.json)

- **Flow Id:** inventory-update

## Components

### Item 1

- **Type:** Microsoft.Web/serverfarms

- **Purpose:** Multitenant Workflow Standard plan

- **Sku:** REPLACE_WORKFLOW_STANDARD_SKU

- **Public Network Access:** Enabled

### Item 2

- **Type:** Microsoft.Web/sites

- **Kind:** functionapp,workflowapp

- **Purpose:** Stateful Logic Apps Standard host and local parser function

- **Identity:** SystemAssigned

- **Https Only:** Yes

- **Public Network Access:** Enabled

### Item 3

- **Type:** Microsoft.Storage/storageAccounts

- **Purpose:** Workflow runtime storage and inventory input/output Blob paths

- **Identity Access:** RBAC

- **Public Network Access:** Enabled

#### Containers Or Folders

- REPLACE_INVENTORY_INPUT_CONTAINER/REPLACE_INVENTORY_INPUT_FOLDER

- REPLACE_INVENTORY_OUTPUT_CONTAINER/REPLACE_INVENTORY_OUTPUT_FOLDER

### Item 4

- **Type:** Microsoft.KeyVault/vaults

- **Purpose:** Secrets referenced by app settings if required

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

- blob trigger

- inventory XML upload

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
