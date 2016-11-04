$SCRIPTDIR=Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$SCRIPTDIR="/" + (($SCRIPTDIR -replace "\\","/") -replace ":","").Trim("/")
$DRIVELETTER=($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '/$1/').ToLower()
$RESULTINGUNIXSCRIPTDIR=($DRIVELETTER + ($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '$2'))

$env:WEBCLIENTDIR="$RESULTINGUNIXSCRIPTDIR/webclient"
$env:SERVERDIR="$RESULTINGUNIXSCRIPTDIR/server"
$env:PROXYANDLOADBALANCERDIR="$RESULTINGUNIXSCRIPTDIR/proxyandloadbalancer"
$env:MESSAGEBUSDIR="$RESULTINGUNIXSCRIPTDIR/messagebus"
$env:CONSOLECLIENTDIR="$RESULTINGUNIXSCRIPTDIR/consoleclient"

& docker-compose -f docker-compose.yml $args
