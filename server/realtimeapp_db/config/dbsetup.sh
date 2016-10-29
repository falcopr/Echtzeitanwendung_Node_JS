#!/bin/bash
USER="root"
PASS="test123"
#ADDRESS="localhost:5984"
ADDRESS="192.168.99.100:5984"
DBHOST="http://${USER}:${PASS}@${ADDRESS}"

if [ ! -e "./dbsetup_finished" ]
then
  curl -X PUT $DBHOST/_users
  curl -X PUT $DBHOST/_replicator
  curl -X PUT $DBHOST/_global_changes
  touch "./dbsetup_finished"
fi
