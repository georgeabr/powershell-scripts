$Keys = Get-Item -Path HKLM:\Software\RegisteredApplications | Select-Object -ExpandProperty property
$Product = $Keys | Where-Object {$_ -Match "Excel.Application."}
$OfficeVersion = ($Product.Replace("Excel.Application.","")+".0")
Write-Host $OfficeVersion
