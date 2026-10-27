<#
.SYNOPSIS
    Deletes everything the sample created in Azure by deleting its resource group.

.DESCRIPTION
    The Key Vault is soft-deleted with the group and kept for 90 days; it costs nothing in that
    state. The generated vault enables purge protection, so it cannot be purged early; deploy.ps1
    recovers it when you deploy to the same resource group again within those 90 days.
    -PurgeKeyVault purges only vaults created without purge protection.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $SubscriptionId,
    [string] $ResourceGroupName = 'rg-li-sample-harborlane-dev-cac',
    [switch] $PurgeKeyVault
)

$ErrorActionPreference = 'Stop'
az account set --subscription $SubscriptionId
if ($LASTEXITCODE -ne 0) { throw 'Could not select the subscription.' }

$exists = az group exists --name $ResourceGroupName
if ($exists -ne 'true') {
    Write-Host "$ResourceGroupName does not exist; nothing to delete."
    return
}
$vaults = @(az keyvault list --resource-group $ResourceGroupName --query '[].name' -o json | ConvertFrom-Json)

Write-Host "Deleting $ResourceGroupName and everything in it..."
az group delete --name $ResourceGroupName --yes
if ($LASTEXITCODE -ne 0) { throw "Deleting $ResourceGroupName failed." }

if ($PurgeKeyVault) {
    foreach ($vault in $vaults) {
        Write-Host "Purging soft-deleted Key Vault $vault..."
        az keyvault purge --name $vault
    }
}
Write-Host 'Done.'
