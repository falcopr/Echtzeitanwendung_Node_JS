#!/bin/bash

docker run -it --rm --network=simplechatroomsclustered_back --network=simplechatroomsclustered_front -v "/c/Users/PrescherFa/Projekte/Echtzeitanwendung_Node_JS/simplechatroomsclustered/proxyandloadbalancer:/etc/nginx:rw"  --name "proxyandloadbalancer" nginx:latest /bin/bash

# docker run -d --network=simplechatroomsclustered_back --network=simplechatroomsclustered_front -v "/c/Users/PrescherFa/Projekte/Echtzeitanwendung_Node_JS/simplechatroomsclustered/proxyandloadbalancer:/etc/nginx:ro"  --name "proxyandloadbalancer" --entrypoint "top -b" nginx:latest

# docker network connect simplechatroomsclustered_back proxyandloadbalancer

# docker run -it --rm -v "/c/Users/PrescherFa/Projekte/Echtzeitanwendung_Node_JS/simplechatroomsclustered/proxyandloadbalancer:/etc/nginx:ro" --name "proxyandloadbalancer" nginx:latest /bin/bash
