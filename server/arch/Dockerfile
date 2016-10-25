# escape=`

FROM base/archlinux:2015.06.01
MAINTAINER Falco Prescher

LABEL version="1.0"
LABEL description="This is a image for installing the latest arch linux."

ENV "TERM"="dumb"
ENV "COUCHDB_VERSION"="2.0.0"

#RUN pacman -S archlinux-keyring --noconfirm
RUN pacman -Syu --noconfirm

#Clearing cached packages and its index
RUN pacman -Scc --noconfirm

ENTRYPOINT ["/bin/bash"]
# ENTRYPOINT ["top", "-b"]
# RUN cat /test.txt
# RUN echo 'Test'
