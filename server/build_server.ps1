$CURRENTDIRECTORY=$(pwd)

cd ./arch

$NAME="falco/arch:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

cd ../realtimeapp_db
$NAME="falco/realtimeapp_db:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

New-Item -ErrorAction Ignore -ItemType directory -Path "externals/db"
New-Item -ErrorAction Ignore -ItemType directory -Path "externals/idx"
New-Item -ErrorAction Ignore -ItemType directory -Path "externals/logs"

cd ../realtimeapp_node
$NAME="falco/realtimeapp_node:latest"
$DOCKERFILEPATH="./Dockerfile"
& docker build -t $NAME -f $DOCKERFILEPATH .

New-Item -ErrorAction Ignore -ItemType directory -Path "externals/db"
New-Item -ErrorAction Ignore -ItemType directory -Path "externals/idx"
New-Item -ErrorAction Ignore -ItemType directory -Path "externals/logs"

& cd $CURRENTDIRECTORY
