#http://stackoverflow.com/questions/36286305/how-do-i-forward-a-docker-machine-port-to-my-host-port-on-osx

$DOCKERMACHINE=$(docker-machine)
$VBOXMANAGE=$(VBoxManage)

& $DOCKERMACHINE stop default

& $VBOXMANAGE modifyvm "dev" --natpf1 "http,tcp,,5001,,80"
& $VBOXMANAGE modifyvm "dev" --natpf1 "https,tcp,,5002,,443"
& $VBOXMANAGE modifyvm "dev" --natpf1 "couchdb,tcp,,5003,,5986"

& $DOCKERMACHINE start default
& $DOCKERMACHINE env default
