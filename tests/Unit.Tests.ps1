$script:ModuleName = 'SQLDiagAPI'
# Removes all versions of the module from the session before importing
Get-Module $ModuleName | Remove-Module
$ModuleBase = Split-Path -Parent $MyInvocation.MyCommand.Path
# For tests in .\Tests subdirectory
if ((Split-Path $ModuleBase -Leaf) -eq 'Tests') {
    $ModuleBase = Split-Path $ModuleBase -Parent
}

Import-Module $ModuleBase\$ModuleName.psd1 -PassThru -ErrorAction Stop | Out-Null
Describe "Get-SQLDiagRecommendations" -Tags Build , Unit{
    Context "Requirements" {
        Mock Get-ChildItem {}
        Mock Write-Warning {"Warning"}
        It "Should throw a warning if there is no API Key Environment Variable"{
            Get-SQLDiagRecommendations -ErrorAction SilentlyContinue | Should Be "Warning"
        }
        It 'Checks the Mock was called for Get-ChildItem' {
            $assertMockParams = @{
                'CommandName' = 'Get-ChildItem'
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

    }
    Context "Output" {
        
    }
}
