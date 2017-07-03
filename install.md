# Installing SQLDiagAPI

The SQLDIagAPI module is avaialble on the PowerShell Gallery and can be installed using

    Install-Module SQLDiagAPI

if your user account is not an administrator on your machine you can install using

    Install-Module SQLDiagAPI -Scope CurrentUser

You can also install the module using the [install.ps1](install.ps1) script which will download and install the module to your user profile.

All you need to do is to run this code

    Invoke-Expression (Invoke-WebRequest -UseBasicParsing https://git.io/vQCNp)

    # In the future you will be able to install SQLDiagAPI from the Powershell Gallery using
    Find-Module SQLDiagAPI | Install-Module
    Import-Module SQLDiagAPI
