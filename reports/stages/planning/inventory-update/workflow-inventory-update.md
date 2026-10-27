# inventory-update — Workflow inventory update

Source contract: [workflow-inventory-update.json](workflow-inventory-update.json)

- **Name:** wf-inventory-update

- **Runtime Path:** logicapp/wf-inventory-update/workflow.json

- **Kind:** Stateful

## Source Artifact Ids

- 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- 8b374df5-c3df-49e4-8c0d-70c8f0758e66

- 34872ed2-8c16-4108-bc40-3fe72970de23

- 6c00b69b-2efc-4e0b-a722-6b017ac04c9f

- b64dd345-a34a-440a-99ee-889a021cfcce

## Trigger

- **Name:** Receive_InventorySnapshot

- **Type:** ServiceProvider

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** When_a_blob_is_added_or_modified

### Recurrence

- **Frequency:** Second

- **Interval:** 60

### Configuration

- REPLACE_INVENTORY_INPUT_CONTAINER

- REPLACE_INVENTORY_INPUT_FOLDER

- **Split On:** one workflow run per blob

## Actions

### Item 1

- **Name:** Parse_InventoryFlatFile

- **Type:** FlatFileDecoding

- **Schema:** InventoryFlatFile.xsd

- **Behavior:** Built-in Flat File Decoding reads BizTalk flat-file annotations for one HDR plus repeating DTL CRLF records; invalid structure fails the whole interchange because recoverable interchange processing is false

### Item 2

- **Name:** Transform_InventoryToUpdate

- **Type:** Xslt

- **Map:** Map_InventoryFlatFile_To_InventoryUpdate.xslt

- **Run After:** Parse_InventoryFlatFile succeeded

### Item 3

- **Name:** Send_InventoryUpdate

- **Type:** ServiceProvider

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** uploadBlob

#### Retry

- **Type:** fixed

- **Count:** 3

- **Interval:** PT5M

- **Run After:** Transform_InventoryToUpdate succeeded

- **Ordering:** Strictly sequential Flat File Decoding, transform, and upload. Output XSD conformance is tested offline rather than enforced by a source-absent runtime validation action. One workflow replaces the receive-port subscription and no orchestration trigger is invented.

- **Retry Error Behavior:** Flat File Decoding or map failures fail the run without partial record recovery. Upload retries three times at five-minute intervals; terminal handling is gated.

## Inputs

| Name | Format | Structure | Source |
| --- | --- | --- | --- |
| InventorySnapshot | CSV | HDR then repeating DTL records, comma-delimited, CRLF-delimited | configured Blob path |

## Outputs

| Name | Format | Schema | Destination |
| --- | --- | --- | --- |
| InventoryUpdate | XML | InventoryUpdate.xsd | configured Blob path |

## Configuration Needs

- REPLACE_INVENTORY_INPUT_CONTAINER

- REPLACE_INVENTORY_INPUT_FOLDER

- REPLACE_INVENTORY_OUTPUT_CONTAINER

- REPLACE_INVENTORY_OUTPUT_FOLDER

- managed identity Blob RBAC

- Key Vault-backed settings if secrets are introduced

## Network

- **Public Endpoints:** Yes

- **Https Only:** Yes

- **Private Networking:** No

- **Recommendation:** Owner may evaluate IP restrictions or private networking in a later approved change.
