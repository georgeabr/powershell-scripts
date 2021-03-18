# enable Bitlocker on drive C and save key on a network share

Import-Module bitlocker
$DateInt = ((Get-Date).ToString('yyyyMMddHHmm'))
Enable-BitLocker -MountPoint C: -UsedSpaceOnly -EncryptionMethod Aes256 -TpmProtector -SkipHardwareTest #-WhatIf

$Cred = $(New-Object -Type 'PSCredential' -Arg 'CORP\djoin',$(ConvertTo-SecureString 'password' -AsPlain -Force))
New-PSDrive -Name "T" -Root "\\192.168.113.10\Teams" -Persist -PSProvider FileSystem -Credential $Cred

$PCSerialNumber = (Get-WmiObject -Class Win32_Bios).SerialNumber
$BitlockerKeyPath = -join("T:\IT\bitlocker-recovery-keys\", $PCSerialNumber, "-", $DateInt)
New-Item -ItemType Directory $BitlockerKeyPath

Add-BitLockerKeyProtector -MountPoint C: -RecoveryKeyPath $BitlockerKeyPath -RecoveryKeyProtector

Remove-PSDrive -Name "T"
