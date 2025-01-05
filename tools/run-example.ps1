using module ..\libs\cmdlets\Export-SvgRanges.psm1

$props = @{
    Source = "G:\devspace\projects\powershell\_repos\phallems-general-resources\logos\coforge\coforge-c1.svg"
    Destination = "G:\devspace\projects\powershell\_repos\phallems-general-resources\logos\output"
    name = 'logo-v1'
    # PngRanges = @('16x16', '32x32', '64x64', '128x128', '256x256', '512x512', '1024x1024')
    # IcoRanges = @('16x16', '32x32', '64x64')
    # JpgRanges = @('16x16', '32x32', '64x64', '128x128', '256x256', '512x512', '1024x1024')
    # SvgRanges = @('16x16', '32x32', '64x64', '128x128', '256x256', '512x512', '1024x1024')
    # TiffRanges = @('16x16', '32x32', '64x64', '128x128', '256x256', '512x512', '1024x1024')
    WebpRanges = @('16x16', '32x32', '64x64', '128x128', '256x256', '512x512', '1024x1024')
    PdfRanges = @('16x16', '32x32', '64x64', '128x128', '256x256', '512x512', '1024x1024')
}

mgerx @props