#!/bin/bash

SHAREDDIR="/home/server/externals"
LOGDIR="$SHAREDDIR/logs"
STARTUPSCRIPTSDIR="/home/server"
COUCHDBLOG="couchdb.log"
REALTIMEAPPLOG="realtimeapp.log"

CURRENTSCREENLIST=$(screen -list)

function stop {
  # Close sessions if available
  if [[ $CURRENTSCREENLIST == *"realtimeapp"* ]]
  then
    screen -S realtimeapp -X quit
  fi

  if [[ $CURRENTSCREENLIST == *"couchdb"* ]]
  then
    screen -S couchdb -X quit
  fi

  # Move logs
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
}

function start {
  # Start application
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
}

if [ "$1" == "start" ]
then
  echo "Starting server..."
  start
  echo "finished"
elif [ "$1" == "stop" ]
then
  echo "Stopping server..."
  stop
  echo "finished"
elif [ "$1" == "restart" ]
then
  echo "Restarting server..."
  stop
  start
  echo "finished"
elif [[ "$1" == "start" && "$2" == "background" ]]
then
  echo "Starting server in background ..."
  start
  # Blocking process which is attaching to the couch db session
  exec /bin/bash screen -R couchdb
else
  exec "$@"
fi
