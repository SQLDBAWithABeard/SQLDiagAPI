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
    foreach ($recommendation in $recommendations.Recommendations) {
        if($Product){
            $Products = $recommendation.Product
            if ($products -notcontains $product) {continue}
        }
        foreach ($fix in $recommendation.Content.RelevantFixes) {
            $feature = $fix.Title
            if ($features -notcontains $feature) {
                $Features += $Feature
            }
        }
    }
    $features | Sort-Object
}