# Inventory Update — Components

Source contract: [components.json](components.json)

## Item 1

- **Kind:** receive-location

- **Name:** RL_HarborLane_Inventory_File

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Receive Port:** RP_HarborLane_Inventory_File

- **Adapter:** FILE

- **Address:** C:\HarborLane\In\Inventory\*.csv

- **Pipeline:** HarborLane.Integration.Pipelines.InventoryFlatFileReceive

- **Enabled:** Yes

- **Polling Interval Ms:** 60000

- **Batch Size:** 20

- **File Network Retry Count:** 5

- **File Network Retry Interval Seconds:** 5

- **Remove Received File Retry Count:** 5

## Item 2

- **Kind:** pipeline

- **Name:** InventoryFlatFileReceive

- **Artifact Id:** 8b374df5-c3df-49e4-8c0d-70c8f0758e66

- **Source Path:** src/HarborLane.Integration.Pipelines/InventoryFlatFileReceive.btp

### Details

- **Component:** Microsoft.BizTalk.Component.FFDasmComp

- **Document Spec:** HarborLane.Integration.Schemas.InventoryFlatFile

- **Validate Document Structure:** Yes

- **Recoverable Interchange Processing:** No

- **Preserve Header:** No

## Item 3

- **Kind:** schema

- **Name:** InventoryFlatFile

- **Artifact Id:** 34872ed2-8c16-4108-bc40-3fe72970de23

- **Source Path:** src/HarborLane.Integration.Schemas/InventoryFlatFile.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.InventoryFlatFile

- **Format:** CRLF-delimited HDR followed by repeating DTL comma-delimited records

## Item 4

- **Kind:** messaging-route

- **Name:** SP_HarborLane_Inventory_Update

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Subscription:** BTS.ReceivePortName == RP_HarborLane_Inventory_File

- **Adapter:** FILE

- **Address:** C:\HarborLane\Out\Inventory\%MessageID%.xml

- **Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Outbound Map:** HarborLane.Integration.Maps.Map_InventoryFlatFile_To_InventoryUpdate

- **Retry Count:** 3

- **Retry Interval Minutes:** 5

## Item 5

- **Kind:** map

- **Name:** Map_InventoryFlatFile_To_InventoryUpdate

- **Artifact Id:** 6c00b69b-2efc-4e0b-a722-6b017ac04c9f

- **Source Path:** src/HarborLane.Integration.Maps/Map_InventoryFlatFile_To_InventoryUpdate.btm

### Details

- **Source:** InventoryFlatFile

- **Target:** InventoryUpdate

- **Behavior:** Copies warehouse and item data, loops over detail records, and converts snapshot date yyyyMMdd to yyyy-MM-dd; RecordCount is not mapped.

## Item 6

- **Kind:** schema

- **Name:** InventoryUpdate

- **Artifact Id:** b64dd345-a34a-440a-99ee-889a021cfcce

- **Source Path:** src/HarborLane.Integration.Schemas/InventoryUpdate.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.InventoryUpdate
