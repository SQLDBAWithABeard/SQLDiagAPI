$script:ModuleName = 'SQLDiagAPI'
# Removes all versions of the module from the session before importing
Get-Module $ModuleName | Remove-Module
$ModuleBase = Split-Path -Parent $MyInvocation.MyCommand.Path
# For tests in .\Tests subdirectory
if ((Split-Path $ModuleBase -Leaf) -eq 'Tests') {
    $ModuleBase = Split-Path $ModuleBase -Parent
}

Import-Module $ModuleBase\$ModuleName.psd1 -ErrorAction Stop #| Out-Null
InModuleScope -ModuleName SQLDiagAPI {
    Describe "Get-SQLDiagRecommendations" -Tags Build , Unit {

        Context "Requirements" {
            BeforeAll {
                Mock Test-Path {$false}
                Mock Write-Warning {"Warning"}
            }
            It "Should throw a warning if there is no API Key XML File and the APIKey Parameter is not used" {
                Get-SQLDiagRecommendations -ErrorAction SilentlyContinue | Should Be "Warning"
            }
            It 'Checks the Mock was called for Test-Path' {
                $assertMockParams = @{
                    'CommandName' = 'Test-Path'
                    'Times'       = 1
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }
            It 'Checks the Mock was called for Write-Warning' {
                $assertMockParams = @{
                    'CommandName' = 'Write-Warning'
                    'Times'       = 1
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }

        }
        Context "Input" {

        }
        Context "Execution" {
            It "Returns a warning if unable to get Machine GUID" {
                Mock Get-MachineGUID  {} -Verifiable
                Mock Write-Warning {"Warning"} -Verifiable
                Get-SQLDiagRecommendations -APIKey dummykey | Should Be "Warning"
                Assert-VerifiableMocks 
            }

        }
        Context "Output" {
        
        }
    }

    Describe "Get-SQLDiagLatestCU" -Tags Build , Unit {
        BeforeAll {
            $Recommendations = (Get-Content $PSScriptRoot\recommendations.JSON) -join "`n" | ConvertFrom-Json
            Mock Get-SQLDiagRecommendations {$Recommendations}
        }
        Context "Input" {
            It "Accepts Recommendations input via Pipeline"{
                Get-SQLDiagRecommendations | Get-SQLDiagLatestCU -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
                {Get-SQLDiagRecommendations | Get-SQLDiagLatestCU} | Should Not Throw
            }
            It "Accepts Recommendations Input via Parameter" {
                Get-SQLDiagLatestCU -Recommendations $Recommendations -ErrorAction SilentlyContinue| Should Not Be NullOrEmpty
            }
            It 'Checks the Mock was called for Get-SQLDiagRecommendations' {
                $assertMockParams = @{
                    'CommandName' = 'Get-SQLDiagRecommendations'
                    'Times'       = 2
                    'Exactly'     = $true
                }
                Assert-MockCalled @assertMockParams 
            }

        }
        Context "Execution" {

        }
        Context "Output" {
        
        }
    }
}
