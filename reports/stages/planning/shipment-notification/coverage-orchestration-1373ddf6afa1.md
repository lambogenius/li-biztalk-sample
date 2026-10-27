# shipment-notification — Coverage orchestration 1373ddf6afa1

Source contract: [coverage-orchestration-1373ddf6afa1.json](coverage-orchestration-1373ddf6afa1.json)

- **Source:** src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx

- **Source Hash:** 0b34d3292cb617911c5172f11659b81ab54faf1db317ed9b8c9c134c109999cf

## Workflow Files

- logicapp/wf-shipment-notification/workflow.json

## Blockers

_None._

## Blocker Gaps

_None._

## Steps

| Source Id | Workflow File | Target Pointer | Target Action Type | Rationale |
| --- | --- | --- | --- | --- |
| d1d0ea0e-7c30-447a-b96c-9af1948c2765 | logicapp/wf-shipment-notification/workflow.json | /definition/triggers/Receive_ShipmentNotice | Request | The activating two-way WCF-WebHttp receive becomes the workflow's sole Request trigger. |
| 89eabd48-046c-40a9-9e38-29da4cca3750 | logicapp/wf-shipment-notification/workflow.json | /definition/actions/Expr_ValidateAndComputeEta | Scope | Groups the two distinct supplied helper invocations while preserving their ordered variable assignments. |
| 6a2500f4-e96f-4b04-a5ad-aaa92c3ca95f | logicapp/wf-shipment-notification/workflow.json | /definition/actions/ConstructMessage_ShipmentAck | Scope | Groups acknowledgement construction actions. |
| 778b029d-f23e-4ca6-9de5-290e310bb8ff | logicapp/wf-shipment-notification/workflow.json | /definition/actions/ConstructMessage_ShipmentAck/actions/Transform_NoticeToAck | Xslt | Runs the converted ShipmentNotice-to-ShipmentAck map. |
| 533038ca-d2dd-429c-928e-497bd4178f3e | logicapp/wf-shipment-notification/workflow.json | /definition/actions/ConstructMessage_ShipmentAck/actions/Construct_ShipmentAck_MessagePartReference_1 | Compose | Supplies ShipmentNoticeMsg as the uniquely named transform input reference. |
| bbfd2e92-f3a6-448c-957e-854d8105eeca | logicapp/wf-shipment-notification/workflow.json | /definition/actions/ConstructMessage_ShipmentAck/actions/Construct_ShipmentAck_MessagePartReference_2 | Compose | Captures ShipmentAckMsg as the uniquely named transform output reference. |
| f0e6d40c-29ce-430a-998d-3979e4f31d8a | logicapp/wf-shipment-notification/workflow.json | /definition/actions/ConstructMessage_ShipmentAck/actions/Construct_ShipmentAck_Assign_AckStatus | InvokeFunction | Calls supplied ShipmentRules.AckStatus and assigns EstimatedDelivery. |
| b4129c27-0dcd-4503-ac2a-8c0abacd3d37 | logicapp/wf-shipment-notification/workflow.json | /definition/actions/ConstructMessage_ShipmentAck/actions/Construct_ShipmentAck_MessageRef | Compose | Commits ShipmentAckMsg with a construct-prefixed unique action name. |
| 118abb97-6f4f-4807-b594-e26b58244db7 | logicapp/wf-shipment-notification/workflow.json | /definition/actions/Send_ShipmentAck | Response | Returns the XML acknowledgement on the same request-response workflow before archive processing. |
| d3fe9ade-e0c0-4eaf-8597-6e8755d8337a | logicapp/wf-shipment-notification/workflow.json | /definition/actions/Decide_NoticeAccepted | If | Branches on isValid after the response. |
| 79a50232-5828-434f-bc40-4f5c450493c9 | logicapp/wf-shipment-notification/workflow.json | /definition/actions/Decide_NoticeAccepted | If | The valid-notice source branch is the true branch of its owning If. |
| e666384c-8ef4-40ec-a88f-d2c16bfc9712 | logicapp/wf-shipment-notification/workflow.json | /definition/actions/Decide_NoticeAccepted/actions/Send_NoticeToFolder | ServiceProvider | Uploads the original accepted notice to Azure Blob with source-equivalent retries. |
| 99f2031c-e319-4ade-b2e1-4983ec528464 | logicapp/wf-shipment-notification/workflow.json | /definition/actions/Decide_NoticeAccepted | If | The source Else branch maps to the empty else branch of its owning If, preserving no-archive behavior. |
