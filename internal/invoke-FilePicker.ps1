function Invoke-FilePicker {
    ##############################
    #.SYNOPSIS
    # Internal command to open a file browser and select a mdmp file and return Path and Size in MB
    ##############################
    [cmdletbinding(SupportsShouldProcess = $true)]
    param()
    try {
        Write-Verbose -message "Loading Forms assembly"
        if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Loading the forms assembly ")) { 
            Add-Type -AssemblyName System.Windows.Forms
        }
    }
    catch {
        Write-Warning -Message "Failed to load forms assembly"
        break
    }

    try {
        Write-Verbose -message "Creating the File picker object"
        if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Creating the File picker object")) { 
            $Picker = New-Object System.Windows.Forms.OpenFileDialog -Property @{
                Multiselect = $false # Multiple files can be chosen
                Filter      = 'SQL Server Dump File (*.mdmp)|*.mdmp'
            }
        }
    }
    catch {
        Write-Warning -Message "Failed to create the File Picker Object"
        break
    }

    try {
        Write-Verbose -message "Show the File picker dialogue"
        if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "show the file picker dialogue")) { 
            ShowDialog 
        }
    }
    catch {
        Write-Warning -Message "Failed to open File picker dialogue"
        break
    }
    
    try {
        Write-Verbose -message "Getting information about the file $Picker.FullName"
        if ($PSCmdlet.ShouldProcess($Picker.FullName, "Getting information about the file ")) { 
            $File = Get-Item $Picker.FileName
        }
    }
    catch {
        Write-Warning -Message "Failed to get  information about $($Picker.FullName)"
        break
    }
    try {
        Write-Verbose -message "Returning the file object"
        if ($PSCmdlet.ShouldProcess($File.FullName, "Returning the file object ")) { 
            [PSCustomObject] @{
                Fullname = $File.Fullname
                Length   = $File.Length
            }
        }
    }
    catch {
        Write-Warning -Message "Failed to return the file object"
        break
    }
}




