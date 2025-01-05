# MagicGester 

MagicGester is a ***PowerShell module*** that provides a number of cmdlets for exporting SVG files to various formats 🎬 (**PNG**, **ICO**, **JPG**, **TIFF**, **WEBP**, **PDF**) using specified ranges, and returning information about the exported files.

## 🏐 Installation

To install the module, run the following command in PowerShell:

```powershell
git clone https://github.com/sgkens/MagicGester.git
cd MagicGester
Import-Module .\
```

## 🏐 Usage

To use the module, import it in your PowerShell script:

Once imported, you can use the cmdlets provided by the module. For example, to export an SVG file to PNG format in specified dimensions, you can use the `Export-SvgRanges` cmdlet:

> SVG to PNG ranges example
```powershell
Export-SvgRanges -Source "master.svg" -Destination "output" -PngRanges @('16x16', '32x32', '64x64')
```
> SVG to JPG ranges example
```powershell
Export-SvgRanges -Source "master.svg" -Destination "output" -JpgRanges @('16x16', '32x32', '64x64')
```

> SVG to ICO ranges example - Max size is 256x256
```powershell
Export-SvgRanges -Source "master.svg" -Destination "output" -IcoRanges @('16x16', '32x32', '64x64')
```

> SVG to TIFF ranges example
```powershell
Export-SvgRanges -Source "master.svg" -Destination "output" -TiffRanges @('16x16', '32x32', '64x64')
```

> SVG to WEBP ranges example
```powershell
Export-SvgRanges -Source "master.svg" -Destination "output" -WebpRanges @('16x16', '32x32', '64x64')
```

> SVG to PDF ranges example
```powershell
Export-SvgRanges -Source "master.svg" -Destination "output" -PdfRanges @('16x16', '32x32', '64x64')
```

### ⚙ Export-SvgRanges

The `Export-SvgRanges` cmdlet is used to export SVG files to various formats using specified ranges. It takes the following parameters:

- `Source`: The path to the SVG file to be exported.
- `Destination`: The path to the directory where the exported files will be saved.
- `PngRanges`: An array of strings representing the ranges to be used for PNG export. Each range should be in the format "widthxheight" and should be separated by a comma.
- `JpgRanges`: An array of strings representing the ranges to be used for JPG export. Each range should be in the format "widthxheight" and should be separated by a comma.
- `IcoRanges`: An array of strings representing the ranges to be used for ICO export. Each range should be in the format "widthxheight" and should be separated by a comma.
- `TiffRanges`: An array of strings representing the ranges to be used for TIFF export. Each range should be in the format "widthxheight" and should be separated by a comma.                             
- `WebpRanges`: An array of strings representing the ranges to be used for WEBP export. Each range should be in the format "widthxheight" and should be separated by a comma.
- `PdfRanges`: An array of strings representing the ranges to be used for PDF export. Each range should be in the format "widthxheight" and should be separated by a comma.

```powershell
Export-SvgRanges -Source "master.svg"`
                 -Destination "output"`
                 -PngRanges @('16x16', '32x32', '96x96')`
                 -JpgRanges @('16x16', '32x32', '64x64')`
                 -IcoRanges @('16x16', '32x32', '64x64')`
                 -TiffRanges @('16x16', '32x32', '64x64')`
                 -WebpRanges @('16x16', '32x32', '64x64')`
                 -PdfRanges @('16x16', '32x32', '1064x1064')
```

Output:

```powershell
    ├ Output
    │  ├ ico
    │  │  ├ logo-v1-16x16.ico
    │  │  ├ logo-v1-32x32.ico
    │  │  ├ logo-v1-64x64.ico
    │  │  └ logo-v1-256x256.ico
    │  ├ jpg
    │  │  ├ logo-v1-16x16.jpg
    │  │  ├ logo-v1-32x32.jpg
    │  │  ├ logo-v1-64x64.jpg
    │  │  └ logo-v1-256x256.jpg
    │  ├ pdf
    │  │  ├ logo-v1-16x16.pdf
    │  │  ├ logo-v1-32x32.pdf
    │  │  ├ logo-v1-64x64.pdf
    │  │  └ logo-v1-256x256.pdf
    │  ├ png
    │  │  ├ logo-v1-16x16.png
    │  │  ├ logo-v1-32x32.png
    │  │  ├ logo-v1-64x64.png
    │  │  └ logo-v1-256x256.png
    │  ├ svg
    │  │  ├ logo-v1-16x16.svg
    │  │  ├ logo-v1-32x32.svg
    │  │  ├ logo-v1-64x64.svg
    │  │  └ logo-v1-256x256.svg
    │  ├ tiff
    │  │  ├ logo-v1-16x16.tiff
    │  │  ├ logo-v1-32x32.tiff
    │  │  ├ logo-v1-64x64.tiff
    │  │  └ logo-v1-256x256.tiff
    │  └ webp
    │     ├ logo-v1-16x16.webp
    │     ├ logo-v1-32x32.webp
    │     ├ logo-v1-64x64.webp
    │     └ logo-v1-256x256.webp
```
This will export the SVG file to PNG, JPG, ICO, TIFF, WEBP, and PDF formats using the specified ranges.

### ⚙ Get-ImageInfo

The `Get-ImageInfo` cmdlet is used to return information about the exported images. It takes the following parameters:

- `SourcePath`: The path to the directory where the image file is located.

```powershell
Get-ImageInfo -SourcePath ".\output\ico\logo-v1-16x16.ico"
```

Output:

```powershell
white point        : (0.3127,0.329,0.3583)
Gamma              : 0.454545
Background color   : white
Number pixels      : 256
blue primary       : (0.15,0.06,0.79)
Filename           : .\output\ico\logo-v1-16x16.ico
Page geometry      : 16x16+0+0
Endianness         : Undefined
Tainted            : False
red primary        : (0.64,0.33,0.03)
Interlace          : None
Filesize           : 1150B
1                  : (197,177,171,255) #C5B1ABFF srgba(197,177,171,1)
Compose            : Over
Blue               : 8-bit
Pixels             : 256
Alpha              : srgba(52,52,52,0)   #34343400
kurtosis           : -0.121
Base type          : Undefined
Type               : PaletteAlpha
Geometry           : 16x16+0+0
Pixel cache type   : Memory
Pixels per second  : 145.97KP
Intensity          : Undefined
Transparent color  : black
User time          : 0.002u
Depth              : 8-bit
Rendering intent   : Perceptual
Red                : 8-bit
standard deviation : 60.791 (0.2384)
verbose            : true
Class              : DirectClass
date               : timestamp: 2025-01-05T02:17:22+00:00
Elapsed time       : 0:01.001
Format             : ICO (Microsoft icon)
signature          : d7db39293d78a7644c067eb0144ad873a35c0a4ecbd7a5f1cf2270a80cc88e08
Matte color        : grey74
min                : 0  (0)
50                 : (52,52,52,0) #34343400 srgba(52,52,52,0)
Green              : 8-bit
Units              : Undefined
median             : 107.5 (0.42157)
Colorspace         : sRGB
Dispose            : Undefined
Compression        : Undefined
Permissions        : rw-rw-rw-
Channels           : 4.0
mean               : 104.22 (0.4087)
2                  : (70,49,88,223) #463158DF srgba(70,49,88,0.87451)
Border color       : srgb(223,223,223)
Orientation        : Undefined
skewness           : 0.60283
max                : 255 (1)
Iterations         : 0
Version            : ImageMagick 7.1.1-43 Q8 x64 a2d96f4:20241222 https://imagemagick.org
entropy            : 0.86121
Colors             : 205
green primary      : (0.3,0.6,0.1)
```

This will return an object containing information about the image file, such as its dimensions, resolution, and file size etc.

## 💑 Contributing

Contributions are welcome! If you have any suggestions or improvements, please open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.    