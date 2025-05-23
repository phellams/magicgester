using module ../sm/colorconsole/libs/cmdlets/New-ColorConsole.psm1

function Export-SvgRanges {
    <#
    .SYNOPSIS
    Exports SVG files to various formats (PNG, ICO, JPG, etc.) using specified ranges.

    .DESCRIPTION
    This cmdlet uses Inkscape and ImageMagick to export SVG files to multiple formats based on specified range parameters.
    It validates dependencies, checks operating system compatibility, and organizes output into respective folders.

    .PARAMETER Source
    The path to the source SVG file.

    .PARAMETER Destination
    The destination folder for exported files.

    .PARAMETER PngRanges
    An array of ranges for PNG export (e.g., @('16x16', '32x32', '64x64')).

    .PARAMETER IcoRanges
    An array of ranges for ICO export (maximum size: 256).

    .PARAMETER JpgRanges
    An array of ranges for JPG export.

    .PARAMETER SvgRanges
    An array of ranges for SVG export.

    .PARAMETER TiffRanges
    An array of ranges for TIFF export.

    .PARAMETER WebpRanges
    An array of ranges for WEBP export.

    .PARAMETER PdfRanges
    An array of ranges for PDF export.

    .NOTES
    Requires Inkscape and ImageMagick installed on the system.

    .EXAMPLE
    Export-Ranges -Source "master.svg" -Destination "output" -PngRanges @('16x16', '32x32', '64x64')
    Exports the SVG file to PNG format in specified dimensions.
    #>
    [CmdletBinding()]
    [Alias("mgerx")]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Source,

        [Parameter(Mandatory = $true)]
        [string]$Destination,

        [string]$name,

        [array]$PngRanges,

        [array]$IcoRanges,

        [array]$JpgRanges,

        [array]$SvgRanges,

        [array]$TiffRanges,

        [array]$WebpRanges,

        [array]$PdfRanges
    )

    begin {
        # Dependency Check
        $isWindowsPlatform = $PSVersionTable.OS -match "Windows"
        $inkscapeCmd = if ($isWindowsPlatform) { "inkscape.exe" } else { "inkscape" }
        $imagemagickCmd = if ($isWindowsPlatform) { "magick.exe" } else { "convert" }

        function Get-Dependency {
            param ($Command, $InstallHint)
            if (-not (Get-Command $Command -ErrorAction SilentlyContinue)) {
                [console]::write("$($logProps.logname)$($logProps.seperator) Running $(csole -s 'Dependency Check...' -c magenta) > $Command")
                csole -String "Dependency '$Command' not found. $InstallHint" -Color Red
                throw "Dependency missing."
            }
        }

        Get-Dependency -Command $inkscapeCmd -InstallHint "Install from: https://inkscape.org/"
        Get-Dependency -Command $imagemagickCmd -InstallHint "Install from: https://imagemagick.org/"

        $logProps = @{
            logname = $global:_magicgester.logprops.logname
            seperator = $global:_magicgester.logprops.seperator
            sublog    = $global:_magicgester.logprops.sublog
        }
    }

    process {
        # Ensure destination exists
        if (-not (Test-Path -Path $Destination)) {
            New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        }
        [console]::write("$($logProps.logname)$($logProps.seperator) running $(csole -s 'Export Ranges from SVG' -c magenta)`n")
        
        # Define export logic
        function Export-UsingInkscape {
            param ($Format, $Ranges)
            [console]::write("$($logProps.logname)$($logProps.seperator) running $(csole -s '[InkscapeWrapper]' -c magenta)`n")
            foreach ($range in $Ranges) {
                $width, $height = $range -split "x"
                if ($name) {
                    $outputPath = Join-Path -Path $Destination -ChildPath "$Format\$name-$width`x$height.$Format"
                }else{
                    $outputPath = Join-Path -Path $Destination -ChildPath "$Format\$width`x$height.$Format"
                }
                $outputFolder = Split-Path -Parent $outputPath

                if (-not (Test-Path $outputFolder)) {
                    New-Item -ItemType Directory -Path $outputFolder -Force | Out-Null
                }
                & $inkscapeCmd --export-width=$width --export-height=$height --export-filename=$outputPath $Source
                [console]::write("$($logProps.sublog) exported range: $(csole -s $outputPath -c darkcyan)`n")
            }
        }

        function Export-UsingImageMagick {
            param (
                [string]$Format,
                [array]$Ranges
            )
            [console]::write("$($logProps.logname)$($logProps.seperator) running $(csole -s '[ImageMagickWrapper]' -c magenta)`n")
            foreach ($range in $Ranges) {
                # Split width and height from the range
                $width, $height = $range -split "x"

                # Construct PNG export path
                $fileBaseName = if ($name) { "$name-$($width)x$height" } else { "$($width)x$height" }
                $pngExportPath = Join-Path -Path $Destination -ChildPath "png\$fileBaseName.png"

                # Ensure the output folder exists
                $outputFolder = Split-Path -Parent $pngExportPath
                if (-not (Test-Path $outputFolder)) {
                    try {
                        [console]::write("$($logProps.logname)$($logProps.seperator) running $(csole -s '[Create Output Folder]' -c magenta)`n")
                        New-Item -ItemType Directory -Path $outputFolder -Force | Out-Null
                    }
                    catch {
                        csole -String "Failed to create directory: $outputFolder" -Color Red
                        continue
                    }
                }

                # Set export location for ICO files
                $exportLocation = Join-Path -Path $Destination -ChildPath "ico"
                $icoFileName = if ($name) { "$name-$($width)x$height.ico" } else { "$($width)x$height.ico" }

                # Execute ImageMagick command
                try {
                    & $imagemagickCmd $pngExportPath (Join-Path -Path $exportLocation -ChildPath $icoFileName)
                    # Success message
                    [console]::write("$($logProps.logname)$($logProps.seperator) exported $(csole -s "$exportLocation\$icoFileName" -c darkyellow)`n")
                }
                catch {
                    csole -String "Failed to execute ImageMagick for $pngExportPath" -Color Red
                    continue
                }
            }
        }

        # Export to each format
        if ($PngRanges) { Export-UsingInkscape -Format "png" -Ranges $PngRanges }
        if ($IcoRanges) {
            start-sleep -Seconds 3 # wait for inkscape to finish
            [console]::write("$($logProps.logname)$($logProps.seperator) exporting ico ranges: $(csole -s "$($IcoRanges -join ', ')" -c darkcyan)`n")
            if ((Test-Path "$destination\ico") -eq $false) {
                New-Item -ItemType Directory -Path "$destination\ico" -Force | Out-Null
            }
            foreach ($range in $IcoRanges) {
                $width, $height = $range -split "x"
                Export-UsingInkscape -Format 'png' -Ranges @($range)
                Export-UsingImageMagick -Format 'ico' -Ranges @($range)
            }
        }
        if ($JpgRanges) { Export-UsingInkscape -Format "jpg" -Ranges $JpgRanges }
        if ($SvgRanges) { Export-UsingInkscape -Format "svg" -Ranges $SvgRanges }
        if ($TiffRanges) { Export-UsingInkscape -Format "tiff" -Ranges $TiffRanges }
        if ($WebpRanges) { Export-UsingInkscape -Format "webp" -Ranges $WebpRanges }
        if ($PdfRanges) { Export-UsingInkscape -Format "pdf" -Ranges $PdfRanges }
    }

    end {
        # calculate Ranges
        $report = [hashtable]@{}
        if ($SvgRanges -or $null -ne $SvgRanges) {
            $report['SvgRanges'] = $SvgRanges.Count
        }
        if ($IcoRanges -or $null -ne $IcoRanges) {
            $report['IcoRanges'] = $IcoRanges.Count
        }
        if ($JpgRanges -or $null -ne $JpgRanges) {
            $report['JpgRanges'] = $JpgRanges.Count
        }
        if ($PdfRanges -or $null -ne  $PdfRanges) {
            $report['PdfRanges'] = $PdfRanges.Count
        }
        if ($TiffRanges -or $null -ne $TiffRanges) {
            $report['TiffRanges'] = $TiffRanges.Count
        }
        if ($PngRanges -or $null -ne $PngRanges) {
            $report['PngRanges'] = $PngRanges.Count
        }
        if ($WebpRanges -or $null -ne $WebpRanges) {
            $report['WebpRanges'] = $WebpRanges.Count
        }
        # Success message
        [console]::write("$($logProps.logname)$($logProps.seperator) $( csole -s 'export completed successfully' -c green )`n")
        return $report
    }
}

Export-ModuleMember -Function Export-Ranges


$cmdlet_config = @{
    function = @('Export-SvgRanges')
    alias   = @('mgerx')
}

Export-ModuleMember @cmdlet_config