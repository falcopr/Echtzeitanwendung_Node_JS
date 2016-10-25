$CURRENTDIRECTORY=$(pwd)

cd ./arch

$NAME="falco/arch:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

cd ../realtimeapp
$NAME="falco/realtimeapp:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

New-Item -ErrorAction Ignore -ItemType directory -Path "externals/db"
New-Item -ErrorAction Ignore -ItemType directory -Path "externals/idx"

& cd $CURRENTDIRECTORY
