# order-intake — Coverage orchestration a87839b083d1

Source contract: [coverage-orchestration-a87839b083d1.json](coverage-orchestration-a87839b083d1.json)

- **Source:** src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx

- **Source Hash:** 587297c992056e70fd2dd6759f8a7ebdcc899869297ebbf699a8cc30d69d8d17

## Workflow Files

- logicapp/wf-order-intake/workflow.json

## Blockers

_None._

## Blocker Gaps

_None._

## Steps

| Source Id | Workflow File | Target Pointer | Target Action Type | Rationale |
| --- | --- | --- | --- | --- |
| 8c7e1ce4-1f6a-409c-a92a-6290897a732b | logicapp/wf-order-intake/workflow.json | /definition/triggers/Receive_PurchaseOrder | ServiceProvider | The activating FILE receive becomes the workflow's sole Azure Blob built-in polling trigger. |
| 1c280d3e-561c-40e0-97a1-1805aa7ea77c | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder | Scope | Owns ordered processing and the nested failure handler. |
| 8870709a-5246-4639-8dec-62fd576ff7e5 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder | Scope | Groups canonical message construction actions. |
| c9073b80-ed71-4a1d-b70a-78f8d5ae640b | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder/actions/Transform_PurchaseOrderToCanonical | Xslt | Runs the converted PurchaseOrder-to-CanonicalOrder map. |
| 49d904fd-51e6-47c6-b07b-dc2cd72cb0b2 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder/actions/Construct_CanonicalOrder_MessagePartReference_1 | Compose | Supplies PurchaseOrderMsg as the unique transform input reference. |
| 77618953-288a-40ab-8531-fe4a171ef064 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder/actions/Construct_CanonicalOrder_MessagePartReference_2 | Compose | Captures CanonicalOrderMsg as the unique transform output reference. |
| 284ee37f-aee7-4652-ad4a-4f8fc7e77657 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_CanonicalOrder/actions/Construct_CanonicalOrder_MessageRef | Compose | Commits the constructed CanonicalOrderMsg with a construct-prefixed unique action name. |
| 59df1065-9bfa-4f9b-8a24-877a2c302ef5 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Expr_CalculateDiscount | InvokeFunction | Calls the dedicated supplied PricingRules implementation and computes net total. |
| 37794941-da90-4668-b298-08f61436139e | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_PricedOrder | Scope | Groups priced-order copy and assignments. |
| 2b8c9f3d-a334-4806-9055-c9b688b4167d | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_PricedOrder/actions/Construct_PricedOrder_Assign_PricedOrder | Compose | Copies CanonicalOrderMsg and assigns DiscountAmount and NetTotal. |
| a8c3e340-a4bf-4b57-865e-1576ab2c0b9c | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/ConstructMessage_PricedOrder/actions/Construct_PricedOrder_MessageRef | Compose | Commits PricedOrderMsg under a construct-prefixed unique name. |
| e92438fa-25f3-4c07-8ad9-29f34b6f0d39 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired | If | Branches on OrderTotal >= 5000. |
| 5a954666-5d13-44a0-a186-362d2f605bed | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired | If | The manual-approval branch is the true branch of its owning If. |
| 455c9b8a-5788-4d21-9fd1-169f6d36f47d | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired/actions/Send_ToApproval | ServiceProvider | Uploads the priced XML to the configured approval Blob path with source-equivalent retries. |
| db5d7488-c519-474b-b9a9-4dbf12c3bb74 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired | If | The source Else branch is the else branch of its owning If. |
| e6d99d57-59b2-4c8b-96f3-9d4f3eed7079 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Decide_ApprovalRequired/else/actions/Send_ToFulfilment | ServiceProvider | Uploads the priced XML to the configured fulfilment Blob path with source-equivalent retries. |
| 0bd7cb54-5a87-450c-89c2-100badaa9392 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure | Scope | Nested failure scope runs after failed, timed-out, or skipped processing actions. |
| 218ebf57-ff80-4e44-8e9f-0912530b622b | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure/actions/ConstructMessage_OrderError | Scope | Groups OrderError construction actions in the catch path. |
| 508ddaa3-0055-4257-8628-0e0da92a0342 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure/actions/ConstructMessage_OrderError/actions/Construct_OrderError_Assign_OrderError | InvokeFunction | Calls the dedicated supplied ErrorMessageBuilder implementation. |
| e2d26188-b7e3-4c14-8f2a-1d2b1e009034 | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure/actions/ConstructMessage_OrderError/actions/Construct_OrderError_MessageRef | Compose | Commits OrderErrorMsg with a construct-prefixed unique action name. |
| 4d68cc63-6692-4ae9-8377-43838d49a6db | logicapp/wf-order-intake/workflow.json | /definition/actions/Scope_ProcessOrder/actions/Catch_OrderFailure/actions/Send_OrderError | ServiceProvider | Uploads schema-valid OrderError XML to the configured error Blob path with source-equivalent retries. |
