
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
            Size     = $DumpFile.Length /1MB
        }
    }
    End{}
}