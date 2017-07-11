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

.PARAMETER Feature
Wildcard case insensitive search for feature name

.EXAMPLE
Get-SQLDiagFeature

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagFeature -Feature Always

This will return a unique list of all of the Feature Areas that have fixes from the SQL Server Diagnostic API 
with a name including Always (case insensitive)

.EXAMPLE
Get-SQLDiagFeature -Product 'SQL Server 2012 SP3'

This will return a unique list of all of the Feature Areas that have fixes for the product SQL Server 2012 SP3
from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagProduct 2016 | Get-SQLDiagFeature 

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
from the SQL Server Diagnostic API

.EXAMPLE
Get-SQLDiagProduct 2016 | Get-SQLDiagFeature Always

This will return a unique list of all of the Feature Areas that have fixes for products with 2016 in the name 
and features with Always in the name (case insensitive) from the SQL Server Diagnostic API

.NOTES
    AUTHOR  Rob Sewell @SQLDBAWithBeard https://sqldbawithabeard.com
    DATE    30/06/2017
#>
function Get-SQLDiagFeature {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            Mandatory = $false)]
        [ValidateNotNull()]
        [pscustomobject] $Recommendations = (Get-SQLDiagRecommendations),
        [parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( {Get-SQLDiagProduct})]
        [object[]]$Product,
        [parameter(Mandatory = $false, Position = 0)]
        [String[]]$Feature
    )
    Begin {
        # Define empty features array
        $features = @()
    }
    Process {
    
        # If no product grab all of the features and add them to the features array if not already there
        if (!($Product)) {
            Write-Verbose -Message "Getting all of the features"
            foreach ($recommendation in $recommendations.Recommendations) {
                foreach ($fix in $recommendation.Content.RelevantFixes) {
                    $feat = $fix.Title
                    if ($features -notcontains $feat) {
                        $Features += $Feat
                    }
                }
            }
            Write-Verbose -Message "Got all of the features"
        }
        else {
            Write-Verbose -Message "Getting all of the features for $Product"
            # If product grab all of the features for that product and add them to the features array if not already there
            foreach ($P in $Product) {
                foreach ($recommendation in $recommendations.Recommendations) {
                    $Products = $recommendation.Product
                    if ($products -notcontains $p) {continue}
                    foreach ($fix in $recommendation.Content.RelevantFixes) {
                        $feat = $fix.Title
                        if ($features -notcontains $feat) {
                            $Features += $Feat
                        }
                    }
                }
            }
            Write-Verbose -Message "Got all of the features for $product"
        }

    }
    End {
        ## if feature search return only features that match the search term alphabetically
        if ($Feature) {
            Write-Verbose -Message "Sorting the Features for $feature"
            $features | Where-Object {$_ -like "*$($Feature)*"} | Sort-Object
            Write-Verbose -Message "Returnign the Features for $feature"
        }
        ## otherwise return the lot alphabetically
        else {
            Write-Verbose -Message "Sorting the Features"
            $features | Sort-Object
            Write-Verbose -Message "Returning the Features"
        }
    }
}