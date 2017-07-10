function Invoke-FileUpload {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param([string]$Uri,
        [string]$File)

    if (!(Get-Module Azure.Storage -ListAvailable)) {
        $Base = (Get-Module -Name SQLDiagAPI).ModuleBase
        Add-Type -Path $Base\internal\Microsoft.WindowsAzure.Storage.dll
    }
    else {
        $Base = (Get-Module -Name Azure.Storage -ListAvailable).ModuleBase
        $StorageDll = (Get-ChildItem -Path $Base -Recurse Microsoft.WindowsAzure.Storage.dll).FullName
        Add-Type $StorageDll
    }
    $blobContent = System.IO.File.ReadAllBytes($file)
    $blob = New-Object Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob ($uri)
    try {
        Write-verbose -Message "Uploading the file $File for analysis"
        if ($PSCmdlet.ShouldProcess($File.FullPath, "Uploading the File for analysis")) { 
            $Blob.UploadFromByteArrayAsync($blobContent, 0, $File.Size)
        }
    }
    catch {
        Write-Warning -Message "Failed to upload File $($File.FilePath)"
    }
}