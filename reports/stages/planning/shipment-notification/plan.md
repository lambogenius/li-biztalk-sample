# shipment-notification — Plan

Source contract: [plan.json](plan.json)

- **Flow Id:** shipment-notification

- **Scope:** Convert the WCF-WebHttp request-response ShipmentNotificationOrchestration, supplied validation/ETA helpers, response map, conditional FILE archive, and retry semantics into one stateful Logic Apps Standard workflow with a native Request trigger and built-in Azure Blob upload.

## Workflows

| Name | Design File | Runtime Path | Kind | Trigger | Purpose |
| --- | --- | --- | --- | --- | --- |
| wf-shipment-notification | workflow-shipment-notification.json | logicapp/wf-shipment-notification/workflow.json | Stateful | Request | Accept ShipmentNotice XML, validate/enrich it, return ShipmentAck XML, then archive only accepted notices. |

## Sequence

- Accept application/xml through the Logic Apps Request-trigger callback URL. The callback has the platform shape https://<workflow-host>/api/wf-shipment-notification/triggers/Receive_ShipmentNotice/invoke/<relativePath>?api-version=<version>&sig=<secret>, so callers must migrate from the BizTalk-relative URL and protect the SAS signature even though no new application-level caller identity is added.

- Before business processing, JavaScriptCode measures the raw request body's UTF-8 byte length and a Condition compares it with 65,536; an oversize branch returns a fail-closed response and terminates, while a succeeded size check permits the well-formed XML and ShipmentNotice root-QName check without strict XSD validation.

- Invoke the dedicated ShipmentRules implementation for IsValidNotice and the dedicated DeliveryCalendar implementation for EstimateDeliveryDate.

- Run Map_ShipmentNotice_To_ShipmentAck as XSLT, copying identifiers, setting Pending, and stamping UTC ReceivedAt; then assign Accepted/Rejected and estimated delivery.

- Return ShipmentAck XML via Response before the archive decision, preserving source ordering and the one-minute response timeout objective.

- If isValid is true, upload the original ShipmentNotice XML to REPLACE_SHIPMENT_ARCHIVE_CONTAINER/REPLACE_SHIPMENT_ARCHIVE_FOLDER with 3 retries at 5-minute intervals; otherwise do nothing.

## Dependencies

### Schemas

- ShipmentNotice.xsd

- ShipmentAck.xsd

### Maps

- Map_ShipmentNotice_To_ShipmentAck.btm converted to XSLT

### Custom Code

- ShipmentRules.IsValidNotice/AckStatus as one dedicated ShipmentRules local implementation

- DeliveryCalendar.EstimateDeliveryDate as its own local implementation using ShipmentRules.GetTransitBusinessDays

### Connections

- /serviceProviders/AzureBlob using workflow app managed identity

### Infrastructure

- Workflow Standard workflow app and plan

- Azure Storage account with accepted-notice Blob archive path

- Key Vault

- Application Insights and Log Analytics

## Decisions

- The HTTP receive remains the request trigger of its own workflow. APIM, a custom domain, and application-level caller identity are not added because the source has none; however, the platform callback URL necessarily includes its SAS signature, which callers must protect and rotate.

- The source FILE archive becomes a built-in Azure Blob /serviceProviders/AzureBlob upload because File System requires App Service Environment v3 and cannot run on the selected plan.

- The source archive folder becomes REPLACE_SHIPMENT_ARCHIVE_CONTAINER plus REPLACE_SHIPMENT_ARCHIVE_FOLDER; values are not invented.

- Public HTTPS access remains enabled because no network policy is configured. No VNet, subnet, private endpoint, private DNS, VNet integration, or publicNetworkAccess Disabled setting is planned.

- Managed identity authorizes Blob and Key Vault access. The generated Request-trigger callback URL/SAS signature is a platform shared secret, stored in Key Vault for authorized callers and rotated under an owner-approved procedure; it is not represented as source-equivalent anonymous access.

- The normal acknowledgement precedes conditional archive, matching BizTalk. Archive exhaustion therefore fails/alerts the run after the caller has already received its acknowledgement.

## Validation

- POST TestMessages/ShipmentNotice.xml to the deployed Logic Apps callback URL with application/xml and compare the response to ShipmentAck_Expected.xml allowing dynamic ReceivedAt.

- Unit-test IsValidNotice boundaries, AckStatus, Express/Ground/Freight/unknown transit days, weekend handling, and UTC formatting.

- Golden-message test the XSLT and final acknowledgement assignments against both XSDs.

- Verify valid notices return Accepted then archive the original XML; invalid notices return Rejected and do not archive.

- Verify the explicit 65,536-byte Condition and oversize response, XML well-formedness/root-QName handling without strict XSD validation, HTTPS-only posture, callback SAS handling, one-minute response objective, 3-at-5-minute archive retries, post-response failure telemetry, managed-identity RBAC, and representative concurrency.

## Assumptions

- The supplied source contains all custom helper implementations and attaches no custom WCF endpoint/service behavior.

- The Azure Blob built-in connector is available on multitenant Workflow Standard.

- No external migration standards were configured; repository instructions and stage constraints are the only standards applied.

- Network hardening such as IP restrictions or private ingress is an owner recommendation for a separately approved change, not a placeholder in this source-equivalent conversion.

## Deployment Gates

- Supply and approve REPLACE_SHIPMENT_ARCHIVE_* and resource values plus the environment hostname generated for the workflow app.

- Migrate callers to the deployed Logic Apps Request-trigger callback URL shape; store its SAS-bearing URL in Key Vault, authorize its consumers, and approve rotation and revocation procedures.

- Approve the HTTP fault contract, including oversize and malformed/wrong-message-type responses, and confirm acknowledgement-before-archive failure semantics.

- Approve idempotency for repeated POSTs/archive uploads and execute runtime-equivalence/concurrency tests.

- Define archive lifecycle, replay, terminal alert/dead-letter handling, and support ownership.

- Verify least-privilege managed-identity Blob/Key Vault permissions, environment credentials, acceptance evidence, external-standards gap acknowledgement, and independent approval before promotion or deployment.
