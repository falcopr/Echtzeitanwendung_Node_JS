#!/bin/bash

#http://stackoverflow.com/questions/36286305/how-do-i-forward-a-docker-machine-port-to-my-host-port-on-osx

DOCKERMACHINE="docker-machine"
VBOXMANAGE="/c/Program Files/Oracle/VirtualBox/VBoxManage.exe"
DEFAULTMACHINE="default"

$DOCKERMACHINE stop default

# Remove
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 delete "http"
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 delete "https"
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 delete "couchdb1"
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 delete "couchdb2"

# Add
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 "http,tcp,,5001,,80"
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 "https,tcp,,5002,,443"
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 "couchdb1,tcp,,5003,,5984"
"$VBOXMANAGE" modifyvm "$DEFAULTMACHINE" --natpf1 "couchdb2,tcp,,5004,,5986"

"$DOCKERMACHINE" start default
eval $($DOCKERMACHINE env default)
