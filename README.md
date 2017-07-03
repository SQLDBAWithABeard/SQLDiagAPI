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

You can also find the documentation for the commands [here](docs)

### Get-SQLDiagFix

[This function](functions\Get-SQLDiagFix.ps1) connects to the SQL Server Diagnostic Recommendations API and returns the Fixes for the latest Cumulative Update by Product or Feature Area or both.

The video below shows how it works 

[![Alt text](https://img.youtube.com/vi/gRDM7WUeWkQ/0.jpg)](https://www.youtube.com/watch?v=gRDM7WUeWkQ)

### Get-SQLDiagRecommendations

[This function](functions\Get-SQLDiagRecommendations.ps1) connects to the SQL Server Diagnostic Recommendations API and returns a PSCustomObject 
with information about the latest Cumulative Updates for various SQL Server Versions. 
Details here https://ecsapi.portal.azure-api.net/

It requires the APIKey parameter or the APIKey to be stored using Export-CliXML in the users profile
in a file named SQLDiag.Cred

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/07/get-sqldiagrecommendations-screenshot.png "Get-SQLDiagRecommendations")

### Get-SQLDiagProduct

[This function](functions\Get-SQLDiagProduct.ps1) returns the products available in the SQL Server Diagnostic API

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/06/screenshot1.png "Get-SQLDiagProduct")


### Get-SQLDiagLatestCU

[This function](functions\Get-SQLDiagLatestCU.ps1) returns the latest Cumulative Updates and the date 

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/07/get-sqldiaglatestcus-screenshot.png "Get-SQLDiagLatestCU")


### Get-SQLDiagFeature
[This function](functions\Get-SQLDiagFeature.ps1) will show the feature areas that have fixes in the SQL Server Diagnostics Recommendations API for one, several or all products

![alt text](https://newsqldbawiththebeard.files.wordpress.com/2017/07/get-sqldiagfeature-screenshot1.png "Get-SQLDiagFeature")


Authored by Rob Sewell

