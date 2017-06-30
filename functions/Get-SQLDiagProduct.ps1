function Get-SQLDiagProduct {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $true)]
        [ValidateNotNull()]
        [pscustomobject]$Recommendations,
        [parameter(Mandatory = $false)]
        [String]$Product
    )
    $recommendations.Recommendations.Product
}