<#
.SYNOPSIS
Gets The Latest Cumulative Updates and Date from the SQL Server Diagnostic API

.DESCRIPTION
Returns Product Name, Cumulative Update Name and Date created from the SQL Server Diagnostic API

.PARAMETER Recommendations
The recommendation object from the API - Use Get-SQLDiagRecommendations by default

.PARAMETER Product
The product or products that you want to filter by Get-SQLDiagProduct will show the options

.EXAMPLE
Get-SQLDiagLatestCU

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagRecommendations | Get-SQLDiagLatestCU

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagLatestCU -Recommendations (Get-SQLDiagRecommendations)

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

.EXAMPLE
$Recommendations = Get-SQLDiagRecommendations 
Get-SQLDiagLatestCU -Recommendations $Recommendations 

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

.EXAMPLE
$Recommendations = Get-SQLDiagRecommendations 
Get-SQLDiagLatestCU -Recommendations $Recommendations 

Returns Product Name, Cumulative Update Name and Date created for all products from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3'

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1'

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the 
SQL Server Diagnostic API

.EXAMPLE
$product =  Get-SQLDiagProduct -Product 2016
Get-SQLDiagLatestCU -Product $product

Returns Product Name, Cumulative Update Name and Date created for products with 2016 in the name from the 
SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1' | Out-GridView

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the 
SQL Server Diagnostic API and outputs to Out-GridView

.EXAMPLE
Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1' | Out-File C:\Temp\LatestCU.txt

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the 
SQL Server Diagnostic API and outputs to a File C:\Temp\LatestCU.txt

.EXAMPLE
$LatestCu =  Get-SQLDiagLatestCU | Out-DbaDataTable
Write-DbaDataTable -SqlServer $Server -Database $DB -InputObject $LatestCu-Table $LatestCu -AutoCreateTable

Puts Product Name, Cumulative Update Name and Date created for all products from the 
SQL Server Diagnostic API into a database table and creates the table - Requires dbatools https://dbatools.io

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    30/06/2017
#> 
function Get-SQLDiagLatestCU {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $false)]
        [ValidateNotNull()]
        [pscustomobject] $Recommendations = (Get-SQLDiagRecommendations),
        [parameter(Mandatory = $false)]
        [ValidateScript( {Get-SQLDiagProduct})]
        [String[]]$Product,
        [switch]$LearnMore
    )
    ## Much as I would love to have Products dynamically populated from the Recommendations parameter, this will not work for the pipeline
    ## I can make it work if Recommendations is a parameter but it needs to work for the pipeline too
    ## If anyone know how to do this I would be grateful
    Begin {}
    Process {
        if($LearnMore -and (!$Product)){
            Write-Warning "The Learn More switch requires a Product so that it only opens one browser window."
            break
        }
        if($LearnMore -and $Product)
        {
            Start-Process 'https://google.co.uk'
            break
        }
        if (!($Product)) {
            foreach ($recommendation in $recommendations.Recommendations) {
                $ProductName = $recommendation.Product
                $CU = $recommendation.Title
                $CreatedOn = $recommendation.CreatedOn
                [PSCustomObject]@{
                    Product   = $ProductName
                    CU        = $CU
                    CreatedOn = $CreatedOn
                }
            }
        }
        else {
            foreach ($recommendation in $recommendations.Recommendations | Where-Object {$_.Product -in $Product}) {
                $ProductName = $recommendation.Product
                $CU = $recommendation.Title
                $CreatedOn = $recommendation.CreatedOn
                [PSCustomObject]@{
                    Product   = $ProductName
                    CU        = $CU
                    CreatedOn = $CreatedOn
                }
            }
        }
    }
}
