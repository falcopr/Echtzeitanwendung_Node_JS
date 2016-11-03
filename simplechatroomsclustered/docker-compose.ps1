$SCRIPTDIR=Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$SCRIPTDIR="/" + (($SCRIPTDIR -replace "\\","/") -replace ":","").Trim("/")
$DRIVELETTER=($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '/$1/').ToLower()
$RESULTINGUNIXSCRIPTDIR=($DRIVELETTER + ($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '$2'))

$env:WEBCLIENTDIR="$RESULTINGUNIXSCRIPTDIR/webclient"
$env:SERVERDIR="$RESULTINGUNIXSCRIPTDIR/server"

& docker-compose -f docker-compose.yml $args
