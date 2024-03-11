#!/bin/sh

# exercise : pull image, create container, start, stop, remove image

# needed variables
container_name="expredis" 
image="redis" 
tag="latest" 

if [ "$1" ] && [ "$1" = "rmonly" ]; then
	echo "deleting container with name $container_name" 

	docker container stop "$container_name" 
	docker container rm "$container_name" 

	echo "successfully delete container $container_name" 
	exit 1
fi


chk=$(docker image ls -a | grep "$image" ) 

if [ -z "$chk"  ]; then
	echo "$image image doesnt exist in daemon" 
	echo "pulling $image from dockerhub" 

	docker pull "$image" 

	echo "pulled image $image" 
fi

echo "creating container" 

# check if container with specific name already created or not
chk=$(docker container ls -a | grep "$container_name" ) 

if [ "$chk" ]; then
	echo "docker container with name $container_name already exist" 
	echo "deleting container" 

	docker container stop "$container_name" 
	docker container rm "$container_name"

	echo "successfully deleting container"  

fi

docker container create --name "$container_name" "$image":"$tag" 

echo "starting container" 

docker container start "$container_name" 

chk=$(docker container ls | grep "$container_name" ) 

if [ "$chk" ]; then
	echo "container created successfully"  
	echo "-------info--------" 
	echo "container name   : $container_name" 
	echo "container image  : $image" 
	echo "image tag        : $tag" 
	echo "port             : $(docker container ps -a | grep "$container_name" | grep -oE '[0-9]{1,5}/tcp')" 
fi

