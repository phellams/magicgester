using module ../sm/colorconsole/libs/cmdlets/New-ColorConsole.psm1
function Get-ImageInfo {
    [CmdletBinding()]
    [Alias("mgeri")]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$SourcePath
    )

    $logProps = @{
        logname   = $global:_magicgester.logname
        seperator = $global:_magicgester.seperator
        sublog    = $global:_magicgester.sublog
    }

    # Ensure the ImageMagick command-line tool is available
    $imagemagickCmd = "magick" # Adjust path if magick.exe is not in PATH
    if (-not (Get-Command $imagemagickCmd -ErrorAction SilentlyContinue)) {
        [console]::write($logProps.logname + $logProps.seperator + "error $(csole -s 'ImageMagick command "magick" not found. Ensure it is installed and in PATH.' -c red)")
        Write-Error "ImageMagick command 'magick' not found. Ensure it is installed and in PATH."
        return
    }

    # Check if the source path exists
    if (-not (Test-Path $SourcePath)) {
        [console]::write($logProps.logname + $logProps.seperator + "error $(csole -s "Source file '$SourcePath' does not exist." -c red)")
        return
    }

    # Run ImageMagick identify command to get image information
    try {
        $output = & $imagemagickCmd identify -verbose $SourcePath
    }
    catch {
        [console]::write($logProps.logname + $logProps.seperator + "error $(csole -s "Failed to execute ImageMagick on '$SourcePath'. Error: $_" -c red)")
        return
    }

    # Parse ImageMagick output into a structured object
    $info = @{}
    foreach ($line in $output) {
        if ($line -match '^\s*(.+?):\s*(.+)$') {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            $info[$key] = $value
        }
    }

    # Return the parsed information
    [PSCustomObject]$info
}

$cmdlet_config = @{
    function = @('Get-ImageInfo')
    alias   = @('mgeri')
}

Export-ModuleMember @cmdlet_config