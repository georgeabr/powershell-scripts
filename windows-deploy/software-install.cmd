C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\phase-2-initial-message.ps1

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\rename-pc-teamviewer.ps1

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\eset-av-agent.ps1

rem install the software
start /wait C:\kits\software\base-install\Files\setup.exe /s /passive
rem install the patch, to update the software to a higher version
start /wait msiexec.exe /p C:\kits\software\update-15.0.5\FMP.15.0.5.500.Updater.msp /passive

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\phase-2-final-message.ps1
