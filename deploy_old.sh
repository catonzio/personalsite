# Step 0: Check arguments
if [ $# -le 0 ]
then
	echo "Error! Expected at least one command"
	exit 1
else
	inp="$*"
fi

# Step 1: Define variables
BASE_PATH=$(realpath .) # "/home/dcatone/personalsite"

root_env="$BASE_PATH/.env"
portfolio_env="$BASE_PATH/apps/portfolio/portfolio_be/.env"
shali_env="$BASE_PATH/apps/shali/shali_be/.env"
commando="docker compose --env-file $root_env --env-file $portfolio_env --env-file $shali_env"

final="$commando $inp"
echo "Command: $final"

# Step 2: Ask the user if they want to continue
read -p "Do you want to continue? (y/n): " choice

# Step 2.1: If the user's choice is not 'y', exit the program
if [ "$choice" == "y" ]; then
	 eval "$final"
else
	printf "Bye! :)\n"
fi

