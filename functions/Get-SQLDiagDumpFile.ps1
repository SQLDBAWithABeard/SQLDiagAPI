<#
.SYNOPSIS
Returns the File Path and Size in Mb of the dump file

.DESCRIPTION
Returns the File Path and Size in Mb of the dump file
for uploading to the SQL Server Diagnostics Recommendations API

.PARAMETER file
The Path to the dump file - If not specfied a file picker 
dialogue will be shown

.EXAMPLE
Get-SQLDiagDumpFile

Opens a file picker diaglogue and returns the File Path and Size in Mb 
of the chosen file

.EXAMPLE
Get-SQLDiagDumpFile -File C:\SQLServer\Log\SQLDump011.mdmp

Returns the File Path and Size in Mb of the specified file

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
            FilePath = $DumpFile.FullName
            Size     = $DumpFile.Length
        }
    }
    End{}
}