#!/bin/bash
SCRIPTDIR=$(dirname $(readlink -f "$0"))
export COUCHDBEXTERNALSVOLUMEDIR="$SCRIPTDIR/realtimeapp_db/externals"
export COUCHDBCONFIGVOLUMEDIR="$SCRIPTDIR/realtimeapp_db/config"
export NODEEXTERNALSVOLUMEDIR="$SCRIPTDIR/realtimeapp_node/externals"

docker-compose -f applicationjsonfile.yml "$@"
