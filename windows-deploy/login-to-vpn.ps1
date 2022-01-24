# check if VPN is started (IP address is pingable), before exiting 

Add-Type -AssemblyName PresentationFramework

function test_connection_ipv4($ipv4) { if (test-connection $ipv4 -Count 1 -ErrorAction SilentlyContinue ) {10} else {20} }

$IP = "10.10.10.10"
$testIP = test_connection_ipv4($IP)

while ($testIP -eq 20)
{
    Write-Output "not connected"
    [System.Windows.MessageBox]::Show('Please log in with your credentials to the VPN and press OK.
This is needed for adding the computer to the AD domain.','Please log in to the Barracuda VPN first','OK','Warning')
    $testIP = test_connection_ipv4($IP)
}

Write-Output "connected"

[System.Windows.MessageBox]::Show('Computer is now connected to VPN.

The computer will:
- activate its Windows license
- be renamed to its serial number
- join the AD domain.

Afterwards it will automatically reboot.
You can then proceed to "Software install."','Starting initial setup','OK','Information')
