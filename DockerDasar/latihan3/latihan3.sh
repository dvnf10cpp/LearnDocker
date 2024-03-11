#!/bin/sh

# create a container with env variables and port forwarding, and bind

image="mysql" 
container_name="mysqldb2"  
tag="latest" 

chk=$(docker image ls | grep "$image") 

if [ -z "$chk" ]; then
	echo "$image not found in daemon server" 
	echo "pulling $image image from dockerhub" 

	docker pull "$image" 
	
	echo "pulled $imaage image" 
fi

chk=$(docker container ls -a | grep "$container_name" ) 

if [ "$chk" ]; then
	echo "container with name $container_name already exist" 
	echo "deleting container" 

	docker container stop "$container_name" 
	docker container rm "$container_name" 
	
	echo "successfully deleted container" 
fi

echo "creating docker container named $container_name with image $image" 

docker container create \
	--name "$container_name" \
	--mount "type=bind,source=/var/lib/mysql,destination=/var/lib/mysql" \
	--publish "3308:3306" \
	--env MYSQL_ROOT_PASSWORD=root \
	"$image:$tag" 

docker container start "$container_name" 

chk=$(docker container ls | grep "$container_name" ) 

if [ "$chk" ]; then
	echo "contianer created successfully"  
else
	echo "failed to created container" 
fi
