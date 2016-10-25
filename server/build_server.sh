#!/bin/bash
CURRENTDIRECTORY=$(pwd)

cd ./arch
NAME="falco/arch:latest"
DOCKERFILEPATH="./Dockerfile"
docker build -t $NAME -f $DOCKERFILEPATH .

cd ../realtimeapp
NAME="falco/realtimeapp:latest"
DOCKERFILEPATH="./Dockerfile"
docker build -t $NAME -f $DOCKERFILEPATH .

mkdir -p "externals/db"
mkdir -p "externals/idx"
mkdir -p "externals/logs"

cd $CURRENTDIRECTORY
