# Inventory Update — Patterns

Source contract: [patterns.json](patterns.json)

| Name | Evidence | Source Path |
| --- | --- | --- |
| Messaging-only publish/subscribe | SP_HarborLane_Inventory_Update subscribes on BTS.ReceivePortName and is not bound to an orchestration. | HarborLane.Integration.BindingInfo.xml |
| Flat-file disassembly | InventoryFlatFileReceive uses FFDasmComp with InventoryFlatFile and structural validation enabled. | src/HarborLane.Integration.Pipelines/InventoryFlatFileReceive.btp |
| Outbound transform | The subscribed send port applies Map_InventoryFlatFile_To_InventoryUpdate before XMLTransmit. | HarborLane.Integration.BindingInfo.xml |
| Transport retry | The FILE send port specifies RetryCount 3 and RetryInterval 5; ordered delivery and stop-on-failure are false. | HarborLane.Integration.BindingInfo.xml |
