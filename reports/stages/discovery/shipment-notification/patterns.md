# Shipment Notification — Patterns

Source contract: [patterns.json](patterns.json)

| Name | Evidence | Source Path |
| --- | --- | --- |
| HTTPS request-response | WCF-WebHttp maps SubmitNotice to POST /notices and the orchestration sends ShipmentAck on the same two-way port. | HarborLane.Integration.BindingInfo.xml |
| Validation and enrichment | Expr_ValidateAndComputeEta invokes supplied helper code for validation and business-day ETA calculation. | src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx |
| Response mapping | Map_ShipmentNotice_To_ShipmentAck maps identifiers and UTC receipt time; orchestration assigns final status and ETA. | src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm |
| Conditional archive | Decide_NoticeAccepted sends the original notice to SP_HarborLane_Shipments_Archive only when isValid is true. | src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx |
| Transport retry | The archive FILE send port specifies RetryCount 3 and RetryInterval 5; ordered delivery and stop-on-failure are false. | HarborLane.Integration.BindingInfo.xml |
