# Order Intake — Message Flow

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
    C__HarborLane_In_Orders___xml["C:\\HarborLane\\In\\Orders\\*.xml"]:::endpoint
    RL_HarborLane_Orders_File["RL_HarborLane_Orders_File"]:::process
    Receive_PurchaseOrder["Receive_PurchaseOrder"]:::endpoint
    Transform_PurchaseOrderToCanonical["Transform_PurchaseOrderToCanonical"]:::process
    CanonicalOrderMsg["CanonicalOrderMsg"]:::endpoint
    Expr_CalculateDiscount["Expr_CalculateDiscount"]:::process
    ConstructMessage_PricedOrder["ConstructMessage_PricedOrder"]:::endpoint
    Decide_ApprovalRequired["Decide_ApprovalRequired"]:::process
    SP_HarborLane_Orders_Approval["SP_HarborLane_Orders_Approval"]:::process
    SP_HarborLane_Orders_Fulfilment["SP_HarborLane_Orders_Fulfilment"]:::process
    Catch_OrderFailure["Catch_OrderFailure"]:::endpoint
    SP_HarborLane_Orders_Error["SP_HarborLane_Orders_Error"]:::process
    C__HarborLane_In_Orders___xml --> RL_HarborLane_Orders_File
    Receive_PurchaseOrder --> Transform_PurchaseOrderToCanonical
    CanonicalOrderMsg --> Expr_CalculateDiscount
    ConstructMessage_PricedOrder --> Decide_ApprovalRequired
    Decide_ApprovalRequired --> SP_HarborLane_Orders_Approval
    Decide_ApprovalRequired --> SP_HarborLane_Orders_Fulfilment
    Catch_OrderFailure --> SP_HarborLane_Orders_Error
```

## Details

| Sequence | From | To | Message | Behavior | Condition |
| --- | --- | --- | --- | --- | --- |
| 1 | C:\HarborLane\In\Orders\*.xml | RL_HarborLane_Orders_File | PurchaseOrder | FILE adapter polling through XMLReceive activates Receive_PurchaseOrder. | _Not specified_ |
| 2 | Receive_PurchaseOrder | Transform_PurchaseOrderToCanonical | PurchaseOrder -> CanonicalOrder | Map copies fields and lines, formats the order date, concatenates names/address, and supplies initial values. | _Not specified_ |
| 3 | CanonicalOrderMsg | Expr_CalculateDiscount | CanonicalOrder | CalculateDiscount returns discountAmount; netTotal is OrderTotal minus discountAmount. | _Not specified_ |
| 4 | ConstructMessage_PricedOrder | Decide_ApprovalRequired | CanonicalOrder | Copies the canonical message and assigns DiscountAmount and NetTotal. | _Not specified_ |
| 5 | Decide_ApprovalRequired | SP_HarborLane_Orders_Approval | CanonicalOrder | Writes XML to the approval folder. | OrderTotal >= 5000 |
| 6 | Decide_ApprovalRequired | SP_HarborLane_Orders_Fulfilment | CanonicalOrder | Writes XML to the fulfilment folder. | else |
| 7 | Catch_OrderFailure | SP_HarborLane_Orders_Error | OrderError | BuildOrderError creates an error document and the FILE port writes it to the errors folder. | System.Exception in Scope_ProcessOrder |
