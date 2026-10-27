# shipment-notification — Artifact dispositions

Source contract: [artifact-dispositions.json](artifact-dispositions.json)

- **Flow Id:** shipment-notification

## Artifacts

| Source Artifact Id | Source | Disposition | Target |
| --- | --- | --- | --- |
| 932c2a59-e3c4-4e78-bd9d-3a5fdab0c032 | ShipmentNotificationOrchestration.odx | convert | logicapp/wf-shipment-notification/workflow.json |
| 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd | HarborLane.Integration.BindingInfo.xml | convert | Request/Response contract and conditional Blob upload |
| 86609c47-41a2-4823-8165-bcb24c2632c5 | ShipmentNotice.xsd | retain | logicapp Artifacts/Schemas |
| d6ea3ebe-4481-4f01-a6aa-c6555214e101 | ShipmentAck.xsd | retain | logicapp Artifacts/Schemas |
| ccf378ed-8b47-4221-adeb-0c4fde245709 | Map_ShipmentNotice_To_ShipmentAck.btm | convert | logicapp Artifacts/Maps/Map_ShipmentNotice_To_ShipmentAck.xslt |
| f55951bb-a9ef-4521-82b1-949162d8261b | ShipmentRules.cs | convert | dedicated ShipmentRules local implementation |
| cf84db1c-883c-4821-a8a5-34fc188d8388 | DeliveryCalendar.cs | convert | dedicated DeliveryCalendar local implementation |
| _Not specified_ | Microsoft.BizTalk.DefaultPipelines.XMLReceive/XMLTransmit | replace | XML validation/serialization, Request/Response, and Azure Blob upload |
| _Not specified_ | WCF ServiceBehavior and EndpointBehavior | no-custom-code | No blocker: binding contains empty named behavior elements and repository states no custom WCF behaviors are used |

## Omitted

_None._
