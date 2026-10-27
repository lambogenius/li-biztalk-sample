# Shipment Notification — Components

Source contract: [components.json](components.json)

## Item 1

- **Kind:** receive-location

- **Name:** RL_HarborLane_Shipments_Http

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Receive Port:** RP_HarborLane_Shipments_Http

- **Two Way:** Yes

- **Adapter:** WCF-WebHttp

- **Base Address:** /HarborLaneShipments/ShipmentService.svc

- **Operation:** SubmitNotice

- **Method:** POST

- **Relative Url:** /notices

- **Security Mode:** Transport

- **Client Credential Type:** None

- **Content Type:** application/xml

- **Max Received Message Size:** 65536

- **Max Concurrent Calls:** 200

- **Receive Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLReceive

- **Send Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Open Close Send Timeout:** 00:01:00

- **Include Exception Detail In Faults:** No

- **Suspend Message On Failure:** No

## Item 2

- **Kind:** orchestration

- **Name:** ShipmentNotificationOrchestration

- **Artifact Id:** 932c2a59-e3c4-4e78-bd9d-3a5fdab0c032

- **Source Path:** src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx

### Details

- **Activation Receive:** Receive_ShipmentNotice

- **Request Response Operation:** Operation_SubmitNotice

- **Archive Decision:** isValid == true

## Item 3

- **Kind:** schema

- **Name:** ShipmentNotice

- **Artifact Id:** 86609c47-41a2-4823-8165-bcb24c2632c5

- **Source Path:** src/HarborLane.Integration.Schemas/ShipmentNotice.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.ShipmentNotice

## Item 4

- **Kind:** map

- **Name:** Map_ShipmentNotice_To_ShipmentAck

- **Artifact Id:** ccf378ed-8b47-4221-adeb-0c4fde245709

- **Source Path:** src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm

### Details

- **Source:** ShipmentNotice

- **Target:** ShipmentAck

- **Behavior:** Copies ShipmentId and OrderNumber, initializes Status to Pending, and stamps ReceivedAt with current UTC time; orchestration then overwrites Status and EstimatedDelivery.

## Item 5

- **Kind:** schema

- **Name:** ShipmentAck

- **Artifact Id:** d6ea3ebe-4481-4f01-a6aa-c6555214e101

- **Source Path:** src/HarborLane.Integration.Schemas/ShipmentAck.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.ShipmentAck

## Item 6

- **Kind:** custom-code

- **Name:** ShipmentRules

- **Artifact Id:** f55951bb-a9ef-4521-82b1-949162d8261b

- **Source Path:** src/HarborLane.Integration.Helpers/ShipmentRules.cs

### Details

#### Called Methods

- IsValidNotice

- AckStatus

## Item 7

- **Kind:** custom-code

- **Name:** DeliveryCalendar

- **Artifact Id:** cf84db1c-883c-4821-a8a5-34fc188d8388

- **Source Path:** src/HarborLane.Integration.Helpers/DeliveryCalendar.cs

### Details

- **Called Method:** EstimateDeliveryDate

## Item 8

- **Kind:** send-port

- **Name:** SP_HarborLane_Shipments_Archive

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Adapter:** FILE

- **Address:** C:\HarborLane\Out\Shipments\%MessageID%.xml

- **Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Retry Count:** 3

- **Retry Interval Minutes:** 5

- **Condition:** isValid == true
