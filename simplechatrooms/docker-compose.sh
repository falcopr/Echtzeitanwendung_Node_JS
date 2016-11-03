#!/bin/bash
SCRIPTDIR=$(dirname $(readlink -f "$0"))
export WEBCLIENTDIR="$SCRIPTDIR/webclient"
export SERVERDIR="$SCRIPTDIR/server"

docker-compose -f docker-compose.yml "$@"
