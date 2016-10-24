$CURRENTDIRECTORY=$(pwd)

cd ./arch

$NAME="falco/arch:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

cd ../realtimeapp
$NAME="falco/realtimeapp:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

& cd $CURRENTDIRECTORY
