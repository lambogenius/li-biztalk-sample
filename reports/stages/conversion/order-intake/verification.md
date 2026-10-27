# order-intake — Verification

Source contract: [verification.json](verification.json)

- **Version:** 1

- **Engine:** microsoft

- **Execution Mode:** workspace-agent

- **Structural Coverage:** passed

- **Candidate Hash:** d5e0e459c2369f46edf43116c9e82d22054ae933e9e241814ff014d576147df3

- **Attempt Id:** 17164048a33d

## Files

| Path | Bytes | Sha256 |
| --- | --- | --- |
| .vscode/migration/conversion/placeholders.json | 2806 | 55143ddadd4e9a74e046849179173e4f89df388623bf0f6b3303d6f7180e077b |
| Functions/HarborLane.Integration.Functions.csproj | 1008 | 5712e64c3ad032a6368322f8d49f83708d27f9e9f636af8ed6c8750ba1b1ea0b |
| Functions/SourceRules.cs | 3402 | 6967b9c6f09a47f03f0ab8a6e6edc69b1f9dc6de7f6d09a6b5ae518d346965d1 |
| Functions/WorkflowFunctions.cs | 2740 | bb28f3c7de16204297d96aa1d85976424634bd149fbcd3c08ddb093e2ab55361 |
| infra/main.bicep | 8748 | 4bdcff4e3b2c7c4dbb57fa1a80fe7ab534c9a43bcb486b723b716746242c88af |
| infra/params/dev.bicepparam | 131 | 13cbaf157fe6df3d448dbd510aa5e92aae1221973f5ab432b17318ed67913929 |
| infra/params/prod.bicepparam | 133 | 559095242a12b2f84c8ba26b8e89fd12d9cc8fc7b828524931be4fb22c316ca5 |
| infra/params/uat.bicepparam | 131 | 5aa98ef1845d68ab388c1b7e3c619915a1de61d72fafc1f958b6bd13f2148902 |
| logicapp/Artifacts/Maps/Apply_Pricing_To_CanonicalOrder.xslt | 728 | 78127fac96a096c3bcdb6ffbb356591f04f9af860fdb1ad25dcdfa5d90b57e8e |
| logicapp/Artifacts/Maps/Map_InventoryFlatFile_To_InventoryUpdate.xslt | 1552 | 89f2ee790c4a7cfccf2c4d6b9bc8f0761a328d3988eff8688e2808d32c8fb9e7 |
| logicapp/Artifacts/Maps/Map_PurchaseOrder_To_CanonicalOrder.xslt | 2251 | 085febacbcaef2c16ff665b8abd086e79341f77731fac81ca3e9d55251f8622c |
| logicapp/Artifacts/Maps/Map_ShipmentNotice_To_ShipmentAck.xslt | 866 | 5948f0ecf0bca5d6e90431eaab95813c398ff7f519ea03557e7c55e9df265658 |
| logicapp/Artifacts/Schemas/CanonicalOrder.xsd | 1387 | 0fc12ae6254ba7e526c3cad44907851a8517cd6673e3aa4e98b6e5aaba3916b1 |
| logicapp/Artifacts/Schemas/InventoryFlatFile.xsd | 3809 | cfcb8501925f288e2dbf9e60d506c5df4a4802949aaf3cfae1b6f223fc43cad4 |
| logicapp/Artifacts/Schemas/InventoryUpdate.xsd | 891 | b29cdde09d7a1af33ea6a99d8c71ac64a7ee3f98f691af4f76f69d3f2ebc5c61 |
| logicapp/Artifacts/Schemas/OrderError.xsd | 536 | 48a5ef2aeea674ab624c7e8e95fbf0af2d8bdc7a57095e1e00911bea5f92582e |
| logicapp/Artifacts/Schemas/PurchaseOrder.xsd | 1758 | d5694e5ef8af96e24fe0f1d85b12d0057636db00526c2ebd72a0b49b45a21179 |
| logicapp/Artifacts/Schemas/ShipmentAck.xsd | 585 | 751b7fb10dda9f3ed9261a2173efe18a0a016892cc52abe17a4080ca5cf5689c |
| logicapp/Artifacts/Schemas/ShipmentNotice.xsd | 923 | 4501f1cf6e74e3b366cae869519cd53873562f5a099b5059d4dce88ad04fb2d3 |
| logicapp/connections.json | 485 | 7251457b9ef75a149bddb6b336776b8f28a9d68c412995616117f48ec5a38cf2 |
| logicapp/host.json | 274 | 366f66a635fbfa01a32a17583ac321b9586bfca241dacfea1bbf62dc8b5f77df |
| logicapp/wf-inventory-update/workflow.json | 3757 | 08c9940cab5e7122b6e143aa6edb4e0c9ec206ca8d62155df80a538d89e1f058 |
| logicapp/wf-order-intake/workflow.json | 13408 | e90616416a84c8a698b72af690edc2560302e3f8205d71ca018573c19c076bb9 |
| logicapp/wf-shipment-notification/workflow.json | 9807 | adf1a87b7d6c5f26c3f2ec627dba93762f6e096a187a1b28d80d774b99c3ce22 |
| tests/messages/InventorySnapshot.csv | 235 | b1559917f0069e28672c891608c7126577190d0302958474a448c65ebe486542 |
| tests/messages/PurchaseOrder_Approval.xml | 951 | 87cbb114f59677973ae039d98e0f52f9ff70df752af2f52e4be2c3c03dfb6173 |
| tests/messages/PurchaseOrder_Fulfilment.xml | 1110 | dfbb3e4fc318b374c54d15f1b485fcf9d52f2337e6b14624fd3ad66fb3287fdd |
| tests/messages/ShipmentNotice_Rejected.xml | 494 | f89c82c46f68207afb65e844c042c8da0dcf35542e1b3fd7371edc00e5ba5523 |
| tests/messages/ShipmentNotice.xml | 499 | d9cb0527586035ca9b018159f593eb8ca158bebcb92eda0bc6093f73fde5c09b |
| tests/validate-conversion.ps1 | 21165 | fadfc3f26472d6eea608cfaf0eda7634c94ac63c0b45d00f7b46364db49a81d9 |
| tests/workflow-runs.json | 2755 | 94bc854b809839b2ec10816170404131f72a5a9e0391ef537515873dfb1e62bf |

- **Verified At:** 2026-10-27T00:13:32.917Z
