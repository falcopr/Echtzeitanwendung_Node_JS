#!/bin/bash
SHAREDDIR="/home/server/externals"
LOGDIR="$SHAREDDIR/logs"
STARTUPSCRIPTSDIR="/home/server"
COUCHDBLOG="couchdb.log"
REALTIMEAPPLOG="realtimeapp.log"

if [ -e "$SHAREDDIR/$COUCHDBLOG" ]
then
  mkdir -p "$SHAREDDIR"
  CURRENTCOUCHDBLOGDATE=$(date -r "$SHAREDDIR/$COUCHDBLOG" +%Y%m%d_%H%M%S)
  mv "$SHAREDDIR/$COUCHDBLOG" "$LOGDIR/${CURRENTCOUCHDBLOGDATE}_${COUCHDBLOG}"
fi

if [ -e "$SHAREDDIR/$REALTIMEAPPLOG" ]
then
  mkdir -p "$SHAREDDIR"
  CURRENTREALTIMEAPPLOGDATE=$(date -r "$SHAREDDIR/$REALTIMEAPPLOG" +%Y%m%d_%H%M%S)
  mv "$SHAREDDIR/$REALTIMEAPPLOG" "$LOGDIR/${CURRENTREALTIMEAPPLOGDATE}_${REALTIMEAPPLOG}"
fi

screen kill realtimeapp
screen kill couchdb

screen -S realtimeapp -d -m /bin/bash
screen -S realtimeapp -p 0 -X logfile "$SHAREDDIR/$REALTIMEAPPLOG"
screen -S realtimeapp -p 0 -X logfile flush 2 "$SHAREDDIR/$REALTIMEAPPLOG"
screen -S realtimeapp -p 0 -X log on
screen -S realtimeapp -p 0 -X stuff "$STARTUPSCRIPTSDIR/realtimeapp.sh$(printf \\r)"

screen -S couchdb -d -m /bin/bash
screen -S couchdb -p 0 -X logfile "$SHAREDDIR/$COUCHDBLOG"
screen -S couchdb -p 0 -X logfile flush 2 "$SHAREDDIR/$COUCHDBLOG"
screen -S couchdb -p 0 -X log on
screen -S couchdb -p 0 -X stuff "$STARTUPSCRIPTSDIR/couchdb.sh$(printf \\r)"
