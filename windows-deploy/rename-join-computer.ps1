$Cred = $(New-Object -Type 'PSCredential' -Arg 'CORP\djoin',$(ConvertTo-SecureString '9qJ+68sv9ht48PND' -AsPlain -Force))
$OU = 'OU=PCS,OU=Computers,OU=Company,DC=corp,DC=thefedonline,DC=com'

$LocalAdminUser = 'nfrn'
$LocalAdminPassword = 'lithium' | ConvertTo-SecureString -AsPlainText -Force

#fuckery
$LocalAdminCredentials = New-Object System.Management.Automation.PSCredential($LocalAdminUser,$LocalAdminPassword)
# $DomainAdminCredentials = New-Object System.Management.Automation.PSCredential($DomainAdminUser,$DomainAdminPassword)

$PCSerialNumber = (Get-WmiObject -Class Win32_Bios).SerialNumber
Write-Output $PCSerialNumber
Rename-Computer -NewName $PCSerialNumber #-WhatIf
sleep 5
# Remove-Computer -UnjoinDomainCredential $Cred -Verbose
Add-Computer -DomainName 'corp.thefedonline.com' -Force -Options JoinWithNewName,AccountCreate -PassThru -Restart -Credential $Cred -LocalCredential $LocalAdminCredentials -OU $OU #-WhatIf