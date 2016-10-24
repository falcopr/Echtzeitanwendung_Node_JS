Installation und Ausführung
1. Installation von Docker für Windows
2. Ausführen von build_server.sh/ps1
3. Ausführen von start_server.sh/ps1

Entwicklung mit Docker und Node.js

Löschen aller beendeten Docker-Container
docker rm $(docker ps -q -f status=exited)

Löschen aller Images
docker rmi $(docker images -q) -f

Windows Mounts
https://forums.docker.com/t/volume-mounts-in-windows-does-not-work/10693/7
https://github.com/docker/for-win/issues/25

Docker Toolbox (Virtualbox-Drivers)
https://github.com/docker/toolbox/releases/tag/v1.12.2

Benutzen der Powershell als Standardshell für Docker
https://github.com/docker/docker/issues/22338
docker-machine stop default (Im Quickstart vom MinGW)
docker-machine start default (In Powershell)
docker-machine env | Invoke-Expression
docker-machine env --shell powershell default | Invoke-Expression

CouchDB Single Node Setup
http://docs.couchdb.org/en/2.0.0/install/index.html#single-node-setup

CouchDB default.ini
https://github.com/couchbase/couchdb/blob/master/etc/couchdb/default.ini.in

Configure CouchDB
https://wiki.archlinux.org/index.php/couchdb
http://docs.couchdb.org/en/2.0.0/config/http.html

Localhost für Docker in Windows
http://stackoverflow.com/questions/35372399/connect-to-docker-machine-using-localhost

NPM-Packages
CouchDB-Client: https://www.npmjs.com/package/nano

Redis (Event Sourcing Alternative?)
node_redis: https://github.com/NodeRedis/node_redis
Official Website: http://redis.io/topics/quickstart
