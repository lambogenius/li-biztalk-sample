# Order Intake — Dependencies

Source contract: [dependencies.json](dependencies.json)

## Schemas

- be43cc25-a9be-47dd-b01a-cbcdcff49ddf

- 09894875-9b3e-4daa-bc15-335bbdc1f92d

- 65305d9c-1266-4e93-97ab-53706ac74bde

## Maps

- 340189a8-5bd2-4871-b052-086477b58c5d

## Bindings

### Item 1

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

#### Ports

- RP_HarborLane_Orders_File

- SP_HarborLane_Orders_Approval

- SP_HarborLane_Orders_Fulfilment

- SP_HarborLane_Orders_Error

## Custom Code

| Class | Method | Artifact Id | Source Path | Orchestration | Use |
| --- | --- | --- | --- | --- | --- |
| HarborLane.Integration.Helpers.PricingRules | CalculateDiscount | 0a1efce2-5810-42a5-8d11-a2bb79802259 | src/HarborLane.Integration.Helpers/PricingRules.cs | src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx | Calculates the monetary discount from OrderTotal and CustomerTier: Gold 10%, Silver 5%, other 0%, plus 1% for totals at least 1000; rounds to two decimals away from zero. |
| HarborLane.Integration.Helpers.ErrorMessageBuilder | BuildOrderError | 0b7615ea-4911-4e5f-88bb-eed16c14b762 | src/HarborLane.Integration.Helpers/ErrorMessageBuilder.cs | src/HarborLane.Integration.Orchestrations/OrderIntakeOrchestration.odx | Builds an OrderError XML document containing flow name, order reference, exception text, and a UTC occurrence timestamp. |

## External Systems

### Item 1

- **Type:** file-system

- **Role:** input

- **Address:** C:\HarborLane\In\Orders\*.xml

### Item 2

- **Type:** file-system

- **Role:** output

#### Addresses

- C:\HarborLane\Out\Approval\%MessageID%.xml

- C:\HarborLane\Out\Fulfilment\%MessageID%.xml

- C:\HarborLane\Out\Errors\%MessageID%.xml
