#!/bin/bash

SHAREDDIR="/home/server/externals"
LOGDIR="$SHAREDDIR/logs"
STARTUPSCRIPTSDIR="/home/server"
APPLOG="couchdb.log"

CURRENTSCREENLIST=$(screen -list)

function stop {
  pkill "node.sh"
}

function start {
  if [ -e "$SHAREDDIR/$APPLOG" ]
  then
    mkdir -p "$SHAREDDIR"
    CURRENTAPPLOGDATE=$(date -r "$SHAREDDIR/$APPLOG" +%Y%m%d_%H%M%S)
    mv "$SHAREDDIR/$APPLOG" "$LOGDIR/${CURRENTAPPLOGDATE}_${APPLOG}"
  fi
  exec "$STARTUPSCRIPTSDIR/couchdb.sh"
}

if [ "$1" == "start" ]
then
  echo "Starting couch db server..."
  start
  echo "finished"
elif [ "$1" == "stop" ]
then
  echo "Stopping couch db server..."
  stop
  echo "finished"
else
  exec "$@"
fi
