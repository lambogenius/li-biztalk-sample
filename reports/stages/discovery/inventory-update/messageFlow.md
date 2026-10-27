# Inventory Update — Message Flow

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
    C__HarborLane_In_Inventory___csv["C:\\HarborLane\\In\\Inventory\\*.csv"]:::endpoint
    RL_HarborLane_Inventory_File["RL_HarborLane_Inventory_File"]:::process
    InventoryFlatFileReceive["InventoryFlatFileReceive"]:::process
    BizTalk_MessageBox["BizTalk MessageBox"]:::endpoint
    SP_HarborLane_Inventory_Update["SP_HarborLane_Inventory_Update"]:::process
    Map_InventoryFlatFile_To_InventoryUpdate["Map_InventoryFlatFile_To_InventoryUpdate"]:::process
    XMLTransmit["XMLTransmit"]:::endpoint
    C__HarborLane_Out_Inventory__MessageID__xml["C:\\HarborLane\\Out\\Inventory\\%MessageID%.xml"]:::process
    C__HarborLane_In_Inventory___csv --> RL_HarborLane_Inventory_File
    RL_HarborLane_Inventory_File --> InventoryFlatFileReceive
    BizTalk_MessageBox --> SP_HarborLane_Inventory_Update
    SP_HarborLane_Inventory_Update --> Map_InventoryFlatFile_To_InventoryUpdate
    XMLTransmit --> C__HarborLane_Out_Inventory__MessageID__xml
```

## Details

| Sequence | From | To | Message | Behavior | Condition |
| --- | --- | --- | --- | --- | --- |
| 1 | C:\HarborLane\In\Inventory\*.csv | RL_HarborLane_Inventory_File | Inventory CSV | FILE adapter polls for CSV files. | _Not specified_ |
| 2 | RL_HarborLane_Inventory_File | InventoryFlatFileReceive | Inventory CSV -> InventoryFlatFile XML | Flat File Disassembler validates structure; HDR and repeating DTL records are comma-delimited and records are CRLF-delimited. | _Not specified_ |
| 3 | BizTalk MessageBox | SP_HarborLane_Inventory_Update | InventoryFlatFile XML | Direct messaging subscription; no orchestration is involved. | BTS.ReceivePortName == RP_HarborLane_Inventory_File |
| 4 | SP_HarborLane_Inventory_Update | Map_InventoryFlatFile_To_InventoryUpdate | InventoryFlatFile -> InventoryUpdate | Outbound map loops over details, copies inventory fields, and formats SnapshotDate. | _Not specified_ |
| 5 | XMLTransmit | C:\HarborLane\Out\Inventory\%MessageID%.xml | InventoryUpdate XML | FILE send port writes mapped XML. | _Not specified_ |
