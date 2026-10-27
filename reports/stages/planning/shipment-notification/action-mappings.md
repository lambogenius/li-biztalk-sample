# shipment-notification — Action mappings

Source contract: [action-mappings.json](action-mappings.json)

- **Flow Id:** shipment-notification

## Mappings

### Item 1

- **Source:** RL_HarborLane_Shipments_Http / WCF-WebHttp POST /notices

- **Target:** Request trigger Receive_ShipmentNotice plus Measure_Request_Body_Bytes, Check_Request_Size, and Check_ShipmentNotice_MessageType

- **Notes:** Own workflow and HTTPS/application-xml semantics. Callers migrate to the platform callback URL with SAS query signature; JavaScriptCode measures raw UTF-8 bytes, the Condition rejects and terminates above 65536 bytes, and only its success permits well-formed XML/root-QName checking without strict XSD validation.

### Item 2

- **Source:** ShipmentRules.IsValidNotice

- **Target:** InvokeFunction action Validate_ShipmentNotice

- **Notes:** Dedicated supplied ShipmentRules implementation.

### Item 3

- **Source:** DeliveryCalendar.EstimateDeliveryDate

- **Target:** InvokeFunction action Compute_EstimatedDelivery

- **Notes:** Dedicated supplied DeliveryCalendar implementation; retains its ShipmentRules transit-day dependency.

### Item 4

- **Source:** Map_ShipmentNotice_To_ShipmentAck

- **Target:** Xslt action Transform_NoticeToAck

- **Notes:** Copies identifiers, Pending status, UTC ReceivedAt.

### Item 5

- **Source:** ShipmentRules.AckStatus and Ack assignment

- **Target:** InvokeFunction Assign_AckStatus then Compose Assign_EstimatedDelivery

- **Notes:** Finalize status and ETA.

### Item 6

- **Source:** Send_ShipmentAck

- **Target:** Response action Send_ShipmentAck

- **Notes:** Return XML before archive decision.

### Item 7

- **Source:** Decide_NoticeAccepted

- **Target:** If action Decide_NoticeAccepted

- **Notes:** True only when isValid.

### Item 8

- **Source:** SP_HarborLane_Shipments_Archive / FILE

- **Target:** AzureBlob ServiceProvider upload Send_NoticeToFolder

#### Configuration

- REPLACE_SHIPMENT_ARCHIVE_CONTAINER

- REPLACE_SHIPMENT_ARCHIVE_FOLDER

#### Retry

- **Count:** 3

- **Interval:** PT5M
