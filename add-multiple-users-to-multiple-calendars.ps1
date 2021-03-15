add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010

$global:debug_print = '2'
# 0 - no verbosity, modifies
# 1 - full verbose, does not modify
# 2 - show WhatIf only, does not modify
# WRITE-output($debug_print)

$source_users = 'nat', 'national.president'
$target_calendars = 'Brian','Anne','Stephen'
# people in the list source_users will be granted access the calendars of people in the list target_calendars
# What if: Adding mailbox folder permission on "Anne:\calendar" for user "National President", access rights "'Reviewer'".

$access_rights = 'Reviewer'
<#
    Author: CreateItems, DeleteOwnedItems, EditOwnedItems, FolderVisible, ReadItems
    Contributor: CreateItems, FolderVisible
    Editor: CreateItems, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderVisible, ReadItems
    None: FolderVisible
    NonEditingAuthor: CreateItems, FolderVisible, ReadItems
    Owner: CreateItems, CreateSubfolders, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderContact, FolderOwner, FolderVisible, ReadItems
    PublishingEditor: CreateItems, CreateSubfolders, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderVisible, ReadItems
    PublishingAuthor: CreateItems, CreateSubfolders, DeleteOwnedItems, EditOwnedItems, FolderVisible, ReadItems
    Reviewer: FolderVisible, ReadItems
#>

function AddCalendarAccessForUsers
{
 param([string]$addforwhatusers)
 # WRITE-output($debug_print)
 write-output "======"
if ($debug_print -match '1') { write-output "1.1. BEGIN OF COMPLETE WHAT CALENDAR LOOP" }
 ForEach ($user2 in $target_calendars) {
    if ($debug_print -match '1') { write-output "1.1.1. BEGIN OF INDIVIDUAL WHAT CALENDAR LOOP" }
    # AddCalendarAccessForUsersHelper($addforwhatusers, $user2)
    #write-output "Who to add" $addforusers
    
   if ($debug_print -match '1') {
   echo "Who to add", $addforwhatusers
   write-output "To what calendar"
   write-output $user2 }
   
   $user_calendar = $user2 + ":\calendar"
   
   # write-output $user3
   # Set-MailboxFolderPermission $addforwhatusers -User $user_calendar -AccessRights $access_rights -WhatIf
   # Set-MailboxFolderPermission $addforwhatusers -User $user_calendar -AccessRights $access_rights
   
if ($debug_print -match '1' -Or $debug_print -match '2') {
   Add-MailboxFolderPermission $user_calendar -User $addforwhatusers -AccessRights $access_rights -WhatIf
} else {
   #enable the below if you want to add permissions
   Add-MailboxFolderPermission $user_calendar -User $addforwhatusers -AccessRights $access_rights
}
   
   # try catch at some point
   # Get-MailboxFolderPermission $user_calendar
   if ($debug_print -match '1') { write-output "1.1.1. END OF INDIVIDUAL WHAT CALENDAR LOOP" }

}
 if ($debug_print -match '1') { write-output "1.1. END OF COMPLETE WHAT CALENDAR LOOP" }
}

clear-host 
ForEach ($user1 in $source_users) {
    
    if ($debug_print -match '1') { write-output "1. BEGIN OF WHO TO ADD LOOP" }
    AddCalendarAccessForUsers($user1)
    if ($debug_print -match '1') { write-output "1. END OF WHO TO ADD LOOP" }
   

}
