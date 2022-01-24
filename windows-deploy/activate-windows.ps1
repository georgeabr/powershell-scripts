# disable hibernation file, which is the size of the PC's RAM - saves disk space
powercfg /h off

# activate Windows based on product key embedded in the PC BIOS.
$ProductKey = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductKey
Invoke-Expression "cscript /b C:\Windows\System32\slmgr.vbs -ipk $ProductKey" 
Start-Sleep 5
Invoke-Expression "cscript /b C:\Windows\System32\slmgr.vbs -ato"
