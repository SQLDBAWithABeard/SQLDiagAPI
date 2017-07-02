function Get-SQLDiagFix {
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
    Begin {}
    Process {
        if ($Product -and $feature) {
            foreach ($P in $Product) {
                foreach ($recommendation in $recommendations.Recommendations | Where-Object {$_.Product -eq $P}) {
                    $ProductName = $recommendation.Product
                    foreach ($f in $feature) {
                        foreach ($fix in $recommendation.Content.RelevantFixes | Where-Object {$_.Title -eq $F}) {
                            $feat = $fix.Title
                            foreach ($kb in $fix.KbArticles) {
                                [PSCustomObject]@{
                                    Product = $ProductName
                                    Feature = $feat
                                    KB      = $kb.Rel
                                    Title   = $Kb.title
                                    URL     = $kb.Href
                                }
                            }
                        }
                    }
                }
            }
        }
        elseif ($Product) {
            foreach ($P in $Product) {
                foreach ($recommendation in $recommendations.Recommendations | Where-Object {$_.Product -eq $P}) {
                    $ProductName = $recommendation.Product
                    foreach ($fix in $recommendation.Content.RelevantFixes) {
                        $feat = $fix.Title
                        foreach ($kb in $fix.KbArticles) {
                            [PSCustomObject]@{
                                Product = $ProductName
                                Feature = $feat
                                KB      = $kb.Rel
                                Title   = $Kb.title
                                URL     = $kb.Href
                            }
                        }
                    }
                }
            }
        }
        elseif ($feature) {
            foreach ($recommendation in $recommendations.Recommendations) {
                $ProductName = $recommendation.Product
                foreach ($f in $feature) {
                    foreach ($fix in $recommendation.Content.RelevantFixes | Where-Object {$_.Title -eq $F}) {
                        $feat = $fix.Title
                        foreach ($kb in $fix.KbArticles) {
                            [PSCustomObject]@{
                                Product = $ProductName
                                Feature = $feat
                                KB      = $kb.Rel
                                Title   = $Kb.title
                                URL     = $kb.Href
                            }
                        }
                    }
                }
            }
        }
        else {
            foreach ($recommendation in $recommendations.Recommendations) {
                $ProductName = $recommendation.Product
                foreach ($fix in $recommendation.Content.RelevantFixes) {
                    $feat = $fix.Title
                    foreach ($kb in $fix.KbArticles) {
                        [PSCustomObject]@{
                            Product = $ProductName
                            Feature = $feat
                            KB      = $kb.Rel
                            Title   = $Kb.title
                            URL     = $kb.Href
                        }
                    }
                }
            }
        }
    }
        
    End {}
}