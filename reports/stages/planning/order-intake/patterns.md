# order-intake — Patterns

Source contract: [patterns.json](patterns.json)

- **Flow Id:** order-intake

## Patterns

| Name | Implementation | Source Pattern |
| --- | --- | --- |
| Blob-triggered orchestration | Stateful workflow with built-in Azure Blob polling trigger at 60 seconds | FILE receive location |
| Canonical message mapping | XML validation plus XSLT transform | BizTalk XMLReceive and BTM map |
| Supplied custom business rule | Dedicated PricingRules local function | PricingRules.CalculateDiscount |
| Content-based routing | If action on OrderTotal >= 5000 | Decide_ApprovalRequired |
| Scoped exception handling | Processing Scope plus run-after Catch Scope | Scope_ProcessOrder/Catch_OrderFailure |
| Transport retry | Each Blob upload retries 3 times at PT5M | BizTalk FILE send retry |
| Managed identity | Workflow identity authorizes Blob and Key Vault | Target security requirement |
