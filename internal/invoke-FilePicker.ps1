function Invoke-FilePicker {
    ##############################
    #.SYNOPSIS
    # Internal command to open a file browser and select a mdmp file and return Path and Size in MB
    ##############################
    Add-Type -AssemblyName System.Windows.Forms
    $Picker = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Multiselect = $false # Multiple files can be chosen
        Filter      = 'SQL Server Dump File (*.mdmp)|*.mdmp'
    }

    ShowDialog 
    
    $File = Get-Item $Picker.FileName
    [PSCustomObject] @{
        Fullname = $File.Fullname
        Length = $File.Length
    }

}




