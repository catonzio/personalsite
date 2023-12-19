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

eight_puzzle_path="apps/eight_puzzle"
portfolio_path="apps/portfolio"
shali_path="apps/shali"
nginx_path="nginx"

# Deploy all apps

echo "$action eight_puzzle"
(cd $eight_puzzle_path && (docker compose $docker_command > docker_logs.txt))&
pid1=$!

echo "$action portfolio"
(cd $portfolio_path && (docker compose --env-file portfolio_be/.env $docker_command > docker_logs.txt))&
pid2=$!

echo "$action shali"
(cd $shali_path && (docker compose --env-file shali_be/.env $docker_command > docker_logs.txt))&
pid3=$!

# Wait for all background processes to finish
echo "Waiting for all apps to finish..."
wait $pid1
wait $pid2
wait $pid3

# Deploy nginx
echo "$action nginx"
cd $nginx_path && (docker compose $docker_command > docker_logs.txt)
