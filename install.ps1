[CmdletBinding()]
param (
)

## All thanks to the girl with the hair @cl

Remove-Module -Name SQLDiagAPI -ErrorAction SilentlyContinue

$path = "$HOME\Documents\WindowsPowerShell\Modules\SQLDiagAPI"
$temp = ([System.IO.Path]::GetTempPath()).TrimEnd("\")
$zipfile = "$temp\SQLDiagAPI.zip"
$url = 'https://github.com/SQLDBAWithABeard/SQLDiagAPI/archive/master.zip'

if (!(Test-Path -Path $path)) {
    try {
        Write-Output "Creating directory: $path"
        New-Item -Path $path -ItemType Directory | Out-Null
    }
    catch {
        throw "Can't create $Path. You may need to Run as Administrator"
    }
}
else {
    try {
        Write-Output "Deleting previously installed module"
        Remove-Item -Path "$path\*" -Force -Recurse
    }
    catch {
        throw "Can't delete $Path. You may need to Run as Administrator"
    }
}

Write-Output "Downloading archive from github"
try {
    Invoke-WebRequest $url -OutFile $zipfile
}
catch {
    #try with default proxy and usersettings
    Write-Output "Probably using a proxy for internet access, trying default proxy settings"
    (New-Object System.Net.WebClient).Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    Invoke-WebRequest $url -OutFile $zipfile
}

# Unblock if there's a block
Unblock-File $zipfile -ErrorAction SilentlyContinue

Write-Output "Unzipping"

# Keep it backwards compatible
$shell = New-Object -ComObject Shell.Application
$zipPackage = $shell.NameSpace($zipfile)
$destinationFolder = $shell.NameSpace($temp)
$destinationFolder.CopyHere($zipPackage.Items())

Write-Output "Cleaning up"
Move-Item -Path "$temp\SQLDiagAPI-master\*" $path
Remove-Item -Path "$temp\SQLDiagAPI-master"
Remove-Item -Path $zipfile

Write-Output "Done! Please report any bugs to https://github.com/SQLDBAWithABeard/SQLDiagAPI/issues."
if ((Get-Command -Module SQLDiagAPI).count -eq 0) { Import-Module "$path\SQLDiagAPI.psd1" -Force }
Get-Command -Module SQLDiagAPI
Write-Output "`n`nIf you experience any function missing errors after update, please restart PowerShell or reload your profile."