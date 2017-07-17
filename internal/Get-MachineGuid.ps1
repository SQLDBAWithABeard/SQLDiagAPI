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
            if(Test-Path 'HKLM:\\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Sever\Extensions\ECS'){
            (Get-ItemProperty 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Sever\Extensions\ECS' -Name SsmsExtension).SsmsExtension
                Write-Verbose -Message "Got the SSMS machine guid from the registry at HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Sever\Extensions\ECS"    
    }
            elseif (Test-Path HKLM:\SOFTWARE\Microsoft\Microsoft SQL Sever\Extensions\ECS\SsmsExtension){
                (Get-ItemProperty 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Sever\Extensions\ECS\SsmsExtension' -Name SsmsExtension).SsmsExtension
                Write-Verbose -Message "Got the SSMS machine guid from the registry at HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Sever\Extensions\ECS\SsmsExtension"
            }
            else{
                (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\ -Name MachineGuid).MachineGUID
                Write-Verbose -Message "Got the general machine guid from the registry at HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
            }
            Write-Verbose -Message "Got the machine guid from the registry"
        }
    }
    catch {
        Write-Warning "Failed to get Machine GUID from HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\"
    }
}