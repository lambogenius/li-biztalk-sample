# inventory-update — Patterns

Source contract: [patterns.json](patterns.json)

- **Flow Id:** inventory-update

## Patterns

| Name | Implementation | Source Pattern |
| --- | --- | --- |
| Blob-triggered messaging flow | Stateful workflow with Azure Blob polling at 60 seconds | FILE receive location |
| Flat-file disassembly | Built-in Flat File Decoding action configured with annotated InventoryFlatFile.xsd and source BTP semantics | FFDasmComp |
| Dedicated subscription boundary | Configured Blob path activates only wf-inventory-update | BTS.ReceivePortName filter |
| Outbound transform | XSLT action before XML upload | BizTalk outbound BTM map |
| Transport retry | Blob upload retries 3 times at PT5M | BizTalk FILE send retry |
| Managed identity | Workflow identity authorizes Blob and Key Vault | Target security requirement |
