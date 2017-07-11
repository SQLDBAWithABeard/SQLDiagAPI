function Get-MachineGUID {
    ##############################
    #.SYNOPSIS
    # Internal function to get hte mcahine guid for identifying the machine to the API
    #
    ##############################
    [cmdletbinding(SupportsShouldProcess = $true)]
    param()
    try {
        Write-Verbose -Message "Reading the registry for the machine guid"
        if ($PSCmdlet.ShouldProcess($Env:COMPUTERNAME, "Reading the registry for the machine guid")) { 
            (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\ -Name MachineGuid).MachineGUID
            Write-Verbose -Message "Got the machine guid from the registry"
        }
    }
    catch {
        Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
    }
}