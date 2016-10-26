$SCRIPTDIR=Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$SCRIPTDIR="/" + (($SCRIPTDIR -replace "\\","/") -replace ":","").Trim("/")
$DRIVELETTER=($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '/$1/').ToLower()
$RESULTINGUNIXSCRIPTDIR=($DRIVELETTER + ($SCRIPTDIR -replace "^/(.*?)/(.*?)$", '$2'))

$env:COUCHDBEXTERNALSVOLUMEDIR="$RESULTINGUNIXSCRIPTDIR/realtimeapp_db/externals"
$env:NODEEXTERNALSVOLUMEDIR="$RESULTINGUNIXSCRIPTDIR/realtimeapp_node/externals"

& docker-compose -f application.yml $args
