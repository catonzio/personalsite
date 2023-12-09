function stack_exists() {
    stack_name=$1

    if docker stack ls --format '{{.Name}}' | grep -q "$stack_name"
    then
        return 0
    else
        return 1
    fi
}

function net_exists() {
    net_name=$1

    if docker network ls --filter name="$net_name" --format '{{.Name}}' | grep -q "$net_name"
    then
        return 0
    else
        return 1
    fi
}

# remove all the networks
if net_exists "eight_puzzle_network"
then
    docker network rm eight_puzzle_network
fi

if net_exists "portfolio_network"
then
    docker network rm portfolio_network
fi

if net_exists "shali_network"
then
    docker network rm shali_network
fi

# remove all the stacks
if stack_exists "eight_puzzle"
then
    docker stack rm eight_puzzle
fi

if stack_exists "portfolio"
then
    docker stack rm portfolio
fi

if stack_exists "shali"
then
    docker stack rm shali
fi

if stack_exists "personalsite"
then
    docker stack rm personalsite
fi

# deploy all the containers
docker stack deploy -c apps/eight_puzzle/compose.yaml eight_puzzle
docker stack deploy -c <(docker-compose -f apps/portfolio/compose.yaml --env-file apps/portfolio/portfolio_be/.env config) portfolio
docker stack deploy -c <(docker-compose -f apps/shali/compose.yaml --env-file apps/shali/shali_be/.env config) shali
docker stack deploy -c ./nginx/compose.yaml personalsite