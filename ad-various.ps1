# get distribution group message delivery restrictions:
# https://docs.microsoft.com/en=us/exchange/recipients/user=mailboxes/message=delivery=restrictions?view=exchserver=2019
# export to a text file
Get-DistributionGroup AllMembers | Format-Table AcceptMessagesOnlyFrom,AcceptMessagesOnlyFromDLMembers,RejectMessagesFrom,RejectMessagesFromDLMembers,RequireSenderAuthenticationEnabled -AutoSize | Out-File -Width 1999 out.txt

Get-DistributionGroup AllPeople | Format-list acceptmessagesonlyfrom
# import the text file in Excel, paste special = tick Transpose (horizontal list will be pasted as vertical list, one item per row)

# to add or remove permissions to the distribution group for an email account:
Set-DistributionGroup -Identity AllNFCMembers -AcceptMessagesOnlyFrom @{add="user"}
Set-DistributionGroup -Identity AllNFCMembers -AcceptMessagesOnlyFrom @{add="user","other.user"}
Set-DistributionGroup -Identity AllNFCMembers -AcceptMessagesOnlyFrom @{remove="user"}

# get default users and computers containers - for new users and computers joined to the domain
# use redircmp and redirusr to redirect
# https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/redirect-users-computers-containers
Import-Module ActiveDirectory
$x = Get-ADObject -Filter {isCriticalSystemObject -eq $true} | Where {($_.objectclass -eq 'container' -or $_.objectclass -eq 'organizationalUnit') -and (-not ($_.DistinguishedName -like '*ForeignSecurityPrincipals,DC*')) -and (-not ($_.DistinguishedName -like '*CN=System,DC*')) -and (-not ($_.DistinguishedName -like '*Domain Controllers,DC*')) -and (-not ($_.DistinguishedName -like '*ForeignSecurityPrincipals*'))}; $x | ft *dname
