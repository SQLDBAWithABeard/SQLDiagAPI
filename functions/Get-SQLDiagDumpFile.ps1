<#
.SYNOPSIS
Gets a SQL Server Dump File for uploading to the API

.DESCRIPTION
Gets a SQL Server Dump File for uploading to the API.
Opens a graphical file picker if no file specified

.PARAMETER file
Path to file

.EXAMPLE
Get-SQLDiagDumpFile | Invoke-SQLDiagDumpAnalysis -Region 'West US' -Email a@a.com

opens a file picker to choose a file which is then uploaded to teh West US Azure region
and analysed with the SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    07/07/2017
#>
function Get-SQLDiagDumpFile {
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [parameter(ValueFromPipelineByPropertyName, 
            Mandatory = $false)]
        [ValidateScript( {Test-Path -Path $_})]
        [string]$file
    )
    Begin {
    }
    Process {
        if (!$file) {
            try {
                Write-Verbose -Message "No file specified so invoking File Picker"
                if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "invoking File Picker")) { 
                    $DumpFile = Invoke-FilePicker
                }
            }
            catch {
                Write-Warning -Message "Failed to Get File information"
            }
        }
        else {
            try {
                Write-Verbose -Message "Getting information about $File"
                if ($PSCmdlet.ShouldProcess($File, "Getting file information")) { 
                    $DumpFile = Get-Item $File
                }
            }
            catch {
                Write-Warning -Message "Failed to Get File information about $File"
            }
        }
    }
    End {
        Write-Verbose -Message "Returning file object"
        [pscustomobject]@{
            FullName = $DumpFile.FullName
            Length   = $DumpFile.Length
        }
    }
}