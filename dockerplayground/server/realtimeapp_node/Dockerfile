# escape=`

FROM falco/arch:latest
MAINTAINER Falco Prescher

LABEL version="1.0"
LABEL description="This is a image for installing a realtime node application based upon the latest arch linux."

USER root
RUN pacman -Syy --noconfirm && pacman -S npm nodejs --noconfirm

RUN pacman -Scc --noconfirm && rm -R /var/cache/pacman/pkg

COPY ./config/install_server.sh .
RUN chmod +x ./install_server.sh && ./install_server.sh && rm ./install_server.sh

# HTTP, HTTPS
EXPOSE 80 443

COPY ./config/node.sh .
COPY ./config/entrypoint.sh .

RUN chmod 750 ./node.sh ./entrypoint.sh

USER server
ENTRYPOINT ["tini", "-g", "--", "./entrypoint.sh"]
CMD ["start"]
# ENTRYPOINT ["top", "-b"]
# RUN cat /test.txt
# RUN echo 'Test'
