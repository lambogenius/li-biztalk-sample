# shipment-notification — Patterns

Source contract: [patterns.json](patterns.json)

- **Flow Id:** shipment-notification

## Patterns

| Name | Implementation | Source Pattern |
| --- | --- | --- |
| HTTPS request-response | Native Request trigger and Response action in one stateful workflow | WCF-WebHttp two-way receive location |
| Validation and enrichment | Distinct ShipmentRules and DeliveryCalendar local implementations | Supplied helper code |
| Response mapping | XSLT followed by status/ETA assignments | BTM plus orchestration assignments |
| Response-before-side-effect | Response precedes accepted-notice archive decision | Send_ShipmentAck before Decide_NoticeAccepted |
| Conditional archive | If true branch uploads original XML with Azure Blob built-in connector | isValid == true FILE send |
| Transport retry | Archive upload retries 3 times at PT5M | BizTalk FILE send retry |
| Managed identity | Workflow identity authorizes Blob and Key Vault | Target security requirement |
