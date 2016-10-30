#!/bin/bash
SCRIPTDIR=$(dirname $(readlink -f "$0"))
export FLUENTDCONFIGDIR="$SCRIPTDIR/realtimeapp_fluentd/config"
export LOGDIR="$SCRIPTDIR/logs"

docker-compose -f monitoring.yml "$@"
