# Get a users Dispaly Name from their VB/logon name. Used for mirroring access.
# usage: .\get-AD-name.ps1

$vblist = @()
$errorVBList = @()

# Open file and for loop through each VB. Add to list
foreach($vb in Get-Content .\vb-id.txt) {
    # Add each vb to a list then sort unique
    #Write-Host $vb #DEBUG
    #$vblist.Add($vb)
    $vblist += $vb
    }

# Sort the list & get unique values
$vblist = $vblist | Sort | Unique

# For loop through each VB in sorted list.
foreach($vb in $vblist) {
    try{
    # Get the Display Name from AD via the VB in the file
    $name = (Get-ADuser $vb -Properties DisplayName).DisplayName
    }
    catch{
    #Write-Host "An error occurred:"
    #Write-Host $_
    $errorVBList += $vb # Add to list of all VB w/ errors
    Continue # Skip the current vb - do not display
    }

    # Write the VB and Display Name to console with comma delimiter
    Write-Host $vb "," $name
}
Write-Host "Total Count =" $vblist.Count
Write-Host " "

Write-Host "Error for these VB's:"
foreach($vb in $errorVBList) {
    Write-Host $vb
}
Write-Host "Total Error Count =" $errorVBList.Count
Write-Host " "
