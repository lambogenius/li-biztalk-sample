# Precheck Outcome — Migration precheck conversion 2026 10 26 T23 47 36 861 Z

Source contract: [migration-precheck-conversion-2026-10-26T23-47-36-861Z.json](migration-precheck-conversion-2026-10-26T23-47-36-861Z.json)

- **Ready:** Yes

- **Stage:** conversion

- **Readiness:** ready-with-warnings

- **Checked At:** 2026-10-26T23:47:36.861Z

## Items

### Item 1

- **Id:** microsoft-context

- **Description:** Microsoft stage context capacity (conservative UTF-8 bound)

- **Status:** passed

#### Matches

- groups: 51935 minimum prompt bytes / 700000 available

- discovery: 202283 minimum prompt bytes / 700000 available

- planning: 187935 minimum prompt bytes / 700000 available

- task-plan: 49906 minimum prompt bytes / 700000 available

- task: 72547 minimum prompt bytes / 700000 available

### Item 2

- **Id:** powershell-7

- **Description:** PowerShell 7 runtime

- **Status:** passed

#### Matches

- PowerShell 7.6.9

### Item 3

- **Id:** azure-bicep

- **Description:** Azure CLI with Bicep

- **Status:** passed

#### Matches

- Bicep CLI version 0.46.1 (545b338e2c)
<br><br>WARNING: A new Bicep release is available: v0.48.1. Upgrade now by running "az bicep upgrade".

### Item 4

- **Id:** source-repository

- **Description:** BizTalk source repository

- **Status:** passed

#### Matches

- <sample>

### Item 5

- **Id:** application-repository

- **Description:** Writable Logic Apps output repository (no external starter configured)

- **Status:** passed

#### Matches

- <run>/reports\worktrees\HarborLane.Integration

### Item 6

- **Id:** validation-scripts

- **Description:** Validation scripts in the application repository (no starter)

- **Status:** warning

#### Matches

_None._

- **Guidance:** The Test stage runs these scripts, and no starter provides them. Missing: build.ps1, tests/run-tests.ps1, scripts/validate-deployment.ps1. The conversion agent will have to write them, using repair and reviewer budget. Add them to the application repository, or enable repositoryScaffolding with a starter.

### Item 7

- **Id:** package-iac-templates

- **Description:** Optional IaC templates for the deployment package

- **Status:** passed

#### Matches

- not configured; the package omits shared IaC modules

### Item 8

- **Id:** pipeline-templates

- **Description:** Optional pipeline templates for the deployment package

- **Status:** passed

#### Matches

- not configured; the package omits shared pipeline templates

### Item 9

- **Id:** standards-documents

- **Description:** Optional external standards

- **Status:** passed

#### Matches

- not configured; pinned Microsoft baseline applies

### Item 10

- **Id:** migration-extensions

- **Description:** Optional v3 extension resources

- **Status:** passed

#### Matches

- not configured or disabled; pinned Microsoft baseline applies

### Item 11

- **Id:** DEPENDENCY_NOT_VERIFIED:0

- **Description:** biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLReceive

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: HarborLane.Integration.BindingInfo.xml<br>Needs: biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLReceive<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\Microsoft.BizTalk.DefaultPipelines.XMLReceive<br>Evidence: BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.<br>Next step: Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** HarborLane.Integration.BindingInfo.xml

- **Requirement:** biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLReceive

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\Microsoft.BizTalk.DefaultPipelines.XMLReceive

- **Action:** Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.

### Item 12

- **Id:** DEPENDENCY_SOURCE_AVAILABLE:1

- **Description:** biztalk-component: HarborLane.Integration.Pipelines.InventoryFlatFileReceive

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_SOURCE_AVAILABLE] WARNING<br>Affected: HarborLane.Integration.BindingInfo.xml<br>Needs: biztalk-component: HarborLane.Integration.Pipelines.InventoryFlatFileReceive<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\HarborLane.Integration.Pipelines.InventoryFlatFileReceive; Unverified candidate: <sample>\src\HarborLane.Integration.Pipelines\HarborLane.Integration.Pipelines.btproj<br>Evidence: BizTalk component declaration matched a source project in the recursive source inventory. Source is retained for migration without requiring a prior DLL build; assembly identity/version and runtime behavior require verification.<br>Next step: Use the supplied source project(s) for migration: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj. No prior DLL build is required for analysis. Verify assembly identity/version and any ambiguous candidates before relying on binary compatibility.

#### Diagnostic

- **Code:** DEPENDENCY_SOURCE_AVAILABLE

- **Severity:** warning

- **Artifact:** HarborLane.Integration.BindingInfo.xml

- **Requirement:** biztalk-component: HarborLane.Integration.Pipelines.InventoryFlatFileReceive

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\HarborLane.Integration.Pipelines.InventoryFlatFileReceive

- Unverified candidate: <sample>\src\HarborLane.Integration.Pipelines\HarborLane.Integration.Pipelines.btproj

- **Evidence:** BizTalk component declaration matched a source project in the recursive source inventory. Source is retained for migration without requiring a prior DLL build; assembly identity/version and runtime behavior require verification.

- **Action:** Use the supplied source project(s) for migration: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj. No prior DLL build is required for analysis. Verify assembly identity/version and any ambiguous candidates before relying on binary compatibility.

### Item 13

- **Id:** DEPENDENCY_NOT_VERIFIED:2

- **Description:** biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLReceive

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: HarborLane.Integration.BindingInfo.xml<br>Needs: biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLReceive<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\Microsoft.BizTalk.DefaultPipelines.XMLReceive<br>Evidence: BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.<br>Next step: Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** HarborLane.Integration.BindingInfo.xml

- **Requirement:** biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLReceive

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\Microsoft.BizTalk.DefaultPipelines.XMLReceive

- **Action:** Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.

### Item 14

- **Id:** DEPENDENCY_NOT_VERIFIED:3

- **Description:** biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: HarborLane.Integration.BindingInfo.xml<br>Needs: biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLTransmit<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\Microsoft.BizTalk.DefaultPipelines.XMLTransmit<br>Evidence: BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.<br>Next step: Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** HarborLane.Integration.BindingInfo.xml

- **Requirement:** biztalk-component: Microsoft.BizTalk.DefaultPipelines.XMLTransmit

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\Microsoft.BizTalk.DefaultPipelines.XMLTransmit

- **Action:** Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.

### Item 15

- **Id:** DEPENDENCY_NOT_VERIFIED:4

- **Description:** msbuild-sdk: Microsoft.NET.Sdk

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Helpers/HarborLane.Integration.Helpers.csproj<br>Needs: msbuild-sdk: Microsoft.NET.Sdk<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Helpers\Microsoft.NET.Sdk<br>Evidence: SDK availability is not checked.<br>Next step: Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Helpers/HarborLane.Integration.Helpers.csproj

- **Requirement:** msbuild-sdk: Microsoft.NET.Sdk

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Helpers\Microsoft.NET.Sdk

- **Action:** Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** SDK availability is not checked.

### Item 16

- **Id:** DEPENDENCY_NOT_VERIFIED:5

- **Description:** assembly-reference: System.Xml

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Helpers/HarborLane.Integration.Helpers.csproj<br>Needs: assembly-reference: System.Xml<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Helpers\System.Xml<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Helpers/HarborLane.Integration.Helpers.csproj

- **Requirement:** assembly-reference: System.Xml

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Helpers\System.Xml

- **Action:** Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 17

- **Id:** DEPENDENCY_NOT_VERIFIED:6

- **Description:** assembly-reference: System

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: System<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\System<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: System

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\System

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 18

- **Id:** DEPENDENCY_NOT_VERIFIED:7

- **Description:** assembly-reference: System.Xml

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: System.Xml<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\System.Xml<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: System.Xml

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\System.Xml

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 19

- **Id:** DEPENDENCY_NOT_VERIFIED:8

- **Description:** assembly-reference: System.Configuration

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: System.Configuration<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\System.Configuration<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: System.Configuration

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\System.Configuration

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 20

- **Id:** DEPENDENCY_NOT_VERIFIED:9

- **Description:** assembly-reference: Microsoft.BizTalk.Pipeline

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.Pipeline<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.Pipeline<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.Pipeline

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.Pipeline

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 21

- **Id:** DEPENDENCY_NOT_VERIFIED:10

- **Description:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.DefaultPipelines<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.DefaultPipelines<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.DefaultPipelines

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 22

- **Id:** DEPENDENCY_NOT_VERIFIED:11

- **Description:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.GlobalPropertySchemas<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.GlobalPropertySchemas

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 23

- **Id:** DEPENDENCY_NOT_VERIFIED:12

- **Description:** assembly-reference: Microsoft.BizTalk.TestTools

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.TestTools<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.TestTools<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.TestTools

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.BizTalk.TestTools

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 24

- **Id:** DEPENDENCY_NOT_VERIFIED:13

- **Description:** assembly-reference: Microsoft.XLANGs.BaseTypes

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: assembly-reference: Microsoft.XLANGs.BaseTypes<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.XLANGs.BaseTypes<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** assembly-reference: Microsoft.XLANGs.BaseTypes

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Maps\Microsoft.XLANGs.BaseTypes

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 25

- **Id:** DEPENDENCY_NOT_VERIFIED:14

- **Description:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 26

- **Id:** DEPENDENCY_NOT_VERIFIED:15

- **Description:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj<br>Needs: msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj

- **Requirement:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 27

- **Id:** DEPENDENCY_NOT_VERIFIED:16

- **Description:** assembly-reference: 

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/Map_InventoryFlatFile_To_InventoryUpdate.btm<br>Needs: assembly-reference: <br>Checked: Selected source inventory: <sample><br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/Map_InventoryFlatFile_To_InventoryUpdate.btm

- **Requirement:** assembly-reference: 

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 28

- **Id:** DEPENDENCY_NOT_VERIFIED:17

- **Description:** assembly-reference: 

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/Map_InventoryFlatFile_To_InventoryUpdate.btm<br>Needs: assembly-reference: <br>Checked: Selected source inventory: <sample><br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/Map_InventoryFlatFile_To_InventoryUpdate.btm

- **Requirement:** assembly-reference: 

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 29

- **Id:** DEPENDENCY_NOT_VERIFIED:18

- **Description:** assembly-reference: 

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm<br>Needs: assembly-reference: <br>Checked: Selected source inventory: <sample><br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm

- **Requirement:** assembly-reference: 

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 30

- **Id:** DEPENDENCY_NOT_VERIFIED:19

- **Description:** assembly-reference: 

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm<br>Needs: assembly-reference: <br>Checked: Selected source inventory: <sample><br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/Map_PurchaseOrder_To_CanonicalOrder.btm

- **Requirement:** assembly-reference: 

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 31

- **Id:** DEPENDENCY_NOT_VERIFIED:20

- **Description:** assembly-reference: 

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm<br>Needs: assembly-reference: <br>Checked: Selected source inventory: <sample><br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm

- **Requirement:** assembly-reference: 

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 32

- **Id:** DEPENDENCY_NOT_VERIFIED:21

- **Description:** assembly-reference: 

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm<br>Needs: assembly-reference: <br>Checked: Selected source inventory: <sample><br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Maps/Map_ShipmentNotice_To_ShipmentAck.btm

- **Requirement:** assembly-reference: 

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Maps/HarborLane.Integration.Maps.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 33

- **Id:** DEPENDENCY_NOT_VERIFIED:22

- **Description:** assembly-reference: System

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: System<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\System<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: System

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\System

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 34

- **Id:** DEPENDENCY_NOT_VERIFIED:23

- **Description:** assembly-reference: System.Xml

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: System.Xml<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\System.Xml<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: System.Xml

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\System.Xml

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 35

- **Id:** DEPENDENCY_NOT_VERIFIED:24

- **Description:** assembly-reference: System.Configuration

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: System.Configuration<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\System.Configuration<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: System.Configuration

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\System.Configuration

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 36

- **Id:** DEPENDENCY_NOT_VERIFIED:25

- **Description:** assembly-reference: Microsoft.BizTalk.Pipeline

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.Pipeline<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.Pipeline<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.Pipeline

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.Pipeline

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 37

- **Id:** DEPENDENCY_NOT_VERIFIED:26

- **Description:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.DefaultPipelines<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.DefaultPipelines<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.DefaultPipelines

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 38

- **Id:** DEPENDENCY_NOT_VERIFIED:27

- **Description:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.GlobalPropertySchemas<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.GlobalPropertySchemas

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 39

- **Id:** DEPENDENCY_NOT_VERIFIED:28

- **Description:** assembly-reference: Microsoft.BizTalk.TestTools

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.TestTools<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.TestTools<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.TestTools

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.BizTalk.TestTools

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 40

- **Id:** DEPENDENCY_NOT_VERIFIED:29

- **Description:** assembly-reference: Microsoft.XLANGs.BaseTypes

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: assembly-reference: Microsoft.XLANGs.BaseTypes<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.XLANGs.BaseTypes<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** assembly-reference: Microsoft.XLANGs.BaseTypes

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Orchestrations\Microsoft.XLANGs.BaseTypes

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 41

- **Id:** DEPENDENCY_NOT_VERIFIED:30

- **Description:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 42

- **Id:** DEPENDENCY_NOT_VERIFIED:31

- **Description:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj<br>Needs: msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj

- **Requirement:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Orchestrations/HarborLane.Integration.Orchestrations.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 43

- **Id:** DEPENDENCY_NOT_VERIFIED:32

- **Description:** assembly-reference: System

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: System<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\System<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: System

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\System

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 44

- **Id:** DEPENDENCY_NOT_VERIFIED:33

- **Description:** assembly-reference: System.Xml

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: System.Xml<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\System.Xml<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: System.Xml

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\System.Xml

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 45

- **Id:** DEPENDENCY_NOT_VERIFIED:34

- **Description:** assembly-reference: System.Configuration

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: System.Configuration<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\System.Configuration<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: System.Configuration

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\System.Configuration

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 46

- **Id:** DEPENDENCY_NOT_VERIFIED:35

- **Description:** assembly-reference: Microsoft.BizTalk.Pipeline

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.Pipeline<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.Pipeline<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.Pipeline

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.Pipeline

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 47

- **Id:** DEPENDENCY_NOT_VERIFIED:36

- **Description:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.DefaultPipelines<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.DefaultPipelines<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.DefaultPipelines

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 48

- **Id:** DEPENDENCY_NOT_VERIFIED:37

- **Description:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.GlobalPropertySchemas<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.GlobalPropertySchemas

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 49

- **Id:** DEPENDENCY_NOT_VERIFIED:38

- **Description:** assembly-reference: Microsoft.BizTalk.TestTools

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.TestTools<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.TestTools<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.TestTools

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.TestTools

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 50

- **Id:** DEPENDENCY_NOT_VERIFIED:39

- **Description:** assembly-reference: Microsoft.XLANGs.BaseTypes

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: assembly-reference: Microsoft.XLANGs.BaseTypes<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.XLANGs.BaseTypes<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** assembly-reference: Microsoft.XLANGs.BaseTypes

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.XLANGs.BaseTypes

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 51

- **Id:** DEPENDENCY_NOT_VERIFIED:40

- **Description:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 52

- **Id:** DEPENDENCY_NOT_VERIFIED:41

- **Description:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj<br>Needs: msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj

- **Requirement:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 53

- **Id:** DEPENDENCY_NOT_VERIFIED:42

- **Description:** biztalk-component: Microsoft.BizTalk.Component.FFDasmComp

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Pipelines/InventoryFlatFileReceive.btp<br>Needs: biztalk-component: Microsoft.BizTalk.Component.FFDasmComp<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.Component.FFDasmComp<br>Evidence: BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Pipelines/InventoryFlatFileReceive.btp

- **Requirement:** biztalk-component: Microsoft.BizTalk.Component.FFDasmComp

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Pipelines\Microsoft.BizTalk.Component.FFDasmComp

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Pipelines/HarborLane.Integration.Pipelines.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** BizTalk component/assembly declaration; candidate identities, runtime deployment, and binding behavior require verification.

### Item 54

- **Id:** DEPENDENCY_NOT_VERIFIED:43

- **Description:** assembly-reference: System

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: System<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\System<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: System

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\System

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 55

- **Id:** DEPENDENCY_NOT_VERIFIED:44

- **Description:** assembly-reference: System.Xml

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: System.Xml<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\System.Xml<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: System.Xml

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\System.Xml

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 56

- **Id:** DEPENDENCY_NOT_VERIFIED:45

- **Description:** assembly-reference: System.Configuration

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: System.Configuration<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\System.Configuration<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: System.Configuration

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\System.Configuration

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 57

- **Id:** DEPENDENCY_NOT_VERIFIED:46

- **Description:** assembly-reference: Microsoft.BizTalk.Pipeline

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.Pipeline<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.Pipeline<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.Pipeline

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.Pipeline

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 58

- **Id:** DEPENDENCY_NOT_VERIFIED:47

- **Description:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.DefaultPipelines<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.DefaultPipelines<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.DefaultPipelines

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.DefaultPipelines

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 59

- **Id:** DEPENDENCY_NOT_VERIFIED:48

- **Description:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.GlobalPropertySchemas<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.GlobalPropertySchemas

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.GlobalPropertySchemas

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 60

- **Id:** DEPENDENCY_NOT_VERIFIED:49

- **Description:** assembly-reference: Microsoft.BizTalk.TestTools

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: Microsoft.BizTalk.TestTools<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.TestTools<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: Microsoft.BizTalk.TestTools

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.BizTalk.TestTools

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 61

- **Id:** DEPENDENCY_NOT_VERIFIED:50

- **Description:** assembly-reference: Microsoft.XLANGs.BaseTypes

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: assembly-reference: Microsoft.XLANGs.BaseTypes<br>Checked: Selected source inventory: <sample>; Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.XLANGs.BaseTypes<br>Evidence: Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** assembly-reference: Microsoft.XLANGs.BaseTypes

##### Searched

- Selected source inventory: <sample>

- Declared path (not read outside source root): <sample>\src\HarborLane.Integration.Schemas\Microsoft.XLANGs.BaseTypes

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Verify this external/framework/assembly dependency in the intended build environment. Supply application-owned binaries or source if needed; this scan does not inspect GAC or DLL implementation.

- **Evidence:** Assembly identity declared in project; version/public-key identity and GAC/framework availability are not verified.

### Item 62

- **Id:** DEPENDENCY_NOT_VERIFIED:51

- **Description:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** msbuild-import: $(MSBuildToolsPath)\Microsoft.CSharp.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 63

- **Id:** DEPENDENCY_NOT_VERIFIED:52

- **Description:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

- **Status:** warning

#### Matches

_None._

- **Guidance:** [DEPENDENCY_NOT_VERIFIED] WARNING<br>Affected: src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj<br>Needs: msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets<br>Checked: Selected source inventory: <sample><br>Evidence: MSBuild property, item expression, or wildcard requires evaluation.<br>Next step: Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

#### Diagnostic

- **Code:** DEPENDENCY_NOT_VERIFIED

- **Severity:** warning

- **Artifact:** src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj

- **Requirement:** msbuild-import: $(MSBuildExtensionsPath)\Microsoft\BizTalk\BizTalkC.targets

##### Searched

- Selected source inventory: <sample>

- **Action:** Not needed to migrate: it belongs to test project src/HarborLane.Integration.Schemas/HarborLane.Integration.Schemas.btproj, which is not migrated as runtime code. Evaluate this reference for the intended build configuration; supply any required generated/imported artifacts. This static scan does not evaluate MSBuild conditions or properties.

- **Evidence:** MSBuild property, item expression, or wildcard requires evaluation.

### Item 64

- **Id:** biztalk-projects

- **Description:** BizTalk solution/project definitions

- **Status:** passed

#### Matches

- <sample>\HarborLane.Integration.sln

- <sample>\src\HarborLane.Integration.Maps\HarborLane.Integration.Maps.btproj

- <sample>\src\HarborLane.Integration.Orchestrations\HarborLane.Integration.Orchestrations.btproj

- <sample>\src\HarborLane.Integration.Pipelines\HarborLane.Integration.Pipelines.btproj

- <sample>\src\HarborLane.Integration.Schemas\HarborLane.Integration.Schemas.btproj

### Item 65

- **Id:** biztalk-processes

- **Description:** BizTalk orchestrations, maps, pipelines, or schemas

- **Status:** passed

#### Matches

- <sample>\src\HarborLane.Integration.Maps\Map_InventoryFlatFile_To_InventoryUpdate.btm

- <sample>\src\HarborLane.Integration.Maps\Map_PurchaseOrder_To_CanonicalOrder.btm

- <sample>\src\HarborLane.Integration.Maps\Map_ShipmentNotice_To_ShipmentAck.btm

- <sample>\src\HarborLane.Integration.Orchestrations\OrderIntakeOrchestration.odx

- <sample>\src\HarborLane.Integration.Orchestrations\ShipmentNotificationOrchestration.odx

- <sample>\src\HarborLane.Integration.Pipelines\InventoryFlatFileReceive.btp

- <sample>\src\HarborLane.Integration.Schemas\CanonicalOrder.xsd

- <sample>\src\HarborLane.Integration.Schemas\InventoryFlatFile.xsd

- <sample>\src\HarborLane.Integration.Schemas\InventoryUpdate.xsd

- <sample>\src\HarborLane.Integration.Schemas\OrderError.xsd

- <sample>\src\HarborLane.Integration.Schemas\PurchaseOrder.xsd

- <sample>\src\HarborLane.Integration.Schemas\ShipmentAck.xsd

- <sample>\src\HarborLane.Integration.Schemas\ShipmentNotice.xsd

### Item 66

- **Id:** custom-source

- **Description:** Application-specific custom source code

- **Status:** passed

#### Matches

- <sample>\src\HarborLane.Integration.Helpers\DeliveryCalendar.cs

- <sample>\src\HarborLane.Integration.Helpers\ErrorMessageBuilder.cs

- <sample>\src\HarborLane.Integration.Helpers\PricingRules.cs

- <sample>\src\HarborLane.Integration.Helpers\ShipmentRules.cs

- <sample>\src\HarborLane.Integration.Maps\Properties\AssemblyInfo.cs

- <sample>\src\HarborLane.Integration.Orchestrations\Properties\AssemblyInfo.cs

- <sample>\src\HarborLane.Integration.Pipelines\Properties\AssemblyInfo.cs

- <sample>\src\HarborLane.Integration.Schemas\Properties\AssemblyInfo.cs

### Item 67

- **Id:** target-git

- **Description:** Target Git repository

- **Status:** passed

#### Matches

- <run>/reports\worktrees\HarborLane.Integration

### Item 68

- **Id:** write-allowlist

- **Description:** Explicit generated-file write allowlist

- **Status:** passed

#### Matches

- logicapp/**

- Functions/**

- infra/**

- tests/**

### Item 69

- **Id:** ai-authentication

- **Description:** codex CLI authentication

- **Status:** passed

#### Matches

- Logged in using ChatGPT

### Item 70

- **Id:** reviewer-independence

- **Description:** Independent reviewer uses a different model from the primary agent

- **Status:** passed

#### Matches

- distinct-provider

### Item 71

- **Id:** license-term

- **Description:** License term and certificate

- **Status:** passed

#### Matches

- migration-starter, term ends 2029-10-07

### Item 72

- **Id:** license-migration-units

- **Description:** Migration units for this solution

- **Status:** passed

#### Matches

- 8154 of 10000 migration units remain as of the last license refresh; this solution has up to 14 billable source files

### Item 73

- **Id:** license-application

- **Description:** Registered application for this solution

- **Status:** passed

#### Matches

- harborlane.integration is already registered from this installation; 10 of 50 registered applications used

- **Report File:** <run>/reports\HarborLane.Integration\migration-precheck-conversion-2026-10-26T23-47-36-861Z.json
