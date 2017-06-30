function Get-SQLDiagFeature {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $false)]
        [ValidateNotNull()]
        [pscustomobject] $Recommendations = (Get-SQLDiagRecommendations)
    )
    $features = @()
    foreach ($recommendation in $recommendations.Recommendations) {
        foreach ($fix in $recommendation.Content.RelevantFixes) {
            $feature = $fix.Title
            if ($features -notcontains $feature) {
                $Features += $Feature
            }
        }
    }
    $features | Sort-Object
}