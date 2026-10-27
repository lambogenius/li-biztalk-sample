# Inventory Update — Meta

Source contract: [meta.json](meta.json)

- **Id:** inventory-update

- **Name:** Inventory Update

- **Category:** messaging

- **Entry Point:** RL_HarborLane_Inventory_File

- **Messaging Route:** SP_HarborLane_Inventory_Update

- **Source Path:** HarborLane.Integration.BindingInfo.xml

- **Binding Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Summary:** A messaging-only BizTalk subscription consumes inventory CSV, disassembles it to InventoryFlatFile XML, maps it to InventoryUpdate XML, and writes it to a FILE endpoint without an orchestration.
