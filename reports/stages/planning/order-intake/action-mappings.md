# order-intake — Action mappings

Source contract: [action-mappings.json](action-mappings.json)

- **Flow Id:** order-intake

## Mappings

### Item 1

- **Source:** RL_HarborLane_Orders_File / FILE C:\HarborLane\In\Orders\*.xml

- **Target:** AzureBlob ServiceProvider trigger When_a_blob_is_added_or_modified

#### Configuration

- REPLACE_ORDER_INPUT_CONTAINER

- REPLACE_ORDER_INPUT_FOLDER

- **Notes:** 60-second polling; File System connector is not used.

### Item 2

- **Source:** XMLReceive

- **Target:** JavaScriptCode action Check_PurchaseOrder_MessageType before Scope_ProcessOrder

- **Notes:** Parse well-formed XML and verify the PurchaseOrder root QName only; fail before the catchable scope on mismatch, with no strict XSD validation and no OrderError side effect.

### Item 3

- **Source:** Map_PurchaseOrder_To_CanonicalOrder

- **Target:** Xslt action Transform_PurchaseOrderToCanonical

- **Notes:** Convert supplied BTM behavior to XSLT.

### Item 4

- **Source:** PricingRules.CalculateDiscount

- **Target:** InvokeFunction action Expr_CalculateDiscount

- **Notes:** Dedicated local function generated from supplied code.

### Item 5

- **Source:** ConstructMessage_PricedOrder

- **Target:** Compose actions copying CanonicalOrder and assigning discount/net total

- **Notes:** Preserve message construction order.

### Item 6

- **Source:** Decide_ApprovalRequired

- **Target:** If action on decimal OrderTotal >= 5000

- **Notes:** Approval branch and else fulfilment branch.

### Item 7

- **Source:** SP_HarborLane_Orders_Approval

- **Target:** AzureBlob ServiceProvider upload action Send_ToApproval

#### Configuration

- REPLACE_ORDER_APPROVAL_CONTAINER

- REPLACE_ORDER_APPROVAL_FOLDER

#### Retry

- **Count:** 3

- **Interval:** PT5M

### Item 8

- **Source:** SP_HarborLane_Orders_Fulfilment

- **Target:** AzureBlob ServiceProvider upload action Send_ToFulfilment

#### Configuration

- REPLACE_ORDER_FULFILMENT_CONTAINER

- REPLACE_ORDER_FULFILMENT_FOLDER

#### Retry

- **Count:** 3

- **Interval:** PT5M

### Item 9

- **Source:** Catch_OrderFailure

- **Target:** Catch_OrderFailure Scope with runAfter Decide_ApprovalRequired = Failed/TimedOut/Skipped

- **Notes:** Earlier processing failures cascade to Decide_ApprovalRequired as Skipped; successful processing skips the catch.

### Item 10

- **Source:** ErrorMessageBuilder.BuildOrderError

- **Target:** InvokeFunction action Assign_OrderError

- **Notes:** Dedicated local function generated from supplied code.

### Item 11

- **Source:** SP_HarborLane_Orders_Error

- **Target:** AzureBlob ServiceProvider upload action Send_OrderError

#### Configuration

- REPLACE_ORDER_ERROR_CONTAINER

- REPLACE_ORDER_ERROR_FOLDER

#### Retry

- **Count:** 3

- **Interval:** PT5M
