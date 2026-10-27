# order-intake — Artifact dispositions

Source contract: [artifact-dispositions.json](artifact-dispositions.json)

- **Flow Id:** order-intake

## Artifacts

| Source Artifact Id | Source | Disposition | Target |
| --- | --- | --- | --- |
| 3fabf49a-3cac-41e2-b455-73edf3780ff7 | OrderIntakeOrchestration.odx | convert | logicapp/wf-order-intake/workflow.json |
| 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd | HarborLane.Integration.BindingInfo.xml | convert | Blob trigger and three Blob uploads; preserve retry and unordered-send semantics |
| be43cc25-a9be-47dd-b01a-cbcdcff49ddf | PurchaseOrder.xsd | retain | logicapp Artifacts/Schemas |
| 09894875-9b3e-4daa-bc15-335bbdc1f92d | CanonicalOrder.xsd | retain | logicapp Artifacts/Schemas |
| 65305d9c-1266-4e93-97ab-53706ac74bde | OrderError.xsd | retain | logicapp Artifacts/Schemas |
| 340189a8-5bd2-4871-b052-086477b58c5d | Map_PurchaseOrder_To_CanonicalOrder.btm | convert | logicapp Artifacts/Maps/Map_PurchaseOrder_To_CanonicalOrder.xslt |
| 0a1efce2-5810-42a5-8d11-a2bb79802259 | PricingRules.cs | convert | dedicated Logic Apps Standard local function |
| 0b7615ea-4911-4e5f-88bb-eed16c14b762 | ErrorMessageBuilder.cs | convert | dedicated Logic Apps Standard local function |
| _Not specified_ | Microsoft.BizTalk.DefaultPipelines.XMLReceive/XMLTransmit | replace | XML validation/serialization and Azure Blob built-in operations |

## Omitted

_None._
