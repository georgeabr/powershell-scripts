# rename computer to its serial number, join the computer to the domain and reboot, all in one go

$Cred = $(New-Object -Type 'PSCredential' -Arg 'CORP\djoin',$(ConvertTo-SecureString 'password' -AsPlain -Force))
$OU = 'OU=PCS,OU=Computers,OU=Company,DC=corp,DC=domain,DC=com'

$LocalAdminUser = 'local-admin'
$LocalAdminPassword = 'password' | ConvertTo-SecureString -AsPlainText -Force

LocalAdminCredentials = New-Object System.Management.Automation.PSCredential($LocalAdminUser,$LocalAdminPassword)
# $DomainAdminCredentials = New-Object System.Management.Automation.PSCredential($DomainAdminUser,$DomainAdminPassword)

$PCSerialNumber = (Get-WmiObject -Class Win32_Bios).SerialNumber
Write-Output $PCSerialNumber
Rename-Computer -NewName $PCSerialNumber #-WhatIf
sleep 5
# Remove-Computer -UnjoinDomainCredential $Cred -Verbose
Add-Computer -DomainName 'corp.domain.com' -Force -Options JoinWithNewName,AccountCreate -PassThru -Restart -Credential $Cred -LocalCredential $LocalAdminCredentials -OU $OU #-WhatIf
