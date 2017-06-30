function Get-SQLDiagProduct {
    [cmdletbinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName, 
            ValueFromPipeline,
            Mandatory = $true)]
        [ValidateNotNull()]
        [pscustomobject]$Recommendations
    )
    $recommendations.Recommendations.Product
}