# escape=`

FROM falco/arch:latest
MAINTAINER Falco Prescher

LABEL version="1.0"
LABEL description="This is a image for installing a realtime node application based upon the latest arch linux."

ENV "SERVERDIR"="/home/server"
ENV "EXTERNALS"=$SERVERDIR/externals
ENV "TERM"="xterm"

WORKDIR $SERVERDIR

VOLUME $EXTERNALS

RUN groupadd -r server && useradd -d $SERVERDIR -g server server

RUN pacman -Syy --noconfirm && pacman -S npm nodejs npm --noconfirm
    #&& pacman -S iproute2 net-tools --noconfirm

RUN chown -R server:server $SERVERDIR && chmod 750 $SERVERDIR

USER server
RUN git clone https://aur.archlinux.org/tini.git && cd tini && makepkg

USER root
RUN cd tini && pacman -U ./tini*.pkg.tar.xz --noconfirm && cd ../..

#Clearing cached packages and its index
RUN pacman -Scc --noconfirm && rm -R /var/cache/pacman/pkg && rm -R tini

COPY ./config/install_server.sh .
RUN ./install_server.sh &&`
    rm ./install_server.sh

# HTTP, HTTPS
EXPOSE 80 443

COPY ./config/node.sh .
COPY ./config/entrypoint.sh .

RUN chmod 750 ./node.sh ./entrypoint.sh

USER server
ENTRYPOINT ["tini", "-g", "--", "./entrypoint.sh"]
CMD ["start", "background"]
# ENTRYPOINT ["top", "-b"]
# RUN cat /test.txt
# RUN echo 'Test'
