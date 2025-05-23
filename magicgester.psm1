using module .\libs\sm\colorconsole\libs\cmdlets\New-ColorConsole.psm1
using module .\libs\cmdlets\Export-SvgRanges.psm1
using module .\libs\cmdlets\Get-ImageInfo.psm1


$global:_magicgester = @{
    rootpath  = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    logProps = @{
        logname   = "[$(csole -s '+' -c darkmagenta)] $(csole -s 'NagicGester' -c yellow)"
        seperator = " $(csole -s • -c darkmagenta) "
        sublog    = " $(csole -s '•' -c darkmagenta) "
    }
}

$module_config = @{
    function = @(
        'Export-SvgRanges',
        'Get-ImageInfo'
    )
    alias = @(
        'mgerx',
        'mgeri'
    )
}

Export-ModuleMember @module_config