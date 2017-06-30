## SQLDiagAPI

This is a module to work with the SQL Server Diagnostics (Preview) API. See https://blogs.msdn.microsoft.com/sql_server_team/sql-server-diagnostics-preview/ for more details 

Blog Posts about this module

How the module was created and usign TDD for Get-SQLDiagRecommendations
http://sqldbawithabeard.com/2017/06/30/creating-a-powershell-module-and-tdd-for-get-sqldiagrecommendations/ 

using Get-SQLDiagRecommendations
http://sqldbawithabeard.com/2017/06/29/powershell-module-for-the-sql-server-diagnostics-api-1st-command-get-sqldiagrecommendations/

## Installation

Please follow the instructions here [install](install.md)

## Commands

To understand how best to use the commands please run

    Get-Help CommandName -Full

This will show you details and plenty of examples

### Get-SQLRecommendations

[This function](functions\Get-SQLRecommendations.ps1) connects to the SQL Server Diagnostic Recommendations API and returns a PSCustomObject 
with information about the latest Cumulative Updates for various SQL Server Versions. 
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

### Get-SQLDiagLatestCU

[This function](functions\Get-SQLDiagLatestCU.ps1) returns the latest Cumulative Updates and the date 

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/06/get-sqldiagproduct-screenshot1.png "Get-SQLDiagLatestCU")

### Get-SQLDiagProduct

[This function](functions\Get-SQLDiagProduct.ps1) returns the products available in the SQL Server Diagnostic API

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/06/screenshot1.png "Get-SQLDiagProduct")

Authored by Rob Sewell

