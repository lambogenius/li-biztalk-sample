# Order Intake — Gaps

Source contract: [gaps.json](gaps.json)

## Item 1

- **Id:** standards-not-configured

- **Severity:** blocker

- **Category:** governance

- **Description:** No external migration standards paths were configured and the extension evidence manifest contains no resources (input hash 5b1d74f72d5f8d7746a3bac90b12b7a4e3b15264854c4ebd92c989f23a926174). Architecture and implementation conventions therefore cannot be validated against external standards.

### Evidence

- discovery/b5c67cd54931/evidence/extensions/manifest.json

## Item 2

- **Id:** order-target-storage

- **Severity:** blocker

- **Category:** environment

- **Description:** The source binds to local Windows FILE paths, but no target Azure storage service, connection, share/container, naming convention, identity, or network configuration is supplied.

### Evidence

- HarborLane.Integration.BindingInfo.xml

## Item 3

- **Id:** order-failure-after-send-retries

- **Severity:** warning

- **Category:** operations

- **Description:** BizTalk defines three send retries at five-minute intervals, but no terminal operational handling, alerting, or dead-letter destination after retry exhaustion is specified. RouteFailedMessage and StopSendingOnFailure are false.

### Evidence

- HarborLane.Integration.BindingInfo.xml

## Item 4

- **Id:** order-archive-retention

- **Severity:** warning

- **Category:** archive

- **Description:** No input/output archive, retention, replay, or purge behavior is defined for this flow; only the dedicated OrderError output is evidenced.

### Evidence

- src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx

- HarborLane.Integration.BindingInfo.xml
