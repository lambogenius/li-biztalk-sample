# Shipment Notification — Gaps

Source contract: [gaps.json](gaps.json)

## Item 1

- **Id:** standards-not-configured

- **Severity:** blocker

- **Category:** governance

- **Description:** No external migration standards paths were configured and the extension evidence manifest contains no resources (input hash 5b1d74f72d5f8d7746a3bac90b12b7a4e3b15264854c4ebd92c989f23a926174). Architecture and implementation conventions therefore cannot be validated against external standards.

### Evidence

- discovery/b5c67cd54931/evidence/extensions/manifest.json

## Item 2

- **Id:** shipment-public-endpoint

- **Severity:** blocker

- **Category:** environment

- **Description:** The binding supplies only an application-relative WCF-WebHttp address and Transport security. Target hostname, certificate, DNS, ingress exposure, authorization policy, client identity requirements, and throttling equivalents are not supplied; client credential type is explicitly None in the source.

### Evidence

- HarborLane.Integration.BindingInfo.xml

## Item 3

- **Id:** shipment-target-archive-storage

- **Severity:** blocker

- **Category:** environment

- **Description:** The accepted-notice archive is a local Windows FILE path. No target Azure storage service, connection, share/container, identity, network configuration, retention, replay, or purge policy is supplied.

### Evidence

- HarborLane.Integration.BindingInfo.xml

## Item 4

- **Id:** shipment-fault-contract

- **Severity:** warning

- **Category:** error-handling

- **Description:** No orchestration catch/fault response contract is defined. The WCF binding disables exception details and SuspendMessageOnFailure, but externally visible failure status/body and operational handling are not specified.

### Evidence

- src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx

- HarborLane.Integration.BindingInfo.xml

## Item 5

- **Id:** shipment-archive-send-failure

- **Severity:** warning

- **Category:** operations

- **Description:** The response is sent before conditional archival. The source defines three archive FILE retries at five-minute intervals but no terminal alert/dead-letter behavior, so the desired response-versus-archive failure semantics need confirmation.

### Evidence

- src/HarborLane.Integration.Orchestrations/ShipmentNotificationOrchestration.odx

- HarborLane.Integration.BindingInfo.xml
