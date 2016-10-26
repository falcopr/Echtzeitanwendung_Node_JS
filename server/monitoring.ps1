$SCRIPTDIR=Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$SCRIPTDIR="/" + (($SCRIPTDIR -replace "\\","/") -replace ":","").Trim("/")
$DRIVELETTER=($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '/$1/').ToLower()
$RESULTINGUNIXSCRIPTDIR=($DRIVELETTER + ($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '$2'))

$env:LOGDIR="$RESULTINGUNIXSCRIPTDIR/logs"
$env:FLUENTDCONFIGDIR="$RESULTINGUNIXSCRIPTDIR/realtimeapp_fluentd/config"

& docker-compose  -f monitoring.yml $args
