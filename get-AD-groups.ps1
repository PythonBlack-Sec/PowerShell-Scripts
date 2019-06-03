# Get a users group membership from a vb/username. Used for mirroring access.
# usage: ./get-AD-groups vb#

# Get persons vb from CLI
param([string]$vb)

# Get name from vb
$name = (Get-ADuser $vb -Properties DisplayName).DisplayName

# Dispaly name and AD groups from vb
Write-Host "Showing groups for:" $name "-" $vb

# Query AD to get groups of the specified user
((Get-ADuser $vb -Properties memberof).memberof -split "," | Select-String -Pattern 'CN=' -CaseSensitive) -split("=") | Select-String -Pattern 'CN' -CaseSensitive -NotMatch | Sort-Object
