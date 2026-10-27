# Shipment Notification — Message Flow

Source contract: [messageFlow.json](messageFlow.json)

## Diagram

```mermaid
flowchart LR
    classDef endpoint fill:#dbeafe,stroke:#2563eb,color:#172554
    classDef process fill:#ecfccb,stroke:#65a30d,color:#1a2e05
    classDef data fill:#fef3c7,stroke:#d97706,color:#451a03
    classDef code fill:#f3e8ff,stroke:#9333ea,color:#3b0764
    classDef external fill:#fff3cd,stroke:#9a6700,color:#422006
    classDef failure fill:#fee2e2,stroke:#dc2626,color:#450a0a
    classDef azure fill:#ccfbf1,stroke:#0f766e,color:#042f2e
    classDef neutral fill:#f3f4f6,stroke:#6b7280,color:#111827
    Carrier["Carrier"]:::endpoint
    RL_HarborLane_Shipments_Http["RL_HarborLane_Shipments_Http"]:::process
    Receive_ShipmentNotice["Receive_ShipmentNotice"]:::endpoint
    Expr_ValidateAndComputeEta["Expr_ValidateAndComputeEta"]:::process
    ShipmentNoticeMsg["ShipmentNoticeMsg"]:::endpoint
    ConstructMessage_ShipmentAck["ConstructMessage_ShipmentAck"]:::process
    Send_ShipmentAck["Send_ShipmentAck"]:::endpoint
    Decide_NoticeAccepted["Decide_NoticeAccepted"]:::endpoint
    SP_HarborLane_Shipments_Archive["SP_HarborLane_Shipments_Archive"]:::process
    Carrier --> RL_HarborLane_Shipments_Http
    Receive_ShipmentNotice --> Expr_ValidateAndComputeEta
    ShipmentNoticeMsg --> ConstructMessage_ShipmentAck
    Send_ShipmentAck --> Carrier
    Decide_NoticeAccepted --> SP_HarborLane_Shipments_Archive
```

## Details

| Sequence | From | To | Message | Behavior | Condition |
| --- | --- | --- | --- | --- | --- |
| 1 | Carrier | RL_HarborLane_Shipments_Http | ShipmentNotice XML | POST /HarborLaneShipments/ShipmentService.svc/notices over transport security with no client credential; XMLReceive activates the orchestration. | _Not specified_ |
| 2 | Receive_ShipmentNotice | Expr_ValidateAndComputeEta | ShipmentNotice | IsValidNotice validates shipment id, tracking number, and package count; EstimateDeliveryDate computes weekend-aware business-day ETA. | _Not specified_ |
| 3 | ShipmentNoticeMsg | ConstructMessage_ShipmentAck | ShipmentNotice -> ShipmentAck | Map copies identifiers and stamps ReceivedAt UTC; AckStatus and calculated ETA overwrite Status and EstimatedDelivery. | _Not specified_ |
| 4 | Send_ShipmentAck | Carrier | ShipmentAck XML | Two-way port returns the response through XMLTransmit before the archive decision. | _Not specified_ |
| 5 | Decide_NoticeAccepted | SP_HarborLane_Shipments_Archive | original ShipmentNotice XML | Writes accepted notices to C:\HarborLane\Out\Shipments\%MessageID%.xml; rejected notices are not archived. | isValid == true |
