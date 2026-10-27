# inventory-update — Action mappings

Source contract: [action-mappings.json](action-mappings.json)

- **Flow Id:** inventory-update

## Mappings

### Item 1

- **Source:** RL_HarborLane_Inventory_File / FILE C:\HarborLane\In\Inventory\*.csv

- **Target:** AzureBlob ServiceProvider trigger Receive_InventorySnapshot

#### Configuration

- REPLACE_INVENTORY_INPUT_CONTAINER

- REPLACE_INVENTORY_INPUT_FOLDER

- **Notes:** 60-second polling; File System connector is not used.

### Item 2

- **Source:** InventoryFlatFileReceive / FFDasmComp

- **Target:** FlatFileDecoding action Parse_InventoryFlatFile

- **Notes:** Built-in Logic Apps Standard Flat File Decoding uses InventoryFlatFile.xsd annotations, validates structure, preserves no header, and fails the whole interchange.

### Item 3

- **Source:** BTS.ReceivePortName == RP_HarborLane_Inventory_File

- **Target:** Dedicated workflow boundary

- **Notes:** The trigger path is the subscription; no unrelated messages enter this workflow.

### Item 4

- **Source:** Map_InventoryFlatFile_To_InventoryUpdate

- **Target:** Xslt action Transform_InventoryToUpdate

- **Notes:** Preserves repeating details/date conversion and leaves RecordCount unmapped.

### Item 5

- **Source:** XMLTransmit and SP_HarborLane_Inventory_Update

- **Target:** AzureBlob ServiceProvider upload action Send_InventoryUpdate

#### Configuration

- REPLACE_INVENTORY_OUTPUT_CONTAINER

- REPLACE_INVENTORY_OUTPUT_FOLDER

#### Retry

- **Count:** 3

- **Interval:** PT5M
