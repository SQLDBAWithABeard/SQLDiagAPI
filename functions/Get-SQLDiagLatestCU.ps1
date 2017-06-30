<#
.SYNOPSIS
Gets The Latest Cumulative Updates and Date from the SQL Server Diagnostic API

.DESCRIPTION
Returns Product Name, Cumulative Update Name and Date created from the SQL Server Diagnostic API

.PARAMETER Recommendations
The recommendation object from the API - Use Get-SQLDiagRecommendations 

.PARAMETER Product
The product or products that you want to filter by Get-SQLDiagProducts will show the options

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
Get-SQLDiagRecommendations | Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3'

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagRecommendations | Get-SQLDiagLatestCU -Product 'SQL Server 2012 SP3','SQL Server 2014 SP1'

Returns Product Name, Cumulative Update Name and Date created for SQL Server 2012 SP3 and SQL Server 2014 SP1 from the SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    30/05/2017
#> 
function Get-SQLDiagLatestCU {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $true)]
        [ValidateNotNull()]
        [pscustomobject]$Recommendations,
        [parameter(Mandatory = $false)]
        [ValidateSet('SQL Server 2012 SP3',
            'SQL Server 2016 SP1',
            'SQL Server 2016 RTM',
            'SQL Server 2014 SP1',
            'SQL Server 2014 SP2')]
        [String[]]$Product
    )
    ## Much as I would love to have Products dynamically populated from the Recommendations parameter, this will not work for the pipeline
    ## I can make it work if Recommentations is a parameter but it need to work for the pipeline too
    ## If anyone know how to do this I would be grateful
    Begin {}
    Process {
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
            foreach ($recommendation in $recommendations.Recommendations.Where{$_.Product -in $Product}) {
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
