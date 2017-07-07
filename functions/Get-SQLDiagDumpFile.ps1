function Get-SQLDiagDumpFile {
    param(
        [string]$file
        )
    Begin{
        if(!$file)
        {
            $file = Invoke-FilePicker
        }
    }
    Process{}
    End{}
}