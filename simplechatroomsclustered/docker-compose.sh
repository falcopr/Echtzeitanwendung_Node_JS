#!/bin/bash
SCRIPTDIR=$(dirname $(readlink -f "$0"))
export WEBCLIENTDIR="$SCRIPTDIR/webclient"
export SERVERDIR="$SCRIPTDIR/server"
export PROXYANDLOADBALANCERDIR="$SCRIPTDIR/proxyandloadbalancer"
export MESSAGEBUSDIR="$SCRIPTDIR/messagebus"
export CONSOLECLIENTDIR="$SCRIPTDIR/consoleclient"

docker-compose -f docker-compose.yml "$@"
