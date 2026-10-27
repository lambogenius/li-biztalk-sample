# inventory-update — Gaps

Source contract: [gaps.json](gaps.json)

- **Flow Id:** inventory-update

## Gaps

| Id | Title | Severity | Status | Category | Description | Resolution Gate |
| --- | --- | --- | --- | --- | --- | --- |
| standards-not-configured | External migration standards not configured | high | unresolved | governance | No external migration standards paths or extension resources were configured; manifest input hash 20d5b7de793720bac14e4998d5cd0c3e3d0144be33b301e5a0a89b4edb4b98b7. | Owner acknowledges the gap or supplies standards for a new attempt. |
| inventory-storage-settings | Inventory Blob settings and names unresolved | high | unresolved | environment | Target resource names and input/output container/folder values are not supplied. | Supply and approve REPLACE_INVENTORY_* settings and REPLACE_WORKFLOW_STANDARD_SKU. |
| inventory-idempotency | Inventory re-delivery idempotency unresolved | high | unresolved | reliability | The source defines no duplicate policy and Blob polling may redeliver after partial failure. | Approve a deduplication design or explicitly accept at-least-once effects after testing. |
| inventory-terminal-failure | Parser, map, and send terminal handling unresolved | medium | unresolved | operations | Recoverable interchange is false and source has no terminal alert/dead-letter contract after parsing, mapping, or retry exhaustion. | Define alerts, support ownership, and any dead-letter destination. |
| inventory-retention-replay | Retention and replay policy unresolved | medium | unresolved | operations | No archive, retention, replay, or purge behavior is evidenced. | Approve Blob lifecycle and replay procedures. |
| inventory-runtime-equivalence | Runtime equivalence and acceptance evidence pending | high | unresolved | validation | Static planning does not prove flat-file, XSLT, serialization, filename, and retry equivalence. | Run golden-message, malformed-input, failure, identity, and volume tests and obtain independent acceptance. |
| inventory-credentials | Identity assignments and environment credentials pending | high | unresolved | security | Managed-identity object ids, RBAC scopes, Key Vault access, and environment credentials are deployment-time values. | Provision least privilege and verify no secrets enter source control. |
