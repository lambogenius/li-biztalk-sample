# Harbor Lane Supply: a BizTalk to Logic Apps migration, before and after

This repository shows a complete migration made by **LI**, the Lambogenius Integration Migration
CLI, from a BizTalk Server 2020 solution to Azure Logic Apps Standard. It holds the BizTalk source,
the reports LI wrote at each stage, the Logic Apps application it generated, and the Bicep and
scripts that deploy that application to Azure.

> **Synthetic content.** Harbor Lane Supply is a fictional outdoor-gear distributor. Every name,
> namespace, path, host, address and business rule was invented for this sample. It contains no
> customer code and no secrets.

| Folder | What it is |
| --- | --- |
| [`before/`](before/) | The BizTalk solution: orchestrations, maps, schemas, a flat-file pipeline, a C# helper library, the application binding file and test messages. Its [README](before/README.md) describes the three flows. |
| [`reports/`](reports/) | What LI reported: the [batch report](reports/migration-batch-report.md), the [solution report](reports/solution-report.html), token usage, the Azure cost estimate, and every stage's evidence under [`reports/stages/`](reports/stages/) (discovery, planning, conversion and test). |
| [`after/`](after/) | The generated Logic Apps Standard repository, exactly as LI produced it: three workflows, XSLT maps, schemas, local .NET functions ported from the helper library, Bicep infrastructure with dev, uat and prod parameters, and tests. Start with [`README.FIRST.md`](after/README.FIRST.md). |
| [`azure/`](azure/) | A subscription-scope Bicep file that creates a resource group and deploys `after/infra/main.bicep` into it unchanged, plus scripts to deploy, smoke-test and tear down. |

## The three flows

| BizTalk (before) | Logic Apps Standard (after) |
| --- | --- |
| **Order intake**: FILE receive, map with String Concatenate, C# Scripting and Looping functoids, discount from `PricingRules`, approval routing at 5000, `OrderError` on failure | `wf-order-intake`: blob trigger on `orders-in`, XSLT map, local function for the discount, routing to `orders-approval` or `orders-fulfilment`, error document to `orders-error` |
| **Inventory update**: messaging only, no orchestration. Flat-file pipeline, then a send port that subscribes by `BTS.ReceivePortName` and maps | `wf-inventory-update`: blob trigger on `inventory-in`, flat-file decode with the source schema, XSLT map, XML to `inventory-out` |
| **Shipment notification**: WCF-WebHttp request-response, validation and ETA from `ShipmentRules` and `DeliveryCalendar`, archive of accepted notices | `wf-shipment-notification`: HTTP request trigger, local functions for validation and ETA, acknowledgement response, archive to `shipments-archive` |

BizTalk FILE locations became Azure Blob Storage containers: the built-in File System connector
runs only in an App Service Environment, and this sample targets the normal Workflow Standard
plan. The generated infrastructure uses public endpoints secured by HTTPS and managed identity,
which is LI's default when no network policy is configured.

## How it was made

LI ran with no starter repository, no standards documents and no architecture policy, which is
what a new organization starts with. The configuration was a batch of one solution with
`target.logicApps: standard`. One run (LI 0.0.4-preview123) did discovery, planning, conversion,
local tests, the deployment package and the cost estimate in 70 minutes and about 32 million model
tokens. An independent reviewer model checked planning and conversion, and each needed one
repair round.

The local test stage built the functions, ran the generated conversion tests and compiled the
Bicep template and each environment's parameter file. It also ran the three workflows in the
local Logic Apps runtime against Azurite, sending each test case in
[`after/tests/workflow-runs.json`](after/tests/workflow-runs.json) and checking the run status
and the blobs written. That check failed in its first rounds, and the agent fixed each defect it
found:
- a `secureData` setting on a condition;
- a trigger path segment containing a `.`;
- inline JavaScript actions, which it replaced with built-in expressions;
- blob paths the workflows built wrongly.

There is no integration suite without a starter, so the report shows that check as **Not
verified**.

## Results in Azure

The scripts below deployed `after/` to a new resource group in Canada Central and ran the smoke
test. All three workflows loaded **Healthy**, all four runs **Succeeded**, and every check passed:

| Check | Result |
| --- | --- |
| Shipment notice POSTed to `/HarborLaneShipments/ShipmentService.svc/notices` returns an acknowledgement (HTTP 200, status Accepted, estimated delivery from `DeliveryCalendar`) | PASS |
| Purchase order of 5000 or more lands in `orders-approval` | PASS |
| Purchase order below 5000 lands in `orders-fulfilment` | PASS |
| Inventory CSV is decoded, mapped and written to `inventory-out` | PASS |
| Accepted shipment notice is archived in `shipments-archive` | PASS |
| No error documents in `orders-error` | PASS |

The resources were then deleted with `teardown.ps1`. This is a smoke test of the happy paths, not
proof that every behaviour matches the BizTalk originals.

### What the owner supplies

`after/` is exactly what LI produced. LI left the values only the application owner can know as
`REPLACE_*` placeholders, listed in [`after/README.FIRST.md`](after/README.FIRST.md):
- the Azure region;
- the blob container and folder that replace each BizTalk file location;
- the HTTP status for shipment notices over 64 KB.

[`azure/main.bicep`](azure/main.bicep) supplies them: Canada Central, the same container and
folder names as the local test contract, and status 413. The shipment trigger's path keeps the
BizTalk URL. Logic Apps does not allow a `.` in a path segment, so LI made
`ShipmentService.svc` a path parameter, and the smoke test fills it with that value.

## Deploy it

You need an Azure subscription, the Azure CLI, the .NET 8 SDK and PowerShell 7.

```powershell
az login
./azure/deploy.ps1 -SubscriptionId <subscription-id>      # resource group rg-li-sample-harborlane-dev-cac, Canada Central
./azure/smoke-test.ps1 -SubscriptionId <subscription-id>  # sends before/TestMessages through all three flows
./azure/teardown.ps1 -SubscriptionId <subscription-id>
```

`-Location` and `-ResourceGroupName` change the defaults. The resources cost money while they
exist, mostly the WS1 Workflow Standard plan (roughly US$175 a month); `teardown.ps1` deletes the
resource group and everything in it. The generated Key Vault has purge protection, so after
teardown it stays soft-deleted for 90 days at no cost. Running `deploy.ps1` again with the same
resource group recovers it.

## Try LI on it yourself

Point LI at `before/` as the BizTalk source. Your own run will differ in detail from `after/`,
because the conversion is done by an AI agent, but it is checked by the same deterministic rules.
