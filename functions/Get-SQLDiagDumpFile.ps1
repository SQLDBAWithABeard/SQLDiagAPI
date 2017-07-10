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
    param(
        [parameter(ValueFromPipelineByPropertyName, 
            Mandatory = $false)]
        [ValidateScript({Test-Path -Path $_})]
        [string]$file
        )
    Begin{
    }
    Process{
        if (!$file) {
            $DumpFile = Invoke-FilePicker
        }
        else {
            $DumpFile = Get-Item $File
        }

        [pscustomobject]@{
            FullName = $DumpFile.FullName
            Length     = $DumpFile.Length
        }
    }
    End{}
}