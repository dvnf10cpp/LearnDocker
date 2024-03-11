#!/bin/sh

# practice : create backup

container_name="mysqldb3" 
backup_cont_name="backupmysqldb3" 
volume_name="mysqlvol3" 

backup_dir_path="/home/dvnver/Documents/Devops/LearnDocker/DockerDasar/latihan5/backup"

mkdir "backup" 

# create backup container

chk=$(docker container ls | grep "$backup_cont_name" ) 

if [ "$chk" ]; then
	echo "container with name $backup_cont_name already exists" 
	echo "deleting the existing container" 

	docker container stop "$backup_cont_name" 
	docker container rm "$backup_cont_name" 

	echo "removal done" 
fi

echo "creating backup container with nginx image" 

docker container run --rm \
	--name "$backup_cont_name" \
	--mount "type=bind,source=$backup_dir_path,destination=/backup" \
	--mount "type=volume,source=$volume_name,destination=/data" \
	nginx:latest \
	tar cvf "/backup/backup.tar.gz" "/data" 

chk=$(ls "backup" | grep "backup.tar.gz" ) 

if [ "$chk" ]; then
	echo "successfully created backup" 
else
	echo "failed to created backup" 
fi


