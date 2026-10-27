# Shipment Notification — Meta

Source contract: [meta.json](meta.json)

- **Id:** shipment-notification

- **Name:** Shipment Notification

- **Category:** request-response-orchestration

- **Entry Point:** RL_HarborLane_Shipments_Http

- **Orchestration:** HarborLane.Integration.Orchestrations.ShipmentNotificationOrchestration

- **Source Path:** src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx

- **Orchestration Artifact Id:** 932c2a59-e3c4-4e78-bd9d-3a5fdab0c032

- **Binding Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Summary:** Receives ShipmentNotice XML over HTTPS POST, validates it, calculates a business-day ETA, responds with ShipmentAck XML, and writes only accepted notices to a FILE archive port.
