# Inventory Update — Analysis

Source contract: [analysis.json](analysis.json)

- **Summary:** This is the catalog's sole messagingRoutes entry. BizTalk publishes the disassembled inventory message and SP_HarborLane_Inventory_Update directly subscribes by receive-port name, applies its outbound map, and sends the result without an orchestration.

- **Mermaid Code:** flowchart LR<br>  A["FILE: In/Inventory/*.csv"] --> B["InventoryFlatFileReceive"]<br>  B --> C["InventoryFlatFile XML"]<br>  C --> D{"Subscription: BTS.ReceivePortName"}<br>  D --> E["SP_HarborLane_Inventory_Update"]<br>  E --> F["Map InventoryFlatFile to InventoryUpdate"]<br>  F --> G["XMLTransmit"]<br>  G --> H["FILE: Out/Inventory"]

## Message Flow

- The FILE receive location polls C:\HarborLane\In\Inventory\*.csv.

- InventoryFlatFileReceive disassembles and validates HDR/DTL records into InventoryFlatFile XML.

- SP_HarborLane_Inventory_Update subscribes when BTS.ReceivePortName equals RP_HarborLane_Inventory_File.

- The send port maps InventoryFlatFile to InventoryUpdate, including a yyyyMMdd to yyyy-MM-dd date conversion.

- XMLTransmit writes C:\HarborLane\Out\Inventory\%MessageID%.xml.

## Component Details

### Entry Point

- **Name:** RL_HarborLane_Inventory_File

- **Binding Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

### Messaging Route

- **Send Port:** SP_HarborLane_Inventory_Update

- **Subscription:** BTS.ReceivePortName == RP_HarborLane_Inventory_File

- **Pipeline:** InventoryFlatFileReceive (8b374df5-c3df-49e4-8c0d-70c8f0758e66)

### Schemas

- InventoryFlatFile (34872ed2-8c16-4108-bc40-3fe72970de23)

- InventoryUpdate (b64dd345-a34a-440a-99ee-889a021cfcce)

- **Map:** Map_InventoryFlatFile_To_InventoryUpdate (6c00b69b-2efc-4e0b-a722-6b017ac04c9f)

- **Archive Behavior:** No archive behavior is present.

## Gaps

- External migration standards and extension resources are not configured.

- Target Azure storage endpoints, connections, identity, and networking are unresolved.

- Terminal handling for flat-file/map failures and retry exhaustion is unspecified.

- Archive, retention, replay, and purge behavior is absent.

## Patterns

- Messaging-only publish/subscribe

- Flat-file disassembly

- Outbound transform

- Transport retry

## Dependency Analysis

### Custom Code

_None._

### Transport

- **Receive:** FILE with 60-second polling; custom Flat File Disassembler pipeline

- **Send:** FILE with XMLTransmit; 3 retries at 5-minute intervals

### Routing

- **Type:** direct message subscription

- **Filter:** BTS.ReceivePortName == RP_HarborLane_Inventory_File

- **Send Port:** SP_HarborLane_Inventory_Update

### Source References

- HarborLane.Integration.BindingInfo.xml

- src/HarborLane.Integration.Pipelines/InventoryFlatFileReceive.btp

- src/HarborLane.Integration.Maps/Map_InventoryFlatFile_To_InventoryUpdate.btm
