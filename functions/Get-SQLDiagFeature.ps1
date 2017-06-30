<#
.SYNOPSIS
Returns the Features avaialble from teh SQL Server Diagnostic Recommendations API

.DESCRIPTION
This will connect to to the SQL Server Diagnostic Recommendations API and return the 
unique list of features for some or all of the Products 

.PARAMETER Recommendations
The recommendation object from the API - Use Get-SQLDiagRecommendations by default

.PARAMETER Product
The product or products that you want to filter by Get-SQLDiagProduct will show the options

.EXAMPLE
Get-SQLDiagFeature

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API

 .EXAMPLE
Get-SQLDiagFeature -Product 'SQL Server 2012 SP3'

This will return a unique list of all of the Feature Areas that have fixes for the product SQL Server 2012 SP3
from the SQL Server Diagnostic API

.EXAMPLE
$product =  Get-SQLDiagProduct -Product 2016
Get-SQLDiagFeature -Product $product

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
from the SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    30/06/2017
#>
function Get-SQLDiagFeature {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $false)]
        [ValidateNotNull()]
        [pscustomobject] $Recommendations = (Get-SQLDiagRecommendations),
        [parameter(Mandatory = $false)]
        [ValidateScript( {Get-SQLDiagProduct})]
        [String[]]$Product
    )
    $features = @()
    if (!($Product)) {
        foreach ($recommendation in $recommendations.Recommendations) {
            foreach ($fix in $recommendation.Content.RelevantFixes) {
                $feature = $fix.Title
                if ($features -notcontains $feature) {
                    $Features += $Feature
                }
            }
        }
    }
    else {
        foreach ($P in $Product) {
            foreach ($recommendation in $recommendations.Recommendations) {
                $Products = $recommendation.Product
                if ($products -notcontains $p) {continue}
                foreach ($fix in $recommendation.Content.RelevantFixes) {
                    $feature = $fix.Title
                    if ($features -notcontains $feature) {
                        $Features += $Feature
                    }
                }
            }
        }
    }
    $features | Sort-Object
}