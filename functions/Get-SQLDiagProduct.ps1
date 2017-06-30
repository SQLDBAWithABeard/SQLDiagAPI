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
    if(!($Product)){
    $recommendations.Recommendations.Product
}
else{
        $recommendations.Recommendations.Product.Where{$_ -like "*$($Product)*"}
}
}