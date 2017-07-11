##############################
#.SYNOPSIS
# Internal Function to upload file 
#
#.PARAMETER Uri
# URL from Get-UploadURL
#
#.PARAMETER File
# File Object
##############################
function Start-FileUpload {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param([string]$Uri,
        [object]$File)
    ## Needs the Azure.Storage dll file from the Azure.Storage Module
    ## Dont know if I can put it in here or it needs to come from the Azure module
    if (!(Get-Module Azure.Storage -ListAvailable)) {
        
        Write-Verbose -Message "Getting SQLDiagAPI Module Base path"
        try {
            if ($PSCmdlet.ShouldProcess("SQLDiagAPI module", "Getting SQLDiagAPI module base path")) { 
                $Base = (Get-Module -Name SQLDiagAPI).ModuleBase
            }
        }
        catch {
            Write-Warning -Message "Failed to get  SQLDiagAPI module base path - quitting"
            break
        }
        Write-Verbose -Message "adding Azure Storage dll from SQLDiagAPI module"
        try {
            if ($PSCmdlet.ShouldProcess("Azure.Storage Dll", "Loading Assembly")) { 
                Add-Type -Path $Base\internal\Microsoft.WindowsAzure.Storage.dll
            }
        }
        catch {
            Write-Warning -Message "Failed to load assembly from SQLDiagAPI module - quitting"
            break
        }
    }
    else {
        Write-Verbose -Message "Getting Azure.Storage Module Base path"
        try {
            if ($PSCmdlet.ShouldProcess("Azure.Storage module", "Getting Azure.Storage module base path")) { 
                $Base = (Get-Module -Name Azure.Storage -ListAvailable).ModuleBase
            }
        }
        catch {
            Write-Warning -Message "Failed to get  Azure.Storage module base path - quitting"
            break
        }
        Write-Verbose -Message "adding Azure Storage dll from Azure.Storage module"
        try {
            if ($PSCmdlet.ShouldProcess("Azure.Storage Dll", "Loading Assemblyfrom Azure.Storage Module")) { 
                $StorageDll = (Get-ChildItem -Path $Base -Recurse Microsoft.WindowsAzure.Storage.dll).FullName
                Add-Type $StorageDll
            }
        }
        catch {
            Write-Warning -Message "Failed to load assembly from Azure.Storage module - quitting"
            break
        }
    }
    <#
    if we could use async upload then use this but I cannot get it to work
    $blobContent = System.IO.File.ReadAllBytes($file.FullName)
    $blob = New-Object Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob ($uri)
    $Blob.UploadFromByteArrayAsync($blobContent, 0, $File.Size)
    #>
    $blob = New-Object Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob ($uri)
    try {
        Write-verbose -Message "Uploading the file $File for analysis"
        if ($PSCmdlet.ShouldProcess($File.FullName, "Uploading the File for analysis")) { 
            $blob.UploadFromFile($file.FullName, $null, $null, $null)
        }
    }
    catch {
        Write-Warning -Message "Failed to upload File $($File.FullName)"
        break
    }
}