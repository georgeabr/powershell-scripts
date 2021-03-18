C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\phase-2-initial-message.ps1

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\rename-pc-teamviewer.ps1

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\eset-av-agent.ps1

start /wait C:\kits\filemaker\base-install\Files\setup.exe /s /passive
start /wait msiexec.exe /p C:\kits\filemaker\update-15.0.5\FMP.15.0.5.500.Updater.msp /passive

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -NoLogo -File C:\Users\user\Documents\windows-cust\scripts\phase-2-final-message.ps1
