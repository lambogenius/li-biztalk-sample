# shipment-notification — Workflow shipment notification

Source contract: [workflow-shipment-notification.json](workflow-shipment-notification.json)

- **Name:** wf-shipment-notification

- **Runtime Path:** logicapp/wf-shipment-notification/workflow.json

- **Kind:** Stateful

## Source Artifact Ids

- 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- 932c2a59-e3c4-4e78-bd9d-3a5fdab0c032

- 86609c47-41a2-4823-8165-bcb24c2632c5

- d6ea3ebe-4481-4f01-a6aa-c6555214e101

- ccf378ed-8b47-4221-adeb-0c4fde245709

- f55951bb-a9ef-4521-82b1-949162d8261b

- cf84db1c-883c-4821-a8a5-34fc188d8388

## Trigger

- **Name:** Receive_ShipmentNotice

- **Type:** Request

- **Method:** POST

- **Relative Path:** HarborLaneShipments/ShipmentService.svc/notices

- **Content Type:** application/xml

- **Callback Url Shape:** https://<workflow-host>/api/wf-shipment-notification/triggers/Receive_ShipmentNotice/invoke/<relativePath>?api-version=<version>&sig=<secret>

- **Authentication:** Platform Request-trigger SAS signature only; no added application-level caller identity

- **Https Only:** Yes

## Actions

### Item 1

- **Name:** Measure_Request_Body_Bytes

- **Type:** JavaScriptCode

- **Behavior:** Return the UTF-8 byte count of the raw request body without parsing it

### Item 2

- **Name:** Check_Request_Size

- **Type:** If

#### Run After

##### Measure Request Body Bytes

- Succeeded

- **Expression:** outputs('Measure_Request_Body_Bytes') > 65536

#### True Actions

- Reject_Oversize_Request

- Stop_Oversize_Request

- **False Action:** Continue

### Item 3

- **Name:** Reject_Oversize_Request

- **Type:** Response

- **Parent:** Check_Request_Size/actions

- **Status Code:** owner-approved fail-closed status

- **Body:** No exception details; exact contract is gated by shipment-fault-contract

### Item 4

- **Name:** Stop_Oversize_Request

- **Type:** Terminate

- **Parent:** Check_Request_Size/actions

#### Run After

##### Reject Oversize Request

- Succeeded

- **Status:** Failed

- **Message:** Request exceeds the source 65536-byte maximum; no exception detail is returned to the caller

### Item 5

- **Name:** Check_ShipmentNotice_MessageType

- **Type:** JavaScriptCode

#### Run After

##### Check Request Size

- Succeeded

- **Behavior:** Parse well-formed XML and require root QName {http://HarborLane.Integration.Schemas.ShipmentNotice}ShipmentNotice; do not perform strict XSD validation

### Item 6

- **Name:** Expr_ValidateAndComputeEta

- **Type:** Scope

#### Run After

##### Check Shipment Notice Message Type

- Succeeded

#### Children

- Validate_ShipmentNotice

- Compute_EstimatedDelivery

### Item 7

- **Name:** Validate_ShipmentNotice

- **Type:** InvokeFunction

- **Parent:** Expr_ValidateAndComputeEta

- **Function:** ShipmentRules_IsValidNotice

### Item 8

- **Name:** Compute_EstimatedDelivery

- **Type:** InvokeFunction

- **Parent:** Expr_ValidateAndComputeEta

- **Function:** DeliveryCalendar_EstimateDeliveryDate

### Item 9

- **Name:** ConstructMessage_ShipmentAck

- **Type:** Scope

#### Children

- Transform_NoticeToAck

- Construct_ShipmentAck_MessagePartReference_1

- Construct_ShipmentAck_MessagePartReference_2

- Construct_ShipmentAck_Assign_AckStatus

- Construct_ShipmentAck_MessageRef

### Item 10

- **Name:** Transform_NoticeToAck

- **Type:** Xslt

- **Parent:** ConstructMessage_ShipmentAck

- **Map:** Map_ShipmentNotice_To_ShipmentAck.xslt

### Item 11

- **Name:** Construct_ShipmentAck_Assign_AckStatus

- **Type:** InvokeFunction

- **Parent:** ConstructMessage_ShipmentAck

- **Function:** ShipmentRules_AckStatus

- **Also Assign:** EstimatedDelivery

### Item 12

- **Name:** Send_ShipmentAck

- **Type:** Response

- **Status Code:** 200

- **Content Type:** application/xml

- **Timeout Objective:** PT1M

### Item 13

- **Name:** Decide_NoticeAccepted

- **Type:** If

- **Expression:** isValid == true

- **True Action:** Send_NoticeToFolder

- **False Action:** None

### Item 14

- **Name:** Send_NoticeToFolder

- **Type:** ServiceProvider

- **Parent:** Decide_NoticeAccepted/actions

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** uploadBlob

- **Payload:** original ShipmentNotice XML

#### Retry

- **Type:** fixed

- **Count:** 3

- **Interval:** PT5M

- **Ordering:** Measure_Request_Body_Bytes runs first, then Check_Request_Size. Oversize input returns Reject_Oversize_Request and Stop_Oversize_Request terminates the run; only a succeeded size check permits the top-level XML well-formedness/root-QName check. The workflow then sequentially computes, constructs, responds, and conditionally archives. Exactly one Request trigger activates the workflow; branches add no trigger.

- **Retry Error Behavior:** Archive upload retries three times at five-minute intervals after the response. Unexpected errors fail closed without exception details; exact fault response and terminal archive operations are gates.

## Inputs

| Name | Format | Message Type | Runtime Validation | Source |
| --- | --- | --- | --- | --- |
| ShipmentNotice | XML | {http://HarborLane.Integration.Schemas.ShipmentNotice}ShipmentNotice | maximum 65536 body bytes plus well-formed XML/root QName; no strict XSD validation | HTTPS Request-trigger callback body |

## Outputs

| Name | Format | Schema | Destination | Condition |
| --- | --- | --- | --- | --- |
| ShipmentAck | XML | ShipmentAck.xsd | HTTP response | _Not specified_ |
| ShipmentNotice | _Not specified_ | _Not specified_ | configured archive Blob path | isValid == true |

## Configuration Needs

- REPLACE_SHIPMENT_ARCHIVE_CONTAINER

- REPLACE_SHIPMENT_ARCHIVE_FOLDER

- managed identity Blob RBAC

- Key Vault secret containing the deployed SAS-bearing callback URL for authorized callers

- environment-generated HTTPS hostname

- owner-approved oversize/malformed fault responses

## Network

- **Public Endpoints:** Yes

- **Https Only:** Yes

- **Caller Authentication:** Platform Request-trigger SAS signature; no additional application-level caller identity

- **Private Networking:** No

- **Recommendation:** Owner may evaluate IP restrictions, private ingress, or stronger caller authentication only as a separately approved hardening change.
