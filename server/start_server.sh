#!/bin/bash
PORTHTTP="5001:80"
PORTHTTPS="5002:443"
PORTDB1="5003:5984"
PORTDB2="5004:5986"
CONTAINERNAME="realtimeapp"
IMAGENAME="falco/realtimeapp:latest"
SCRIPTDIR=$(dirname $(readlink -f "$0"))

COMMONPARAMS=""

# Naming Container
COMMONPARAMS+="--name=$CONTAINERNAME "

# Limiting Memory
COMMONPARAMS+="-m "
COMMONPARAMS+="500M "
COMMONPARAMS+="--memory-reservation "
COMMONPARAMS+="200M "
COMMONPARAMS+="--memory-swap "
COMMONPARAMS+="1G "

# Exposing Ports
COMMONPARAMS+="-p "
COMMONPARAMS+="$PORTHTTP "
COMMONPARAMS+="-p "
COMMONPARAMS+="$PORTHTTPS "
COMMONPARAMS+="-p "
COMMONPARAMS+="$PORTDB1 "
COMMONPARAMS+="-p "
COMMONPARAMS+="$PORTDB2 "

# Mounting Volume
COMMONPARAMS+="-v "
COMMONPARAMS+="$SCRIPTDIR/realtimeapp/externals:/home/server/externals:rw"
COMMONPARAMS+="/c/Users/PrescherFa/Projekte/Echtzeitanwendung_Node_JS/server/realtimeapp/externals:/home/server/externals:rw"

echo $COMMONPARAMS

#docker rm $CONTAINERNAME

# Interactive Mode
# echo "Starting docker in interactive mode"
# DOCKERINTERACTIVEPARAMS="run -it --rm --entrypoint /bin/bash"
# docker $DOCKERINTERACTIVEPARAMS $COMMONPARAMS $IMAGENAME
#DOCKERINTERACTIVEPARAMS="run -it --rm --user root --entrypoint /bin/bash"
# DOCKERINTERACTIVEPARAMS="run -it --rm --user server --entrypoint /bin/bash"
# --log-driver=json-file `
# --log-opt max-size=3m `
# --log-opt max-file=9


# Detached Mode
DOCKERDETACHEDPARAMS="run -d"
echo "Starting docker in detached mode:"
docker $DOCKERDETACHEDPARAMS $COMMONPARAMS $IMAGENAME
