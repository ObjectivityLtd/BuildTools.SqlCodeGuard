#######################################################################################################
## Name:             Clear-CacheIfOutdated.ps1
## Description:      Clears the SCG-output cache file, if if was generated by the tool in old version.
#######################################################################################################
function Clear-CacheIfOutdated {
    [OutputType([void])]
    param (
        [Parameter(Mandatory = $true)]
        $Context
    )

    if ($Context.CacheXml -ne $null) {

        $files = $Context.CacheXml.files

        if ($files -ne $null -and $files.GetType() -ne [string]) {

            [string]$toolsVersion = $files.GetAttribute('toolsVersion')
            [string]$configTimestamp = $files.GetAttribute('configTimestamp')

            if (-not([string]::IsNullOrWhiteSpace($toolsVersion)) -and ($Context.ToolsVersion -eq $toolsVersion) `
                -and -not([string]::IsNullOrWhiteSpace($configTimestamp)) -and ($Context.ConfigTimestamp -eq $configTimestamp)) {

                return
            }
        }
    }

    Set-EmptyCacheFile -Context $Context
}