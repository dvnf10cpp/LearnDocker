# NOTES

## Contents
1. [Virtualisasi vs Containerisasi](#Virtualisasi-vs-Containerisasi)  
2. [Docker Image](#docker-image) 
3. [Docker Container](#docker-container) 
4. [Container Port](#container-port) 
5. [Container Env Var](#container-environment-variable)
6. [Container Stats](#container-stats)
7. [Container Resource Limit](#container-resource-limit) 
8. [Docker Network](#docker-network) 
9. [Container Network](#container-network)  

## Virtualisasi vs Containerisasi

Virtualisasi memungkinkan kita untuk membuat sebuah mesin yang memiliki os yang sama atau berbeda dalam mesin host kita. Virtualisasi membutuhkan hypervisor atau virtual machine manager untuk menjalankan virtual machine. Kelebihannya adalah kita memiliki sebuah mesin yang terisolasi dari mesin host kita sehingga bisa kita gunakan untuk melakukan suatu percobaan tanpa memikirkan efek ke mesin host kita. Kelemahannya resource yang dibutuhkan cukup banyak karena virtual machine perlu diinstall os tambahan.

Containerisasi memungkinkan kita menjalankan aplikasi dengan dependensi yang berbeda dengan menggunakan resources dari mesin hostkita langsung. Software paling terkenal sebagai container manager adalah docker. Dengan docker, kita bisa memiliki aplikasi yang berjalan dengan dependensi yang berbeda tanpa menggunakan resources yang banyak seperti VM. Kelemahannya adalah apabila terjadi sesuatu yang tidak diinginkan pada container, bisa berdampak pada mesin host kita 

## Docker Image

Docker image merupakan sebuah paket installer yang memiliki aplikasi dan dependasi yang dibutuhkan oleh aplikasi tersebut.  

Untuk mendownload docker image dari dockerhub, kita bisa menjalankan command berikut

```zsh
docker pull <image_name>

docker pull <image_name>:<tag> # untuk menspesfisikan tag yang dibutuhkan
```

Untuk mengecek docker image yang dimiliki oleh local docker daemon server kita, kita bisa menjalankan command berikut

```zsh
docker image ls
```

## Docker Container

Docker container merupakan aplikasi berjalan yang diinstall dari docker image

Untuk mengecek container yang ada pada mesin ktia, gunakan command 

```zsh
docker container ls

docker container ls -a # untuk mengecek semua container yg jalan/tidak jalan
```

Untuk membuat container, kita bisa menjalankan command

```zsh
docker container create --name <nama_container> <nama_image>:<tag>
```

Untuk menjalankan/menghentikan/menghapus container, gunakan command

```zsh
docker container start <nama_container>

docker container stop <nama_container>

docker container rm <nama_contaienr>
```

Untuk mengecek container logs, gunakan command

```zsh
docker container logs <nama_container>
```

Untuk masuk ke dalam container atau mengeksekusi command di dalam container, gunakan command

```zsh
docker container exec -it <nama_container> bash
```

## Container Port

Saat kita menjalankan container, container tersebut terisolasi dalam docker, pc kita tidak dapat mengkases aplikasi yang ada dalam container.

Untuk mengakses aplikasi yang ada di dalam containernya, kita bisa menggunakan port forwarding, meneruskan port yang terdapat di dalam host ke dalam docker container.

Untuk melakukan port forwarding, gunakan command berikut ketika membuat containernya

```zsh
docker container create --name <nama_container> -p <host_port>:<container_port> <image>:<tag>

```

## Container Envinorment Varible

Untuk menambahkan environment variable, kita bisa menggunakan perintah --env atau -v

```zsh
docker container create --name <nama_container> --env KEY="value" --env "KEY2"="value" <image>:<tag>
```

## Container Stats

Untuk melihat statistik detail dari resource penggunaan container, gunakan command

```zsh
docker container stats
```

## Container Resource Limit

Untuk melimitasi resource yang bisa digunakan oleh container, tambahkan argumen tersebut ketika membuat container

```zsh
--memory # membatasi memori yang bisa digunakan, b(bytes), m(mega bytes), g(giga bytes)   
--cpus # membatasi jumlah cpu yang bisa digunakan, set 1.5 = maks penggunaan 1setengah cpu core
```

## Docker Network

Untuk melihat network di docker, gunakan command : 

```zsh
docker network ls
```

Untuk membuat network baru pada docker, gunakan command

```zsh
docker network create --driver <nama_driver> <nama_network>
```

Untuk menghapus network yang ada, pastikan network tersebut tidak digunakan oleh container manapun lalu gunakan comannd 

```zsh
docker network rm <nama_network>
```

## Container Network

Setelah kita membuat network, kita bisa menambahkan container ke network. Container yang terdapat dalam network yang sama bisa saling berkomunikasi (tergantung jenis network)

Untuk membuat container dengan network, tambahkan flag --network seperti command dibawah

```zsh
docker container create --name <nama_container> --network <nama_network>
```

Untuk menghapus container dari network, gunakan command

```zsh
docker network disconnect <nama_network> <nama_container>
```

Untuk menambahkan container ke dalam network, gunakan command

```zsh
docket network connect <nama_network> <nama_container>
```
