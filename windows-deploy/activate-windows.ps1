# activate Windows based on product key embedded in the PC BIOS.
powercfg /h off

$ProductKey = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductKey
Invoke-Expression "cscript /b C:\Windows\System32\slmgr.vbs -ipk $ProductKey" 
Start-Sleep 5
Invoke-Expression "cscript /b C:\Windows\System32\slmgr.vbs -ato"
