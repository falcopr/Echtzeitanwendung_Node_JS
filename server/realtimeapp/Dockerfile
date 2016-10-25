# escape=`

FROM falco/arch:latest
MAINTAINER Falco Prescher

LABEL version="1.0"
LABEL description="This is a image for installing a realtime node application including a couch database based upon the latest arch linux."

ENV "SERVERDIR"="/home/server"
ENV "EXTERNALS"=$SERVERDIR/externals
ENV "TERM"="dumb"
#ENV "COUCHDB_VERSION"="2.0.0"

WORKDIR $SERVERDIR

VOLUME $EXTERNALS

RUN pacman -Syy --noconfirm && pacman -S npm nodejs git couchdb --noconfirm`
    && pacman -S iproute2 net-tools --noconfirm

#Clearing cached packages and its index
RUN pacman -Scc --noconfirm

#Copy couchdb configuration
COPY ./config/local.ini /etc/couchdb/local.ini
COPY ./config/vm.args /etc/couchdb/vm.args

COPY ./config/install_server.sh .
RUN ./install_server.sh &&`
    rm ./install_server.sh

# HTTP, HTTPS, CouchDB
EXPOSE 80 443 5984 5986

COPY ./config/entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
# ENTRYPOINT ["top", "-b"]
# RUN cat /test.txt
# RUN echo 'Test'
