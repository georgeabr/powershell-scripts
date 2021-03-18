$Cred = $(New-Object -Type 'PSCredential' -Arg 'CORP\djoin',$(ConvertTo-SecureString '9qJ+68sv9ht48PND' -AsPlain -Force))

# Remove-PSDrive -Name "X"
#New-PSDrive -Name "X" -Root "\\192.168.113.11\Windows-deploy" -Persist -PSProvider FileSystem -Credential $Cred

# Get-Item "X:\kits"
# start-process -Wait msiexec -ArgumentList "/i `"X:\kits\eset-agent-av\agent_x64.msi`" /qn "
# start-process -Wait msiexec -ArgumentList "/i `"X:\kits\eset-agent-av\ees_nt64.msi`" /qn "

# it works, but no more RDP
start-process -Wait msiexec -ArgumentList "/i `"c:\kits\eset-agent-av\ees_nt64.msi`" /passive ACTIVATION_DATA=key:AWJE-X6RV-7TUA-3NF8-SJVE ADMINCFG=c:\kits\eset-agent-av\eset-settings.xml "
start-process -Wait msiexec -ArgumentList "/i `"c:\kits\eset-agent-av\agent_x64.msi`" /passive "


#Start-Process -FilePath "C:\Program Files\ESET\ESET Security\ermm.exe" -ArgumentList "start activation --key `"AWJE-X6RV-7TUA-3NF8-SJVE`" "
# ACTIVATION_DATA=key:AAAA-BBBB-CCCC-DDDD-EEEE

# Start-Process -FilePath "C:\Program Files\ESET\ESET Security\ecmd.exe" -ArgumentList "/setcfg `"C:\Users\nfrn\Documents\eset-settings.xml`" "
# C:\Users\nfrn\Documents\eset-settings.xml
#X:\kits\eset-agent-av\eset-settings.xml