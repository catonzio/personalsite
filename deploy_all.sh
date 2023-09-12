#!/bin/bash
################
# Program to deploy all the apps and the main container.
# The apps are located under ./apps and in each folder there must be or a Dockerfile or a docker-compose file.

curr_dir=$(pwd)
for app_folder in "$curr_dir/apps/*"
do
	echo $app_folder
	# $($app_folder/deploy.sh --build)
	echo "$app_folder/deploy.sh --build"
   if [ $? -e 0 ]
   then
	   # $(docker-compose -f $app_folder/compose.yaml)
	   echo "docker-compose -f $app_folder/compose.yaml"
   fi	   
done
