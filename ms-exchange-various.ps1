# MS Exchange = get a list of emails sent to someone, filter for keyword in subject:
Get-MessageTrackingLog -Recipients xxx@yahoo.co.uk,xxx1@yahoo.com -Start "2/1/2021 8:00AM" -End "2/25/2021 8:00AM" |Select EventId,Timestamp,Sender,Recipients,MessageSubject | ft -Wrap -Autosize | out-file .\emails.txt
Get-MessageTrackingLog -Recipients xxx@test.org.uk -Start "11/18/2020 8:00AM" -End "11/20/2020 8:00AM" -MessageSubject "zoom"|Select EventId,Timestamp,Sender,Recipients,MessageSubject | ft | Out-String -Width 300 | out-file .\emails.txt

#filter mail contacts
get-mailcontact | where-object {$_.name -like  "*Wagg*"} | format-list -Property Alias,DisplayName,PrimarySmtpAddress

# Export members, titles and email addresses for a distribution list - Exchange powershell
Get-DistributionGroup AllNationalCouncillors | Get-DistributionGroupMember | select DisplayName,Title,PrimarySMTPAddress | Export-CSV dl-AllNationalCouncillors.csv

# filter mailbox export requests that are failed
Get-MailboxExportRequest | where-object { $_.status -eq "Failed" } | Format-Table -Autosize

# - get mailbox size 
Get-MailboxStatistics -Identity user | format-table -Property Totalitemsize

###########################################################################################
# Exchange Powershell - add FullAccess + Send As for a user, and see permissions
Add-MailboxPermission -Identity "A Forms" -User emma -AccessRights FullAccess -InheritanceType All
Get-Mailbox "A Forms" | Add-ADPermission -User emma -AccessRights ExtendedRight -ExtendedRights "Send As" -InheritanceType All
Get-Mailbox "A Forms" | Get-MailboxPermission -User emma.rowe | ft -AutoSize

Get-ADPermission -Identity "National President" | where {($_.ExtendedRights -like "*Send-As*") -and ($_.User -like "*emma*")} |Format-Table -AutoSize Identity,User
- for Exchange online:
Add-RecipientPermission "A-Forms" -AccessRights SendAs -Trustee "Emma"

# When an user wants access to a mailbox, give them full access + send as.
###########################################################################################
# Add an user to another user's distribution lists
# - in the below, add Emma to National President's distribution lists
# - it also removes blank spaces when exporting the lists to a text file

$UserDistinguishedName = Get-Mailbox national.president@test.org.uk | Select -ExpandProperty DistinguishedName; 
Get-DistributionGroup -ResultSize Unlimited -Filter "Members -eq '$UserDistinguishedName'" | Select -ExpandProperty DisplayName | Set-Content distribution-lists.txt

foreach($group in (get-content "distribution-lists.txt")){Add-DistributionGroupMember $group –Member "emma@test.org.uk" -Verbose}

$UserDistinguishedName = Get-Mailbox emma@test.org.uk | Select -ExpandProperty DistinguishedName; 
Get-DistributionGroup -ResultSize Unlimited -Filter "Members -eq '$UserDistinguishedName'" | Select -ExpandProperty DisplayName
###########################################################################################

#
