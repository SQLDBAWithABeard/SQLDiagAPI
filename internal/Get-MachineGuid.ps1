function Get-MachineGUID {
    try {
    (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\ -Name MachineGuid).MachineGUID
}
catch{
        Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
}
}