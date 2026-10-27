# Inventory Update — Gaps

Source contract: [gaps.json](gaps.json)

## Item 1

- **Id:** standards-not-configured

- **Severity:** blocker

- **Category:** governance

- **Description:** No external migration standards paths were configured and the extension evidence manifest contains no resources (input hash 5b1d74f72d5f8d7746a3bac90b12b7a4e3b15264854c4ebd92c989f23a926174). Architecture and implementation conventions therefore cannot be validated against external standards.

### Evidence

- discovery/b5c67cd54931/evidence/extensions/manifest.json

## Item 2

- **Id:** inventory-target-storage

- **Severity:** blocker

- **Category:** environment

- **Description:** The source binds to local Windows FILE paths, but no target Azure storage service, connection, share/container, naming convention, identity, or network configuration is supplied.

### Evidence

- HarborLane.Integration.BindingInfo.xml

## Item 3

- **Id:** inventory-terminal-failure

- **Severity:** warning

- **Category:** operations

- **Description:** Recoverable interchange processing is disabled, and terminal handling for disassembly/map errors or FILE send retry exhaustion is not specified. RouteFailedMessage and StopSendingOnFailure are false.

### Evidence

- src/HarborLane.Integration.Pipelines/InventoryFlatFileReceive.btp

- HarborLane.Integration.BindingInfo.xml

## Item 4

- **Id:** inventory-archive-retention

- **Severity:** warning

- **Category:** archive

- **Description:** No archive, retention, replay, or purge behavior is defined for source CSV or produced InventoryUpdate XML.

### Evidence

- HarborLane.Integration.BindingInfo.xml
