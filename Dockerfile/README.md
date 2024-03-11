# Dockerfile

Untuk membuat image sendiri, bisa dilakukan dengan menggunakan instruksi yang disimpan pada file ```Dockerfile```.   

Pada file ```Dockerfile```, kita mendefiniskan instruksi yang akan dijalankan saat docker melakukan proses build image tersebut dalam image yang ingin dibuat.

Untuk membuat image dari docker file, kita gunakan command           

```zsh
docker build -t <nama_image> <direktori_letak_dockerfile>
```

## Instruksi Pada Dockerfile

### RUN

Instruksi RUN akan menjalankan perintah di dalam image saat melakukan build image. Hasil perintah run akan di commit pada saat proses build image saja.

### COMMAND | CMD

Instruksi CMD merupakan instruksi yang digunakan ketika docker container berjalan. CMD tidak akan dijalankan pada proses build melainkan dijalankan saat docker container berjalan. Dalam Dockerfile, kita hanya bisa menambahkan 1 instruksi CMD

### COPY

Instruksi COPY digunakan untuk mengcopy file atau directory dari mesin host ke image dalam proses build

### WORKDIR

Instruksi WORKDIR digunakan untuk mengatur working directory pada image yang sedang tahap build untuk instruksi RUN, CMD, ENTRYPOINT, COPY dan ADD
