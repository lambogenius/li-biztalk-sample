# Order Intake — Patterns

Source contract: [patterns.json](patterns.json)

| Name | Evidence | Source Path |
| --- | --- | --- |
| File-triggered orchestration | RL_HarborLane_Orders_File activates Receive_PurchaseOrder. | HarborLane.Integration.BindingInfo.xml |
| Canonical message mapping | Map_PurchaseOrder_To_CanonicalOrder transforms PurchaseOrder to CanonicalOrder before business logic. | src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm |
| Content-based routing | Decide_ApprovalRequired sends OrderTotal >= 5000 to approval and all other orders to fulfilment. | src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx |
| Scoped exception handling | Catch_OrderFailure catches System.Exception, constructs OrderError, and sends it to a dedicated error port. | src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx |
| Transport retry | All three FILE send ports specify RetryCount 3 and RetryInterval 5; ordered delivery and stop-on-failure are false. | HarborLane.Integration.BindingInfo.xml |
