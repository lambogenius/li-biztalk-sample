# Read this first: placeholders to replace

This repository still contains 18 `REPLACE_*` placeholders. Replace each one with its real value, per environment where the name says so, before you build or deploy. Line numbers are as generated and move as files change.

The deployment package in `deployment-package/` holds copies of these files with the same placeholders. Replace them here, then rebuild the package.

| Placeholder | Purpose | Locations |
| --- | --- | --- |
| `REPLACE_AZURE_LOCATION_DEV` | The approved Azure region name; the application owner or platform team supplies it and it may differ by environment. | `infra/params/dev.bicepparam:3` |
| `REPLACE_AZURE_LOCATION_PROD` | The approved Azure region name; the application owner or platform team supplies it and it may differ by environment. | `infra/params/prod.bicepparam:3` |
| `REPLACE_AZURE_LOCATION_UAT` | The approved Azure region name; the application owner or platform team supplies it and it may differ by environment. | `infra/params/uat.bicepparam:3` |
| `REPLACE_INVENTORY_INPUT_CONTAINER` | The Blob container replacing C:\HarborLane\In\Inventory; the application owner supplies it and it may differ by environment. | `infra/main.bicep:20` |
| `REPLACE_INVENTORY_INPUT_FOLDER` | The folder prefix within the inventory input container; the application owner supplies it and it may differ by environment. | `infra/main.bicep:21` |
| `REPLACE_INVENTORY_OUTPUT_CONTAINER` | The Blob container replacing C:\HarborLane\Out\Inventory; the application owner supplies it and it may differ by environment. | `infra/main.bicep:22` |
| `REPLACE_INVENTORY_OUTPUT_FOLDER` | The folder prefix within the inventory output container; the application owner supplies it and it may differ by environment. | `infra/main.bicep:23` |
| `REPLACE_ORDER_APPROVAL_CONTAINER` | The Blob container replacing C:\HarborLane\Out\Approval; the application owner supplies it and it may differ by environment. | `infra/main.bicep:14` |
| `REPLACE_ORDER_APPROVAL_FOLDER` | The folder prefix within the order approval container; the application owner supplies it and it may differ by environment. | `infra/main.bicep:15` |
| `REPLACE_ORDER_ERROR_CONTAINER` | The Blob container replacing C:\HarborLane\Out\Errors; the application owner supplies it and it may differ by environment. | `infra/main.bicep:18` |
| `REPLACE_ORDER_ERROR_FOLDER` | The folder prefix within the order error container; the application owner supplies it and it may differ by environment. | `infra/main.bicep:19` |
| `REPLACE_ORDER_FULFILMENT_CONTAINER` | The Blob container replacing C:\HarborLane\Out\Fulfilment; the application owner supplies it and it may differ by environment. | `infra/main.bicep:16` |
| `REPLACE_ORDER_FULFILMENT_FOLDER` | The folder prefix within the order fulfilment container; the application owner supplies it and it may differ by environment. | `infra/main.bicep:17` |
| `REPLACE_ORDER_INPUT_CONTAINER` | The Blob container replacing C:\HarborLane\In\Orders; the application owner supplies it and it may differ by environment. | `infra/main.bicep:12` |
| `REPLACE_ORDER_INPUT_FOLDER` | The folder prefix within the order input container replacing the source Orders folder; the application owner supplies it and it may differ by environment. | `infra/main.bicep:13` |
| `REPLACE_SHIPMENT_ARCHIVE_CONTAINER` | The Blob container replacing C:\HarborLane\Out\Shipments; the application owner supplies it and it may differ by environment. | `infra/main.bicep:24` |
| `REPLACE_SHIPMENT_ARCHIVE_FOLDER` | The folder prefix within the shipment archive container; the application owner supplies it and it may differ by environment. | `infra/main.bicep:25` |
| `REPLACE_SHIPMENT_OVERSIZE_STATUS_CODE` | The owner-approved fail-closed HTTP status for requests over 65536 bytes, resolving planning gap shipment-fault-contract; the application owner supplies it and it may differ by environment. | `infra/main.bicep:26` |
