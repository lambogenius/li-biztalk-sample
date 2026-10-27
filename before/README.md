# Harbor Lane Supply: BizTalk Server 2020 sample

A small, complete BizTalk Server 2020 solution you can use to try **LI**, a CLI that migrates
BizTalk applications to Azure Logic Apps Standard, without bringing your own code.

> **Synthetic content.** Harbor Lane Supply is a fictional outdoor-gear distributor. Every name,
> namespace, path, host, address and business rule in this repository was invented for this sample.
> It contains no customer code and no secrets.

The solution is deliberately small (three flows), but it uses the real BizTalk file formats:
orchestration designer data plus XLANG/s (`.odx`), mapper files (`.btm`), annotated schemas
(`.xsd`), a pipeline (`.btp`), BizTalk projects (`.btproj`) and an exported application binding
file. Every external system is a file folder or an HTTP endpoint, so the converted Logic Apps need
nothing more than cheap, self-contained Azure resources (blob containers and the Logic App's own
HTTP trigger).

Every helper method that the orchestrations call is implemented in the included C# library, so
the solution is fully supplied: nothing is missing for a migration tool to resolve.

## The three flows

| # | Flow | Style | In | Out |
|---|------|-------|----|-----|
| 1 | Order intake | Orchestration | FILE `C:\HarborLane\In\Orders\*.xml` | FILE `Out\Approval`, `Out\Fulfilment`, `Out\Errors` |
| 2 | Inventory update | Messaging only (no orchestration) | FILE `C:\HarborLane\In\Inventory\*.csv` | FILE `Out\Inventory` |
| 3 | Shipment notification | Orchestration, request-response | HTTP POST `/HarborLaneShipments/ShipmentService.svc/notices` (WCF-WebHttp) | HTTP reply + FILE `Out\Shipments` |

### 1. Order intake (`OrderIntakeOrchestration`)

1. A FILE receive location picks up partner purchase orders (`PurchaseOrder.xsd`).
2. **Receive_PurchaseOrder** activates the orchestration.
3. Inside **Scope_ProcessOrder**:
   - **ConstructMessage_CanonicalOrder** runs the map `Map_PurchaseOrder_To_CanonicalOrder`, which
     uses a String Concatenate functoid (buyer name, shipping address), an inline C# Scripting
     functoid (yyyyMMdd to yyyy-MM-dd) and a Looping functoid over the order lines.
   - **Expr_CalculateDiscount** calls
     `HarborLane.Integration.Helpers.PricingRules.CalculateDiscount(decimal total, string customerTier)`.
   - **ConstructMessage_PricedOrder** copies the canonical order and sets the discount and net total.
   - **Decide_ApprovalRequired**: orders with `OrderTotal >= 5000` are sent to the approval folder
     (**Send_ToApproval**), all others to the fulfilment folder (**Send_ToFulfilment**).
4. **Catch_OrderFailure** (System.Exception) builds an `OrderError` message with
   `ErrorMessageBuilder.BuildOrderError` and sends it to the error folder.

### 2. Inventory update (messaging)

1. A FILE receive location picks up the warehouse CSV through the custom receive pipeline
   `InventoryFlatFileReceive` (Flat File Disassembler).
2. The flat-file schema `InventoryFlatFile.xsd` describes one `HDR` header record followed by
   repeating `DTL` detail records, comma-delimited, one record per CRLF-terminated line.
3. The send port `SP_HarborLane_Inventory_Update` subscribes with the filter
   `BTS.ReceivePortName == RP_HarborLane_Inventory_File`, applies the outbound map
   `Map_InventoryFlatFile_To_InventoryUpdate` (Looping functoid plus an inline C# date functoid)
   and writes `InventoryUpdate` XML to a folder.

### 3. Shipment notification (`ShipmentNotificationOrchestration`)

1. A carrier POSTs a `ShipmentNotice` to a WCF-WebHttp request-response receive location.
2. **Expr_ValidateAndComputeEta** calls `ShipmentRules.IsValidNotice` and
   `DeliveryCalendar.EstimateDeliveryDate` (ship date plus 2, 5 or 8 business days by service level).
3. **ConstructMessage_ShipmentAck** maps the notice to a `ShipmentAck` and sets the status and ETA.
4. **Send_ShipmentAck** replies on the request-response port.
5. **Decide_NoticeAccepted**: accepted notices are also written to a FILE folder.

## Folder layout

```
HarborLane.Integration.sln                  Visual Studio 2019 solution (BizTalk Server 2020)
HarborLane.Integration.BindingInfo.xml      Application binding file for "HarborLane.Integration"
src/
  HarborLane.Integration.Schemas/           7 schemas (XML and one flat-file schema)
  HarborLane.Integration.Maps/              3 maps (.btm)
  HarborLane.Integration.Pipelines/         InventoryFlatFileReceive.btp
  HarborLane.Integration.Orchestrations/    OrderIntakeOrchestration.odx, ShipmentNotificationOrchestration.odx
  HarborLane.Integration.Helpers/           C# helper library called by the orchestrations
TestMessages/
  PurchaseOrder_Fulfilment.xml              order below 5000 (goes to fulfilment)
  PurchaseOrder_Approval.xml                order of 5000 or more (goes to approval)
  InventorySnapshot.csv                     flat-file inventory snapshot (CRLF line endings)
  ShipmentNotice.xml                        body to POST to the shipment endpoint
  ShipmentAck_Expected.xml                  the reply you should get back
```

### Binding summary

| Artifact | Name | Adapter | Address |
|----------|------|---------|---------|
| Receive port / location | `RP_HarborLane_Orders_File` / `RL_HarborLane_Orders_File` | FILE | `C:\HarborLane\In\Orders\*.xml` |
| Receive port / location | `RP_HarborLane_Inventory_File` / `RL_HarborLane_Inventory_File` | FILE | `C:\HarborLane\In\Inventory\*.csv` |
| Receive port / location (two-way) | `RP_HarborLane_Shipments_Http` / `RL_HarborLane_Shipments_Http` | WCF-WebHttp | `/HarborLaneShipments/ShipmentService.svc` (POST `/notices`) |
| Send port | `SP_HarborLane_Orders_Approval` | FILE | `C:\HarborLane\Out\Approval\%MessageID%.xml` |
| Send port | `SP_HarborLane_Orders_Fulfilment` | FILE | `C:\HarborLane\Out\Fulfilment\%MessageID%.xml` |
| Send port | `SP_HarborLane_Orders_Error` | FILE | `C:\HarborLane\Out\Errors\%MessageID%.xml` |
| Send port (filter + map) | `SP_HarborLane_Inventory_Update` | FILE | `C:\HarborLane\Out\Inventory\%MessageID%.xml` |
| Send port | `SP_HarborLane_Shipments_Archive` | FILE | `C:\HarborLane\Out\Shipments\%MessageID%.xml` |

Only standard adapters (FILE, WCF-WebHttp) and standard pipelines are used, with no custom WCF
behaviors and no custom pipeline components.

## Using it with LI

Clone this repository and point LI at this `before/` folder as the BizTalk source. See the LI
documentation for the exact commands. The sample is meant to convert with no blockers, so any gap
LI reports here is worth raising as an LI issue.

## Building the BizTalk projects (optional)

You do not need BizTalk Server to use this sample with LI. If you want to open or build it in
Visual Studio 2019 with the BizTalk Server 2020 developer tools:

1. Create a strong-name key in the repository root: `sn -k HarborLane.snk`
   (keys are git-ignored and never committed).
2. Open `HarborLane.Integration.sln` and build.
3. The public key token `8a3c51f0d27b9e46` in the binding file and pipeline is a placeholder.
   Replace it with the token of your key (`sn -T`) before importing the bindings.

The helper library alone builds with the .NET SDK on any Windows machine:

```
dotnet build src/HarborLane.Integration.Helpers
```

## License

[MIT](LICENSE)
