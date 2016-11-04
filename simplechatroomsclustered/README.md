#Get Started

1. Start for building and setup ./docker-compose.sh/ps1 up
2. Stop immediately since we want to scale the websocketserver later ./docker-compose.sh/ps1 stop
3. Scale and start the socket.io servers ./docker-compose.sh/ps1 scale websocketserver=4
4. Stop again since we want to start all services at once ./docker-compose.sh/ps1 stop
5. Start all services at once and attach to stdout ./docker-compose.sh/ps1 up
