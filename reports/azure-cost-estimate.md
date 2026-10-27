# Azure Monthly Cost Estimate

Generated: 2026-10-27T00:40:29.870Z

- Region: `canadacentral` (default, because the Bicep parameter location is unresolved (REPLACE_AZURE_LOCATION_DEV) and migration.costEstimation.region is not set)
- Plan SKU: `WS1` (Bicep parameter appServicePlanSku)
- Environment: `dev`
- Generated solution: `<run>/reports\worktrees\HarborLane.Integration`
- Bicep parameters: `<run>/reports\worktrees\HarborLane.Integration\infra\params\dev.bicepparam`

## Estimate

| Resource | SKU | Assumed quantity | Retail unit price | Estimated monthly |
|---|---|---:|---:|---:|
| Logic Apps Standard compute (vCPU) | WS1 × 1 | 1 vCPU × 730 hours | CAD 0.28 | CAD 204.98 |
| Logic Apps Standard compute (memory) | WS1 × 1 | 3.5 GiB × 730 hours | CAD 0.02 | CAD 51.36 |
| Workflow host storage | Standard LRS / Azure Files | 5 GB-month | CAD 0.09 | CAD 0.47 |
| Application Insights / Log Analytics ingestion | Analytics Logs | 5 GB | CAD 3.91 | CAD 19.55 |
| **Total** | | | | **CAD 276.36** |

Indicative workload range (±20%): **CAD 221.09–CAD 331.63 per month**.

## Assumptions

- 730 running hours per month and 1 plan instance(s).
- 5 GB/month of Application Insights and Log Analytics ingestion.
- 5 GB/month of workflow-host Azure Files storage.
- Prices are current public retail rates returned by the Azure Retail Prices API in CAD; no negotiated discount is applied.

## Not included

- Existing/shared archive storage base charge
- Existing API Management service base charge
- Bandwidth, managed-connector calls, support, taxes, reservations, and negotiated discounts

## Price meters

- Logic Apps Standard compute (vCPU): Logic Apps / Standard vCPU Duration (1 Hour)
- Logic Apps Standard compute (memory): Logic Apps / Standard Memory Duration (1 GiB Hour)
- Workflow host storage: Files v2 / LRS Data Stored (1 GB/Month)
- Application Insights / Log Analytics ingestion: Log Analytics / Analytics Logs Data Ingestion (1 GB)

Pricing source: https://prices.azure.com/api/retail/prices

> Retail planning estimate only. Actual Azure charges depend on usage, contract, discounts, taxes, and resource configuration.
