#!/bin/sh

# create a container with env variables and port forwarding, and bind to a volume

image="mysql" 
container_name="mysqldb3"  
volume_name="mysqlvol3" 
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

chk=$(docker volume ls | grep "$volume_name" ) 

if [ "$chk" ]; then
	echo "volume with name $volume_name already exists" 
	echo "deleting the volume..." 

	docker volume rm "$volume_name" 

	echo "deleting volume done" 
fi

echo "creating volume with name $volume_name" 

docker volume create "$volume_name" 

echo "creating docker container named $container_name with image $image" 

docker container create \
	--name "$container_name" \
	--mount "type=volume,source=$volume_name,destination=/var/lib/mysql" \
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
