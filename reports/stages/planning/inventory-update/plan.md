# inventory-update — Plan

Source contract: [plan.json](plan.json)

- **Flow Id:** inventory-update

- **Scope:** Convert the messaging-only FILE receive, supplied flat-file disassembly, receive-port subscription, outbound map, XML serialization, and FILE send into one stateful Logic Apps Standard workflow using built-in Azure Blob operations.

## Workflows

| Name | Design File | Runtime Path | Kind | Trigger | Purpose |
| --- | --- | --- | --- | --- | --- |
| wf-inventory-update | workflow-inventory-update.json | logicapp/wf-inventory-update/workflow.json | Stateful | Azure Blob built-in polling trigger | Parse inventory CSV, map it to InventoryUpdate XML, and upload the result. |

## Sequence

- Poll REPLACE_INVENTORY_INPUT_CONTAINER/REPLACE_INVENTORY_INPUT_FOLDER every 60 seconds for CSV blobs.

- Parse the CRLF-delimited HDR record followed by repeating comma-delimited DTL records using the supplied InventoryFlatFile schema; validate structure and fail the whole interchange on an invalid record because recoverable interchange processing is false.

- The dedicated workflow itself preserves the BizTalk BTS.ReceivePortName subscription boundary; no shared MessageBox dispatcher is introduced.

- Run the converted Map_InventoryFlatFile_To_InventoryUpdate XSLT, including detail looping and yyyyMMdd-to-yyyy-MM-dd conversion; preserve the evidenced omission of RecordCount.

- Serialize and upload InventoryUpdate XML to REPLACE_INVENTORY_OUTPUT_CONTAINER/REPLACE_INVENTORY_OUTPUT_FOLDER using 3 retries at 5-minute intervals.

## Dependencies

### Schemas

- InventoryFlatFile.xsd

- InventoryUpdate.xsd

### Maps

- Map_InventoryFlatFile_To_InventoryUpdate.btm converted to XSLT

### Pipelines

- InventoryFlatFileReceive converted to the built-in Flat File Decoding action using InventoryFlatFile.xsd annotations

### Custom Code

_None._

### Connections

- /serviceProviders/AzureBlob using workflow app managed identity

### Infrastructure

- Workflow Standard workflow app and plan

- Azure Storage account with input/output Blob paths

- Key Vault

- Application Insights and Log Analytics

## Decisions

- The built-in File System connector is prohibited because it requires App Service Environment v3; both FILE endpoints become built-in Azure Blob /serviceProviders/AzureBlob operations.

- The source folders are preserved as REPLACE_INVENTORY_INPUT_CONTAINER/REPLACE_INVENTORY_INPUT_FOLDER and REPLACE_INVENTORY_OUTPUT_CONTAINER/REPLACE_INVENTORY_OUTPUT_FOLDER app-setting values.

- Flat-file disassembly uses the Logic Apps Standard built-in Flat File Decoding action with the supplied annotated InventoryFlatFile.xsd; no custom parser or shared dispatcher is introduced.

- Public HTTPS endpoints remain enabled because no network policy is configured. No VNet, subnet, private endpoint, private DNS, VNet integration, APIM, custom domain, or disabled public access is planned.

- Managed identity authorizes Blob and Key Vault access; no storage credentials are embedded.

- Blob output names use run id plus .xml as the %MessageID%.xml equivalent, subject to runtime-equivalence acceptance.

## Validation

- Parse TestMessages/InventorySnapshot.csv and compare the intermediate InventoryFlatFile XML with the supplied flat-file schema semantics.

- Reject malformed HDR/DTL structure as one failed interchange and verify recoverable per-record continuation is not introduced.

- Golden-message test the XSLT for repeating details, warehouse/item fields, date conversion, and intentional RecordCount omission.

- Verify only the dedicated inventory workflow consumes its configured input Blob path and produces schema-valid InventoryUpdate XML.

- Verify duplicate/idempotency behavior, 3-at-5-minute upload retries, terminal failure telemetry, managed-identity RBAC, and representative volume.

## Assumptions

- The supplied XSD, BTP, BTM, binding, and sample CSV are authoritative and structurally complete.

- The Azure Blob built-in connector is available on multitenant Workflow Standard.

- No external migration standards were configured; repository instructions and stage constraints are the only standards applied.

- Owner may evaluate network hardening later as a recommendation, without adding source-absent caller authentication in this migration.

## Deployment Gates

- Supply and approve all REPLACE_* storage and resource values.

- Approve idempotency behavior and execute runtime-equivalence tests for parser, map, serialization, filename, and failure behavior.

- Define terminal alert/dead-letter handling plus retention, replay, and purge policy.

- Verify least-privilege managed-identity Blob/Key Vault permissions and credentials outside source control.

- Acknowledge the external-standards gap, record acceptance evidence, and obtain independent approval before promotion or deployment.
