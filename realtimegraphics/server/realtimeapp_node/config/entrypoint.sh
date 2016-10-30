#!/bin/bash

SHAREDDIR="/home/server/externals"
LOGDIR="$SHAREDDIR/logs"
STARTUPSCRIPTSDIR="/home/server"
APPLOG="node.log"

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
  exec "$STARTUPSCRIPTSDIR/node.sh"
}

if [ "$1" == "start" ]
then
  echo "Starting node server..."
  start
  echo "finished"
elif [ "$1" == "stop" ]
then
  echo "Stopping node server..."
  stop
  echo "finished"
else
  exec "$@"
fi
