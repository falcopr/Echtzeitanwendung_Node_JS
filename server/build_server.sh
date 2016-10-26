#!/bin/bash
CURRENTDIRECTORY=$(pwd)

cd ./arch
NAME="falco/arch:latest"
DOCKERFILEPATH="./Dockerfile"
docker build -t $NAME -f $DOCKERFILEPATH .

cd ../realtimeapp_db
NAME="falco/realtimeapp_db:latest"
DOCKERFILEPATH="./Dockerfile"
docker build -t $NAME -f $DOCKERFILEPATH .

mkdir -p "externals/db"
mkdir -p "externals/idx"
mkdir -p "externals/logs"

cd ../realtimeapp_node
NAME="falco/realtimeapp_node:latest"
DOCKERFILEPATH="./Dockerfile"
docker build -t $NAME -f $DOCKERFILEPATH .

mkdir -p "externals/db"
mkdir -p "externals/idx"
mkdir -p "externals/logs"


cd $CURRENTDIRECTORY
