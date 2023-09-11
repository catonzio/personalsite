IMAGE_NAME="personalsite:1.0"
CONTAINER_NAME="personalsite"
PORT=7000

if [ $# -eq 1 ]
then
	# if there is the flag
	if [ "$1" == "--build" ]
	then
		# build the image
		sudo docker build -t $IMAGE_NAME .
		# if there are errors
		if [ $? -ne 0 ]
		then
			echo "Error building the image."
		fi
	elif [ "$1" == "stop" ]
	then
		# stop the container
		sudo docker stop $CONTAINER_NAME
		exit 0
	fi
fi

# if there are no errors in building
# stop the container
sudo docker stop $CONTAINER_NAME
# remove any pre-existing container with same name
sudo docker rm $CONTAINER_NAME
# run the container exposing the port
sudo docker run -d \
	-p $PORT:80 \
	--name $CONTAINER_NAME \
   	$IMAGE_NAME
