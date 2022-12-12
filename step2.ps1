Try {wsl --install}
Catch {
    # Download 
    Write-Host "Wls is not install on the windows"
    Write-Host "Start step1"
    ./step1.ps1
}
Finally
{
    $reboot = Read-Host -Prompt 'Restart your system now ? (y or n): '
    if ($reboot -eq 'y' -or $reboot -eq   'yes' ) {
        Restart-Computer -ComputerName SHELL-PC01, SHELL-PC02, localhost
    }
}
