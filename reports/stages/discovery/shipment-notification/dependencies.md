# Shipment Notification — Dependencies

Source contract: [dependencies.json](dependencies.json)

## Schemas

- 86609c47-41a2-4823-8165-bcb24c2632c5

- d6ea3ebe-4481-4f01-a6aa-c6555214e101

## Maps

- ccf378ed-8b47-4221-adeb-0c4fde245709

## Bindings

### Item 1

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

#### Ports

- RP_HarborLane_Shipments_Http

- SP_HarborLane_Shipments_Archive

## Custom Code

| Class | Method | Artifact Id | Source Path | Orchestration | Use |
| --- | --- | --- | --- | --- | --- |
| HarborLane.Integration.Helpers.ShipmentRules | IsValidNotice | f55951bb-a9ef-4521-82b1-949162d8261b | src/HarborLane.Integration.Helpers/ShipmentRules.cs | src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx | Returns true only when shipment id is nonblank, trimmed tracking number has at least 8 characters, and package count is 1 through 99. |
| HarborLane.Integration.Helpers.DeliveryCalendar | EstimateDeliveryDate | cf84db1c-883c-4821-a8a5-34fc188d8388 | src/HarborLane.Integration.Helpers/DeliveryCalendar.cs | src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx | Adds business days to ShipDate, skipping weekends, using 2 days for Express, 8 for Freight, and 5 for Ground or unknown service levels; returns yyyy-MM-dd. |
| HarborLane.Integration.Helpers.ShipmentRules | AckStatus | f55951bb-a9ef-4521-82b1-949162d8261b | src/HarborLane.Integration.Helpers/ShipmentRules.cs | src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx | Returns Accepted for true validation and Rejected for false validation, assigning ShipmentAck.Status. |

## External Systems

| Type | Role | Address |
| --- | --- | --- |
| https-client | request-response | /HarborLaneShipments/ShipmentService.svc/notices |
| file-system | accepted-notice-archive | C:\HarborLane\Out\Shipments\%MessageID%.xml |
