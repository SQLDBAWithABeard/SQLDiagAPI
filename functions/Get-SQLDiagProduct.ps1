<#
.SYNOPSIS
Returns the Products avaiable in the SQL Server Diagnostic API

.DESCRIPTION
Enables you to search for the products that are available in the SQL Server Diagnostic API

.PARAMETER Recommendations
The recommendation object from the API - Uses Get-SQLDiagRecommendations by default 

.PARAMETER Product
The search for the product you do not need to enter wildcards

.EXAMPLE
Get-SQLDiagProduct

Returns all of the Product Names in the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagRecommendations | Get-SQLDiagProduct

Returns all of the Product Names in the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagProduct -Product 2012

Returns all of the Product Names in the SQL Server Diagnostic API with 2012 in the name

.EXAMPLE
Get-SQLDiagProduct -Product SP1

Returns all of the Product Names in the SQL Server Diagnostic API with SP1 in the name

.EXAMPLE
Get-SQLDiagProduct SP1

Returns all of the Product Names in the SQL Server Diagnostic API with SP1 in the name

.EXAMPLE
$product = Get-SQLDiagProduct -Product 2016
Get-SQLDiagLatestCU -Product $product

Returns Product Name, Cumulative Update Name and Date created for products with 2016 in the name from the 
SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    30/06/2017
#>
function Get-SQLDiagProduct {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $false)]
        [ValidateNotNull()]
        [pscustomobject]$Recommendations = (Get-SQLDiagRecommendations),
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline, Position = 0,
            Mandatory = $false)]
        [String]$Product
    )
    if(!($Product)){
        Write-Verbose -Message "Getting All the Products from the API"
    $recommendations.Recommendations.Product
        Write-Verbose -Message "Got the Products from the API"
}
else{
        Write-Verbose -Message "Getting the products from the API filtered by $Product"
        $recommendations.Recommendations.Product | Where-Object {$_ -like "*$($Product)*"}
        Write-Verbose -Message "Got the Products from the API"
}
}