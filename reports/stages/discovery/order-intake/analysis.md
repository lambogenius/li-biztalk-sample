# Order Intake — Analysis

Source contract: [analysis.json](analysis.json)

- **Summary:** The executable boundary is OrderIntakeOrchestration, activated by the bound order FILE receive location. The flow is synchronous only within the orchestration instance and produces one of two business outputs; exceptions inside Scope_ProcessOrder produce a separate error message.

- **Mermaid Code:** flowchart LR<br>  A["FILE: In/Orders/*.xml"] --> B["XMLReceive"]<br>  B --> C["OrderIntakeOrchestration"]<br>  C --> D["Map PurchaseOrder to CanonicalOrder"]<br>  D --> E["PricingRules.CalculateDiscount"]<br>  E --> F{"OrderTotal >= 5000?"}<br>  F -->\|Yes\| G["FILE: Out/Approval"]<br>  F -->\|No\| H["FILE: Out/Fulfilment"]<br>  C -. "System.Exception" .-> I["ErrorMessageBuilder.BuildOrderError"]<br>  I --> J["FILE: Out/Errors"]

## Message Flow

- PurchaseOrder XML is polled from C:\HarborLane\In\Orders\*.xml through XMLReceive.

- The map creates CanonicalOrder, formatting yyyyMMdd dates, concatenating fields, and copying repeating line items.

- PricingRules.CalculateDiscount calculates DiscountAmount; NetTotal is derived by subtraction.

- OrderTotal >= 5000 goes to SP_HarborLane_Orders_Approval; otherwise it goes to SP_HarborLane_Orders_Fulfilment.

- System.Exception in Scope_ProcessOrder produces OrderError via ErrorMessageBuilder.BuildOrderError and sends it to SP_HarborLane_Orders_Error.

## Component Details

### Entry Point

- **Name:** RL_HarborLane_Orders_File

- **Binding Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

### Orchestration

- **Name:** OrderIntakeOrchestration

- **Artifact Id:** 3fabf49a-3cac-41e2-b455-73edf3780ff7

### Pipelines

- Microsoft.BizTalk.DefaultPipelines.XMLReceive

- Microsoft.BizTalk.DefaultPipelines.XMLTransmit

### Schemas

- PurchaseOrder (be43cc25-a9be-47dd-b01a-cbcdcff49ddf)

- CanonicalOrder (09894875-9b3e-4daa-bc15-335bbdc1f92d)

- OrderError (65305d9c-1266-4e93-97ab-53706ac74bde)

- **Map:** Map_PurchaseOrder_To_CanonicalOrder (340189a8-5bd2-4871-b052-086477b58c5d)

- **Archive Behavior:** No archive behavior is present; failures are written as OrderError documents, which is error handling rather than archival.

## Gaps

- External migration standards and extension resources are not configured.

- Target Azure storage endpoints, connections, identity, and networking are unresolved.

- Terminal handling after FILE send retry exhaustion is unspecified.

- Archive, retention, replay, and purge behavior is absent.

## Patterns

- File-triggered orchestration

- Canonical message mapping

- Content-based routing

- Scoped exception handling

- Transport retry

## Dependency Analysis

### Custom Code

| Class | Method | Source Path | Use |
| --- | --- | --- | --- |
| HarborLane.Integration.Helpers.PricingRules | CalculateDiscount | src/HarborLane.Integration.Helpers/PricingRules.cs | Calculates tier and volume discount in Expr_CalculateDiscount. |
| HarborLane.Integration.Helpers.ErrorMessageBuilder | BuildOrderError | src/HarborLane.Integration.Helpers/ErrorMessageBuilder.cs | Creates schema-conformant OrderError XML with UTC timestamp in Catch_OrderFailure. |

### Transport

- **Receive:** FILE with 60-second polling and XMLReceive

- **Send:** FILE with XMLTransmit; 3 retries at 5-minute intervals

### Source References

- HarborLane.Integration.BindingInfo.xml

- src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx

- src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm
