# Order Intake — Components

Source contract: [components.json](components.json)

## Item 1

- **Kind:** receive-location

- **Name:** RL_HarborLane_Orders_File

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Receive Port:** RP_HarborLane_Orders_File

- **Adapter:** FILE

- **Address:** C:\HarborLane\In\Orders\*.xml

- **Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLReceive

- **Enabled:** Yes

- **Polling Interval Ms:** 60000

- **Batch Size:** 20

- **File Network Retry Count:** 5

- **File Network Retry Interval Seconds:** 5

- **Remove Received File Retry Count:** 5

## Item 2

- **Kind:** orchestration

- **Name:** OrderIntakeOrchestration

- **Artifact Id:** 3fabf49a-3cac-41e2-b455-73edf3780ff7

- **Source Path:** src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx

### Details

- **Activation Receive:** Receive_PurchaseOrder

- **Scope:** Scope_ProcessOrder

- **Catch:** Catch_OrderFailure (System.Exception)

## Item 3

- **Kind:** schema

- **Name:** PurchaseOrder

- **Artifact Id:** be43cc25-a9be-47dd-b01a-cbcdcff49ddf

- **Source Path:** src/HarborLane.Integration.Schemas/PurchaseOrder.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.PurchaseOrder

## Item 4

- **Kind:** map

- **Name:** Map_PurchaseOrder_To_CanonicalOrder

- **Artifact Id:** 340189a8-5bd2-4871-b052-086477b58c5d

- **Source Path:** src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm

### Details

- **Source:** PurchaseOrder

- **Target:** CanonicalOrder

- **Behavior:** Copies order fields and repeating lines, concatenates buyer/address fields, converts yyyyMMdd to yyyy-MM-dd, initializes discount and net total to 0.00, and status to Received.

## Item 5

- **Kind:** schema

- **Name:** CanonicalOrder

- **Artifact Id:** 09894875-9b3e-4daa-bc15-335bbdc1f92d

- **Source Path:** src/HarborLane.Integration.Schemas/CanonicalOrder.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.CanonicalOrder

## Item 6

- **Kind:** schema

- **Name:** OrderError

- **Artifact Id:** 65305d9c-1266-4e93-97ab-53706ac74bde

- **Source Path:** src/HarborLane.Integration.Schemas/OrderError.xsd

### Details

- **Namespace:** http://HarborLane.Integration.Schemas.OrderError

## Item 7

- **Kind:** custom-code

- **Name:** PricingRules

- **Artifact Id:** 0a1efce2-5810-42a5-8d11-a2bb79802259

- **Source Path:** src/HarborLane.Integration.Helpers/PricingRules.cs

### Details

- **Called Method:** CalculateDiscount

## Item 8

- **Kind:** custom-code

- **Name:** ErrorMessageBuilder

- **Artifact Id:** 0b7615ea-4911-4e5f-88bb-eed16c14b762

- **Source Path:** src/HarborLane.Integration.Helpers/ErrorMessageBuilder.cs

### Details

- **Called Method:** BuildOrderError

## Item 9

- **Kind:** send-port

- **Name:** SP_HarborLane_Orders_Approval

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Adapter:** FILE

- **Address:** C:\HarborLane\Out\Approval\%MessageID%.xml

- **Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Retry Count:** 3

- **Retry Interval Minutes:** 5

## Item 10

- **Kind:** send-port

- **Name:** SP_HarborLane_Orders_Fulfilment

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Adapter:** FILE

- **Address:** C:\HarborLane\Out\Fulfilment\%MessageID%.xml

- **Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Retry Count:** 3

- **Retry Interval Minutes:** 5

## Item 11

- **Kind:** send-port

- **Name:** SP_HarborLane_Orders_Error

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

### Details

- **Adapter:** FILE

- **Address:** C:\HarborLane\Out\Errors\%MessageID%.xml

- **Pipeline:** Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Retry Count:** 3

- **Retry Interval Minutes:** 5
