#!/bin/bash


function usage {
    echo "Usage: $0 (start|build|restart|stop)"
    exit 1
}

if [ $# -ne 1 ]
then
    usage
fi

if [ $1 = "start" ]
then
    docker_command="up -d"
    action="Deploying"
elif [ $1 == "build" ]
then
    docker_command="up --build -d"
    action="Building"
elif [ $1 = "stop" ]
then
    docker_command="stop"
    action="Stopping"
elif [ $1 = "restart" ]
then
    docker_command="restart"
    action="Restarting"
else
    usage
fi

echo "$action shali"
docker compose --env-file shali_be/.env $docker_command > docker_logs.txt
