try {
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
}
catch {
    Write-Host "Error Privileges"
    Write-Host "You must be an administrator to run this script"
    $admin = Read-Host -Prompt 'You want to run an administrator shell? (y or n): '
    if ($admin -eq 'y' -or $admin -eq   'yes' ) {
        Start-Process powershell -Verb runAs
    }
}

$exitNetwork = 0
$exitNet = 0
while ($exitNetwork -eq 0) {
    $exitNet = 0
    try {
        $url = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
        $outpath = "wsl_update_x64.msi"
        Invoke-WebRequest -Uri $url -OutFile $outpath
        ./wsl_update_x64.msi
        $exitNetwork = 1
    }
    catch {
        Write-Host "Error Network"
        Write-Host "The pc is not connected to the internet"
        while ($exitNet -eq 0) {
            $Net = Read-Host -Prompt 'Did you connect your pc to the internet? (y or n): '
            if ($Net -eq 'y' -or $Net -eq   'yes' ) {
                $exitNet = 1
            }
        }
    }   
}


$reboot = Read-Host -Prompt 'Restart the pc now ? (y or n): '
if ($reboot -eq 'y' -or $reboot -eq 'yes' ) {
    #Restart-Computer -ComputerName SHELL-PC01,  SHELL-PC02, localhost
}
