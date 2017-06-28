# Installing SQLDiagAPI

You can install the module using the [install.ps1](install.ps1) script which will download and install the module to your user profile.

All you need to do is to run this code

    Invoke-Expression (Invoke-WebRequest -UseBasicParsing https://git.io/vQCNp)

    # In the future you will be able to install SQLDiagAPI from the Powershell Gallery using
    Find-Module SQLDiagAPI | Install-Module
    Import-Module SQLDiagAPI
