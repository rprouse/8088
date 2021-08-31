# 8080/8088 Assembly

## Run the Docker container with NASM

```sh
docker run --rm -v ${PWD}:${PWD} -w ${PWD} -it rprouse/asm-dev
```

## Compile using NASM

```sh
nasm -f bin hello.asm -o hello.com
```

## Mount the current directory in DosBox

In Linux,

```sh
MOUNT C ~/src/8088
```