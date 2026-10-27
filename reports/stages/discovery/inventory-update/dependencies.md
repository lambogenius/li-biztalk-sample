# Inventory Update — Dependencies

Source contract: [dependencies.json](dependencies.json)

## Schemas

- 34872ed2-8c16-4108-bc40-3fe72970de23

- b64dd345-a34a-440a-99ee-889a021cfcce

## Maps

- 6c00b69b-2efc-4e0b-a722-6b017ac04c9f

## Pipelines

- 8b374df5-c3df-49e4-8c0d-70c8f0758e66

## Bindings

### Item 1

- **Artifact Id:** 2f24ba50-d70a-438c-9f1a-cdd172fbdfcd

- **Source Path:** HarborLane.Integration.BindingInfo.xml

#### Ports

- RP_HarborLane_Inventory_File

- SP_HarborLane_Inventory_Update

- **Subscription:** BTS.ReceivePortName == RP_HarborLane_Inventory_File

## Custom Code

_None._

## External Systems

| Type | Role | Address |
| --- | --- | --- |
| file-system | input | C:\HarborLane\In\Inventory\*.csv |
| file-system | output | C:\HarborLane\Out\Inventory\%MessageID%.xml |
