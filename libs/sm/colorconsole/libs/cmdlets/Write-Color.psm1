<#
.SYNOPSIS
  Write Colorize a string using ANSI escape sequences and console.log to output the string.

.DESCRIPTION
  The Write-Color function takes a string and a color, and returns the string with the specified color.

.PARAMETER string
  The input string to be colorized.

.PARAMETER color
  The color to be applied to the string.

.PARAMETER bgcolor
  The background color to be applied to the string.

.PARAMETER debug
  for testing only.

.EXAMPLE
  Write-Color -string "Hello World" -color Red
  Write-Color -string "Hello World" -color Red -bgcolor Yellow

.OUTPUTS
  The colorized string.

.NOTES
  The available colors are: foreground and background
  * Blue
  * Yellow
  * Green
  * Red
  * White
  * Black
  * Cyan
  * Magenta
  * Gray
  * Darkgray
  * Darkblue
  * Darkyellow
  * Darkgreen
  * Darkred
  * Darkcyan
  * Darkmagenta

.LINK
  https://en.wikipedia.org/wiki/ANSI_escape_code
#>
Function Write-Color() {
    [CmdletBinding()]
    [Alias('wsole')]
    [OutputType([void])]
    param(
        [parameter(mandatory = $true, Position = 0)]
        [string]$string,
        [parameter(mandatory = $false, Position = 1)]
        [ValidateSet("blue", "yellow", "green", "red", "white", "black", "cyan", "magenta", "gray", "darkgray", "darkblue", "darkyellow", "darkgreen", "darkred", "darkcyan", "darkmagenta", ignorecase = $true)]
        $color,
        [parameter(mandatory = $false)]
        [ValidateSet("blue", "yellow", "green", "red", "white", "black", "cyan", "magenta", "gray", "darkgray", "darkblue", "darkyellow", "darkgreen", "darkred", "darkcyan", "darkmagenta", ignorecase = $true)]
        $bgcolor,
        [parameter(mandatory = $false, ValueFromPipeline = $true)]
        [switch]$nline = $false
    )
    Begin {
        if (!$color) { $color = 'white' }
        if ($null -eq $bgcolor) {
            $coloredText = New-ColorConsole -string $string -color $color
        }
        else {
            $coloredText = New-ColorConsole -string $string -color $color -bgcolor $bgcolor
        }
    }
    Process {
        if ($nline) {
            [Console]::Write("$($coloredText)`n")
        }
        else {
            [Console]::Write($coloredText)
        }
    }
}
$moduleconfig = @{
    function = @('Write-Color')
    alias    = @('wsole')
}
Export-ModuleMember @moduleconfig