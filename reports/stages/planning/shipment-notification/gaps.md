# shipment-notification — Gaps

Source contract: [gaps.json](gaps.json)

- **Flow Id:** shipment-notification

## Gaps

| Id | Title | Severity | Status | Category | Description | Resolution Gate |
| --- | --- | --- | --- | --- | --- | --- |
| standards-not-configured | External migration standards not configured | high | unresolved | governance | No external migration standards paths or extension resources were configured; manifest input hash 20d5b7de793720bac14e4998d5cd0c3e3d0144be33b301e5a0a89b4edb4b98b7. | Owner acknowledges the gap or supplies standards for a new attempt. |
| shipment-environment-settings | Shipment endpoint and archive environment settings unresolved | high | unresolved | environment | Target subscription/resource names, generated public hostname, SKU, and archive container/folder are not supplied. | Supply and approve REPLACE_SHIPMENT_ARCHIVE_* and REPLACE_WORKFLOW_STANDARD_SKU; record the deployed hostname. |
| shipment-callback-contract | Logic Apps callback URL and SAS caller migration unresolved | high | unresolved | integration-contract | The Logic Apps Request trigger does not expose the exact BizTalk-relative URL. Callers must use the deployed callback shape https://<workflow-host>/api/wf-shipment-notification/triggers/Receive_ShipmentNotice/invoke/<relativePath>?api-version=<version>&sig=<secret>; the SAS-bearing URL is a shared secret even though no application-level caller identity is added. | Inventory and update every caller, store the SAS-bearing callback URL in Key Vault, restrict its distribution, and approve rotation/revocation and cutover evidence. |
| shipment-fault-contract | HTTP fault contract unresolved | high | unresolved | error-handling | Source disables exception details but does not define exact status/body for validation or unhandled processing failures. | Owner approves source-compatible fail-closed HTTP status/body and tests it without exposing exception details. |
| shipment-post-response-archive-failure | Post-response archive failure handling unresolved | high | unresolved | operations | The source replies before archival and gives three five-minute retries but no terminal alert/dead-letter contract. | Owner confirms semantics and defines alerts, support ownership, and any dead-letter destination. |
| shipment-idempotency | Shipment POST and archive idempotency unresolved | high | unresolved | reliability | The source defines no duplicate-request/archive policy. | Approve a ShipmentId-based deduplication design or explicitly accept repeated effects after testing. |
| shipment-retention-replay | Shipment archive lifecycle unresolved | medium | unresolved | operations | No retention, replay, or purge policy is evidenced. | Approve Blob lifecycle and replay procedures. |
| shipment-runtime-equivalence | Runtime equivalence and acceptance evidence pending | high | unresolved | validation | Static planning does not prove HTTP, helper, XSLT, response-order, archive, retry, and concurrency equivalence. | Run contract, golden-message, boundary, failure, identity, and load tests and obtain independent acceptance. |
| shipment-credentials | Identity assignments and environment credentials pending | high | unresolved | security | Managed-identity object ids, RBAC scopes, Key Vault access, and environment credentials are deployment-time values. | Provision least privilege and verify no secrets enter source control. |
