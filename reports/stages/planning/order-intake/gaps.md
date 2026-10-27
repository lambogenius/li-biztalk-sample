# order-intake — Gaps

Source contract: [gaps.json](gaps.json)

- **Flow Id:** order-intake

## Gaps

| Id | Title | Severity | Status | Category | Description | Resolution Gate |
| --- | --- | --- | --- | --- | --- | --- |
| standards-not-configured | External migration standards not configured | high | unresolved | governance | No external migration standards paths or migration extension resources were configured for this stage; repository instructions and the stage brief were used. Extension manifest input hash: 20d5b7de793720bac14e4998d5cd0c3e3d0144be33b301e5a0a89b4edb4b98b7. | Owner acknowledges the missing external standards or supplies them for a new planning attempt. |
| order-storage-settings | Order Blob settings and names unresolved | high | unresolved | environment | Azure subscription/resource names and input, approval, fulfilment, and error container/folder values are not supplied. | Supply and approve all REPLACE_ORDER_* settings and REPLACE_WORKFLOW_STANDARD_SKU. |
| order-idempotency | Order re-delivery idempotency policy unresolved | high | unresolved | reliability | The source does not define duplicate handling; Blob polling may redeliver after partial failure. | Owner approves a deduplication key/store or explicitly accepts at-least-once effects after equivalence testing. |
| order-terminal-failure | Terminal send failure handling unresolved | medium | unresolved | operations | Source sends retry three times at five-minute intervals but define no alert or dead-letter destination after exhaustion. | Owner defines alerts, support ownership, and any dead-letter destination. |
| order-retention-replay | Retention and replay policy unresolved | medium | unresolved | operations | No archive, retention, replay, or purge behavior is evidenced. | Owner approves Blob lifecycle and replay procedures. |
| order-runtime-equivalence | Runtime equivalence and acceptance evidence pending | high | unresolved | validation | Static planning does not prove XSLT, helper, retry, filename, and error-path equivalence. | Execute golden-message, failure-injection, identity/RBAC, and representative-volume tests and obtain independent acceptance. |
| order-credentials | Identity assignments and environment credentials pending | high | unresolved | security | Managed-identity object ids, RBAC scopes, Key Vault access, and any environment credentials are deployment-time values. | Provision least-privilege assignments and verify no secrets are stored in artifacts. |
