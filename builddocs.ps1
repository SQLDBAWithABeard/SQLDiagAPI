$ProjectRoot = Get-Location
$ModuleName = 'SQLDiagAPI'
$BuildDate = Get-Date -uFormat '%Y-%m-%d'
$ReleaseNotes = "$ProjectRoot\RELEASE.md"
$ChangeLog = "$ProjectRoot\docs\ChangeLog.md"


#Build YAMLText starting with the header
$YMLtext = (Get-Content "$ProjectRoot\header-mkdocs.yml") -join "`n"
$YMLtext = "$YMLtext`n"

$Params = @{
    Module       = 'SQLDiagAPI'
    Force        = $true
    OutputFolder = "$ProjectRoot\docs\functions"
    NoMetadata   = $true
}
New-MarkdownHelp @Params | foreach-object {
    $Function = $_.Name -replace '\.md', ''
    $Part = "    - {0}: functions/{1}" -f $Function, $_.Name
    $YMLText = "{0}{1}`n" -f $YMLText, $Part
    $Part
}
$YMLtext | Set-Content -Path "$ProjectRoot\mkdocs.yml"