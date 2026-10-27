# Order Intake — Meta

Source contract: [meta.json](meta.json)

- **Id:** order-intake

- **Name:** Order Intake

- **Category:** orchestration

- **Entry Point:** RL_HarborLane_Orders_File

- **Orchestration:** HarborLane.Integration.Orchestrations.OrderIntakeOrchestration

- **Source Path:** src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx

- **Orchestration Artifact Id:** 3fabf49a-3cac-41e2-b455-73edf3780ff7

- **Binding Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Summary:** Consumes PurchaseOrder XML from a FILE receive location, creates and prices CanonicalOrder XML, routes by the original order total, and writes an OrderError document when the processing scope throws.
