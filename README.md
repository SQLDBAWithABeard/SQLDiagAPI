## SQLDiagAPI

This is a module to work with the SQL Server Diagnostics (Preview) API. See https://blogs.msdn.microsoft.com/sql_server_team/sql-server-diagnostics-preview/ for more details 

## Installation

Please follow the instructions here [install](install.md)

## Commands

### Get-SQLRecommendations

[This function](functions\Get-SQLRecommendations.ps1) connects to the SQL Server Diagnostic Recommendations API and returns a PSCustomObject 
with information about the latest Cumulative Updates for various SQL Server Versions. 
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

### Get-SQLDiagLatestCU

[This function](functions\Get-SQLDiagLatestCU.ps1) returns the latest Cumulative Updates and the date 

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/06/screenshot.png "Get-SQLDiagLatestCU")

Authored by Rob Sewell

