# order-intake — Workflow order intake

Source contract: [workflow-order-intake.json](workflow-order-intake.json)

- **Name:** wf-order-intake

- **Runtime Path:** logicapp/wf-order-intake/workflow.json

- **Kind:** Stateful

## Source Artifact Ids

- 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- 3fabf49a-3cac-41e2-b455-73edf3780ff7

- be43cc25-a9be-47dd-b01a-cbcdcff49ddf

- 09894875-9b3e-4daa-bc15-335bbdc1f92d

- 65305d9c-1266-4e93-97ab-53706ac74bde

- 340189a8-5bd2-4871-b052-086477b58c5d

- 0a1efce2-5810-42a5-8d11-a2bb79802259

- 0b7615ea-4911-4e5f-88bb-eed16c14b762

## Trigger

- **Name:** Receive_PurchaseOrder

- **Type:** ServiceProvider

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** When_a_blob_is_added_or_modified

### Recurrence

- **Frequency:** Second

- **Interval:** 60

### Configuration

- REPLACE_ORDER_INPUT_CONTAINER

- REPLACE_ORDER_INPUT_FOLDER

- **Split On:** one workflow run per blob

## Actions

### Item 1

- **Name:** Check_PurchaseOrder_MessageType

- **Type:** JavaScriptCode

- **Behavior:** Parse well-formed XML and require root QName {http://HarborLane.Integration.Schemas.PurchaseOrder}PurchaseOrder; fail the run before Scope_ProcessOrder on mismatch so Catch_OrderFailure cannot emit OrderError.

### Item 2

- **Name:** Scope_ProcessOrder

- **Type:** Scope

#### Run After

##### Check Purchase Order Message Type

- Succeeded

#### Children

- ConstructMessage_CanonicalOrder

- Expr_CalculateDiscount

- ConstructMessage_PricedOrder

- Decide_ApprovalRequired

- Catch_OrderFailure

### Item 3

- **Name:** ConstructMessage_CanonicalOrder

- **Type:** Scope

- **Parent:** Scope_ProcessOrder

#### Children

- Transform_PurchaseOrderToCanonical

- Construct_CanonicalOrder_MessagePartReference_1

- Construct_CanonicalOrder_MessagePartReference_2

- Construct_CanonicalOrder_MessageRef

### Item 4

- **Name:** Transform_PurchaseOrderToCanonical

- **Type:** Xslt

- **Parent:** ConstructMessage_CanonicalOrder

- **Map:** Map_PurchaseOrder_To_CanonicalOrder.xslt

### Item 5

- **Name:** Expr_CalculateDiscount

- **Type:** InvokeFunction

- **Parent:** Scope_ProcessOrder

- **Function:** PricingRules_CalculateDiscount

### Item 6

- **Name:** ConstructMessage_PricedOrder

- **Type:** Scope

- **Parent:** Scope_ProcessOrder

#### Children

- Construct_PricedOrder_Assign_PricedOrder

- Construct_PricedOrder_MessageRef

### Item 7

- **Name:** Construct_PricedOrder_Assign_PricedOrder

- **Type:** Compose

- **Parent:** ConstructMessage_PricedOrder

### Item 8

- **Name:** Decide_ApprovalRequired

- **Type:** If

- **Parent:** Scope_ProcessOrder

- **Expression:** decimal(OrderTotal) >= 5000

- **True Action:** Send_ToApproval

- **False Action:** Send_ToFulfilment

### Item 9

- **Name:** Send_ToApproval

- **Type:** ServiceProvider

- **Parent:** Decide_ApprovalRequired/actions

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** uploadBlob

#### Retry

- **Type:** fixed

- **Count:** 3

- **Interval:** PT5M

### Item 10

- **Name:** Send_ToFulfilment

- **Type:** ServiceProvider

- **Parent:** Decide_ApprovalRequired/else/actions

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** uploadBlob

#### Retry

- **Type:** fixed

- **Count:** 3

- **Interval:** PT5M

### Item 11

- **Name:** Catch_OrderFailure

- **Type:** Scope

- **Parent:** Scope_ProcessOrder

#### Run After

##### Decide Approval Required

- Failed

- TimedOut

- Skipped

#### Children

- ConstructMessage_OrderError

- Send_OrderError

### Item 12

- **Name:** ConstructMessage_OrderError

- **Type:** Scope

- **Parent:** Catch_OrderFailure

#### Children

- Construct_OrderError_Assign_OrderError

- Construct_OrderError_MessageRef

### Item 13

- **Name:** Construct_OrderError_Assign_OrderError

- **Type:** InvokeFunction

- **Parent:** ConstructMessage_OrderError

- **Function:** ErrorMessageBuilder_BuildOrderError

### Item 14

- **Name:** Send_OrderError

- **Type:** ServiceProvider

- **Parent:** Catch_OrderFailure

- **Service Provider:** /serviceProviders/AzureBlob

- **Operation:** uploadBlob

#### Retry

- **Type:** fixed

- **Count:** 3

- **Interval:** PT5M

- **Ordering:** The XML well-formedness/root-QName check completes before Scope_ProcessOrder. Inside the scope, mapping, pricing, construction, and exactly one routing branch run sequentially. Catch_OrderFailure explicitly runs after Decide_ApprovalRequired is Failed, TimedOut, or Skipped and is skipped when that action succeeds. Ordered delivery is not enabled.

- **Retry Error Behavior:** Blob uploads use three fixed retries at five-minute intervals. Processing failures build OrderError. Error-upload or terminal send failure fails the run and alerts are an unresolved owner gate.

## Inputs

| Name | Format | Message Type | Runtime Validation | Source |
| --- | --- | --- | --- | --- |
| PurchaseOrder | XML | {http://HarborLane.Integration.Schemas.PurchaseOrder}PurchaseOrder | well-formed XML and root QName only; no strict XSD validation | configured Blob container/folder |

## Outputs

| Name | Condition | Destination |
| --- | --- | --- |
| CanonicalOrder | OrderTotal >= 5000 | approval Blob container/folder |
| CanonicalOrder | else | fulfilment Blob container/folder |
| OrderError | processing failure | error Blob container/folder |

## Configuration Needs

- REPLACE_ORDER_INPUT_CONTAINER

- REPLACE_ORDER_INPUT_FOLDER

- REPLACE_ORDER_APPROVAL_CONTAINER

- REPLACE_ORDER_APPROVAL_FOLDER

- REPLACE_ORDER_FULFILMENT_CONTAINER

- REPLACE_ORDER_FULFILMENT_FOLDER

- REPLACE_ORDER_ERROR_CONTAINER

- REPLACE_ORDER_ERROR_FOLDER

- managed identity Blob RBAC

- Key Vault-backed settings if secrets are introduced

## Network

- **Public Endpoints:** Yes

- **Https Only:** Yes

- **Private Networking:** No

- **Recommendation:** Owner may evaluate IP restrictions or private networking in a later approved change.
