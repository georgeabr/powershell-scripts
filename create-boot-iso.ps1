# Create a bootable USB ISO from a Windows install folder
# Path to the Extracted or Mounted Windows ISO 
$ISOMediaFolder = 'H:\Windows-deploy\Windows-10-extracted'

# Path to new re-mastered ISO
$ISOFile = 'h:\win10.iso'

# Need to specify the root directory of the oscdimg.exe utility which you need to download
$PathToOscdimg = 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg'

# Instead of pointing to normal efisys.bin, use the *_noprompt instead
# $BootData='2#p0,e,b"{0}"#pEF,e,b"{1}"' -f "$ISOMediaFolder\boot\etfsboot.com","$ISOMediaFolder\efi\Microsoft\boot\efisys_noprompt.bin"
$BootData='2#p0,e,b"{0}"#pEF,e,b"{1}"' -f "$ISOMediaFolder\boot\etfsboot.com","$ISOMediaFolder\efi\Microsoft\boot\efisys.bin"

# re-master Windows ISO
Start-Process -FilePath "$PathToOscdimg\oscdimg.exe" -ArgumentList @("-bootdata:$BootData",'-u2','-udfver102',"$ISOMediaFolder","$ISOFile") -PassThru -Wait -NoNewWindow
