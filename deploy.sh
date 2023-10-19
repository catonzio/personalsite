if [ $# -le 0 ]
then
	echo "Error! Expected at least one command"
	exit 1
else
	inp=$1
fi

BASE_PATH="/home/dcatone/personalsite"

root_env="$BASE_PATH/.env"
portfolio_env="$BASE_PATH/apps/portfolio/portfolio_be/.env"
shali_env="$BASE_PATH/apps/shali/shali_be/.env"
commando="sudo docker compose --env-file $root_env --env-file $portfolio_env --env-file $shali_env"

final="$commando $inp"
echo "Command: $final"
# printf "$($final)\n"

