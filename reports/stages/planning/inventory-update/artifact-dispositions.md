# inventory-update — Artifact dispositions

Source contract: [artifact-dispositions.json](artifact-dispositions.json)

- **Flow Id:** inventory-update

## Artifacts

| Source Artifact Id | Source | Disposition | Target |
| --- | --- | --- | --- |
| 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd | HarborLane.Integration.BindingInfo.xml | convert | Blob trigger, dedicated workflow subscription boundary, and Blob upload |
| 8b374df5-c3df-49e4-8c0d-70c8f0758e66 | InventoryFlatFileReceive.btp | convert | built-in Logic Apps Standard Flat File Decoding action configured with InventoryFlatFile.xsd |
| 34872ed2-8c16-4108-bc40-3fe72970de23 | InventoryFlatFile.xsd | retain | logicapp Artifacts/Schemas and parser contract |
| 6c00b69b-2efc-4e0b-a722-6b017ac04c9f | Map_InventoryFlatFile_To_InventoryUpdate.btm | convert | logicapp Artifacts/Maps/Map_InventoryFlatFile_To_InventoryUpdate.xslt |
| b64dd345-a34a-440a-99ee-889a021cfcce | InventoryUpdate.xsd | retain | logicapp Artifacts/Schemas |
| _Not specified_ | Microsoft.BizTalk.DefaultPipelines.XMLTransmit | replace | XML serialization and Azure Blob built-in upload |

## Omitted

_None._
