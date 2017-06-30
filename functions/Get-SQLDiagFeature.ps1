function Get-SQLDiagFeature {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $false)]
        [ValidateNotNull()]
        [pscustomobject] $Recommendations = (Get-SQLDiagRecommendations)
    )
$Recommendations
}