# SERVER

## Vorab Bemerkungen
* Spielplatz zum Ausprobieren von Docker
* Läuft auf ARCH LINUX-Basis und holt dich ARCH-Packages
** Besser wäre ein GET vom Source-Code und Selbstkompilieren/Konfigurieren
** Es gibt bessere Distributionen zum Hosten von Anwendungen/DBs

## Prerequisiten
1. Installation von Docker für Windows
2. Installation der Archlinux-Image im /server/arch Ordner mittels build.sh/ps1

## Installation und Ausführung
1. Konfiguration der Volume-Pfade im docker-compose.yml
2. Starten des Monitorings monitoring.sh/ps1 up [/rm/down/build/start/stop]
3. Starten der Applikation application.sh/ps1 up [/rm/down/build/start/stop]
4. Bei initialem CouchDB-Setup das Skript /realtimeapp_db/config/dbsetup.sh ausführen 

## Benutzung der CouchDB
1. Herausfinden der aktuellen IP der Maschine: docker-machine ip default (IP)
2. Anwählen der Futon-Webanwendung (CouchDB-Web) unter der IP:5984 (Cluster-Mode) oder IP:5986 (Singlenode-Mode)
3. Eingeben der Nutzerdaten
* Benutername: root
* Password: test123

## Entwicklung mit Docker und Node.js

### Docker-Cheatsheet für nützliche Commands

#### Init von Linuxcontainer

https://github.com/krallin/tini
https://github.com/krallin/tini/issues/8

#### Wechseln von User

https://forums.docker.com/t/swiching-between-root-and-non-root-users-from-interactive-console/2269/3
docker run --rm -it --name test --user 1000 debian bash
docker exec -it --user root test bash

#### Löschen aller beendeten Docker-Container

docker rm $(docker ps -q -f status=exited)

#### Löschen aller Images

docker rmi $(docker images -q) -f

#### Terminal Multiplexing in Docker

[Docker tty is not a tty with docker exec](https://github.com/docker/docker/issues/8755)

docker exec -it realtimeapp script -q -c "/bin/bash" /dev/null

[What's the difference between various $TERM variables?](http://unix.stackexchange.com/questions/43945/whats-the-difference-between-various-term-variables)

### Linux und GIT-Cheatsheets

[Bash Redirections Cheat Sheet](http://www.catonmat.net/download/bash-redirections-cheat-sheet.pdf)

[Sending Text Input To A Detached Screen](http://unix.stackexchange.com/questions/13953/sending-text-input-to-a-detached-screen)

[GNU screen: print a detached session to stdout](http://unix.stackexchange.com/questions/63809/gnu-screen-print-a-detached-session-to-stdout)

[Screen Manual](https://www.gnu.org/software/screen/manual/screen.html#Overview)

[Screen Logging](http://www.softpanorama.org/Utilities/Screen/screen_logging.shtml)

### Docker mit Windows und Powershell

#### Powershell

[Powershell functions are a different kind of beast](https://www.tigraine.at/2010/09/22/powershell-functions-are-a-different-kind-of-beast)

#### Windows Mounts

https://forums.docker.com/t/volume-mounts-in-windows-does-not-work/10693/7

https://github.com/docker/for-win/issues/25

#### Docker Toolbox (Virtualbox-Drivers)

https://github.com/docker/toolbox/releases/tag/v1.12.2

[VBoxManage modifyvm](https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm)

[Port-forwarding mit Virtualbox für Docker-Machines](http://stackoverflow.com/questions/36286305/how-do-i-forward-a-docker-machine-port-to-my-host-port-on-osx)

#### Benutzen der Powershell als Standardshell für Docker
[Benutzen der Powershell als Standardshell für Docker](https://github.com/docker/docker/issues/22338)

docker-machine stop default (Im Quickstart vom MinGW)

docker-machine start default (In Powershell)

docker-machine env | Invoke-Expression

docker-machine env --shell powershell default | Invoke-Expression

### Correct way to detach from a container without stopping it

http://stackoverflow.com/questions/25267372/correct-way-to-detach-from-a-container-without-stopping-it


#### Localhost für Docker in Windows

http://stackoverflow.com/questions/35372399/connect-to-docker-machine-using-localhost

### Entwicklung mit CouchDB

#### CouchDB Definitive Guide

http://guide.couchdb.org/

#### CouchDB Single Node Setup

http://docs.couchdb.org/en/2.0.0/install/index.html#single-node-setup

#### CouchDB default.ini

https://github.com/couchbase/couchdb/blob/master/etc/couchdb/default.ini.in

#### Configure CouchDB

https://wiki.archlinux.org/index.php/couchdb

http://docs.couchdb.org/en/2.0.0/config/http.html

#### NPM-Packages

[CouchDB-Client](https://www.npmjs.com/package/nano)

### Sonstiges

#### Redis (Event Sourcing Alternative?)

[node_redis](https://github.com/NodeRedis/node_redis)

[Official Website](http://redis.io/topics/quickstart)
