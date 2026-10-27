# Shipment Notification — Analysis

Source contract: [analysis.json](analysis.json)

- **Summary:** ShipmentNotificationOrchestration implements one request-response entry point. Every request receives an Accepted or Rejected acknowledgement when normal processing completes; only validated notices are subsequently sent to the FILE archive port.

- **Mermaid Code:** flowchart LR<br>  A["Carrier HTTPS POST /notices"] --> B["XMLReceive"]<br>  B --> C["ShipmentNotificationOrchestration"]<br>  C --> D["ShipmentRules.IsValidNotice"]<br>  C --> E["DeliveryCalendar.EstimateDeliveryDate"]<br>  D --> F["Map Notice to Ack"]<br>  E --> F<br>  F --> G["ShipmentRules.AckStatus"]<br>  G --> H["HTTP ShipmentAck response"]<br>  D --> I{"isValid?"}<br>  I -->\|Yes\| J["FILE: Out/Shipments archive"]<br>  I -->\|No\| K["No archive"]

## Message Flow

- A carrier POSTs ShipmentNotice XML to /HarborLaneShipments/ShipmentService.svc/notices.

- IsValidNotice checks shipment id, tracking-number length, and package-count range; EstimateDeliveryDate adds service-level business days while skipping weekends.

- Map_ShipmentNotice_To_ShipmentAck copies identifiers and stamps UTC ReceivedAt; orchestration assigns Accepted/Rejected status and ETA.

- ShipmentAck is returned on the two-way port.

- After the reply, isValid == true causes the original ShipmentNotice to be written by SP_HarborLane_Shipments_Archive; rejected notices are not archived.

## Component Details

### Entry Point

- **Name:** RL_HarborLane_Shipments_Http

- **Binding Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Method:** POST

- **Url:** /HarborLaneShipments/ShipmentService.svc/notices

### Orchestration

- **Name:** ShipmentNotificationOrchestration

- **Artifact Id:** 932c2a59-e3c4-4e78-bd9d-3a5fdab0c032

### Pipelines

- Microsoft.BizTalk.DefaultPipelines.XMLReceive

- Microsoft.BizTalk.DefaultPipelines.XMLTransmit

### Schemas

- ShipmentNotice (86609c47-41a2-4823-8165-bcb24c2632c5)

- ShipmentAck (d6ea3ebe-4481-4f01-a6aa-c6555214e101)

- **Map:** Map_ShipmentNotice_To_ShipmentAck (ccf378ed-8b47-4221-adeb-0c4fde245709)

- **Archive Behavior:** Only valid notices are archived, as the original ShipmentNotice XML, to SP_HarborLane_Shipments_Archive after the HTTP acknowledgement is sent. No retention or purge policy is evidenced.

## Gaps

- External migration standards and extension resources are not configured.

- Target public hostname, certificate, DNS, ingress, authorization, identity, and throttling equivalents are unresolved.

- Target archive storage and lifecycle policy are unresolved.

- No HTTP fault contract or terminal archive-failure handling is defined.

- Response-before-archive failure semantics require confirmation.

## Patterns

- HTTPS request-response

- Validation and enrichment

- Response mapping

- Conditional archive

- Transport retry

## Dependency Analysis

### Custom Code

| Class | Method | Source Path | Use |
| --- | --- | --- | --- |
| HarborLane.Integration.Helpers.ShipmentRules | IsValidNotice | src/HarborLane.Integration.Helpers/ShipmentRules.cs | Validates shipment id, tracking number, and package count in Expr_ValidateAndComputeEta. |
| HarborLane.Integration.Helpers.DeliveryCalendar | EstimateDeliveryDate | src/HarborLane.Integration.Helpers/DeliveryCalendar.cs | Computes the yyyy-MM-dd ETA using service-level business days and weekend exclusion. |
| HarborLane.Integration.Helpers.ShipmentRules | AckStatus | src/HarborLane.Integration.Helpers/ShipmentRules.cs | Converts the validation Boolean to Accepted or Rejected in Assign_AckStatus. |

### Transport

- **Receive:** WCF-WebHttp POST over Transport security, no client credential, XMLReceive

- **Response:** XMLTransmit with a one-minute send timeout

- **Archive:** FILE with XMLTransmit; 3 retries at 5-minute intervals

### Source References

- HarborLane.Integration.BindingInfo.xml

- src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx

- src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm
