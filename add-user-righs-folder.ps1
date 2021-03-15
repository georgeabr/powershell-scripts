# Powershell script = add user rights to folder = run as admin
# https://docs.microsoft.com/en=us/dotnet/api/system.security.accesscontrol.filesystemrights

$objFolder = '\\192.168.113.10\Folder'
$objUserName = 'CORP\user'
$objRights = 'Read,Traverse,Modify,Delete,CreateDirectories,Write'
# $objFolder = 'd:\temp'
$objFileName = 'acl.txt'
$Rights = [System.Security.AccessControl.FileSystemRights]$objRights

$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]"ObjectInherit,ContainerInherit"
$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None 

$objType = [System.Security.AccessControl.AccessControlType]::Allow 

$objUser = New-Object System.Security.Principal.NTAccount($objUserName) 

$objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $Rights, $InheritanceFlag, $PropagationFlag, $objType) 

$objACL = Get-ACL $objFolder
$objACL.AddAccessRule($objACE) 

Write-Output "`n=============================================================="
Write-Output "Username:", $objUserName, "`nFolder:", $objFolder, "`nRights:", $objRights, ""

Set-ACL -Whatif $objFolder $objACL
# Set-ACL $objFolder $objACL
Write-Host "`nAmended user rights for folder are written in file -" $objFileName
Write-Output "==============================================================`n"

#    $reportpath ="C:\data\ACL.csv" #define path to export permissions report
# script scans for directories under shared folder and gets acl(permissions) for all of them
dir $objFolder  | where { $_.PsIsContainer } | % { $path1 = $_.fullname; Get-Acl $_.Fullname | % { $_.access | Add-Member -MemberType NoteProperty '.\Application Data' -Value 
$path1 -passthru }} |  where-object { $_.IdentityReference -eq $objUserName } |Format-Table -Property '.\Application Data', IdentityReference,FileSystemRights -Autosize | 
Out-File $objFileName -Width 999
