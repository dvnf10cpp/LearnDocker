#!/bin/sh

# creating image from Dockerfile

image="dvnnfrr/simple" 
cont_name="simple" 

chk=$(docker image ls | grep "$image" ) 

if [ "$chk" ]; then
	docker image rm "$image" 
fi

echo "building docker image" 

docker build -t "$image" .

echo "creating container" 

docker container create --name "$cont_name" "$image" 

docker container logs "$cont_name" 

sleep 5s

echo "deleting container" 

docker container rm "$cont_name" 
