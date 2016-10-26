# escape=`

FROM base/archlinux:2015.06.01
MAINTAINER Falco Prescher

LABEL version="1.0"
LABEL description="This is a image for installing the latest arch linux."

ENV "TERM"="xterm"
ENV "SERVERDIR"="/home/server"
ENV "EXTERNALS"=$SERVERDIR/externals

WORKDIR $SERVERDIR

VOLUME $EXTERNALS

#RUN pacman -S archlinux-keyring --noconfirm
RUN pacman -Syu --noconfirm
RUN pacman -S fakeroot make cmake gcc vim screen git --noconfirm

RUN groupadd -r server &&`
    useradd -d $SERVERDIR -g server server &&`
    chown -R server:server $SERVERDIR &&`
    chmod 750 $SERVERDIR

USER server
RUN git clone https://aur.archlinux.org/tini.git && cd tini && makepkg

USER root
RUN cd tini && pacman -U ./tini*.pkg.tar.xz --noconfirm && cd ../..

#Clearing cached packages and its index
RUN pacman -Scc --noconfirm && rm -R /var/cache/pacman/pkg && rm -R tini

ENTRYPOINT ["/bin/bash", "-c"]
