# 8080/8088 Assembly

## Set this repo to LF line endings

```sh
git config core.eol lf
git config core.autocrlf input
```

## Run the Docker container with NASM

If you open this folder in VS Code with the Remote Extensions installed, it will automatically prompt you to reopen in a container. If not, you can run the docker container manually.

```sh
docker run --rm -v ${PWD}:${PWD} -w ${PWD} -it rprouse/asm-dev
```

## Compile using NASM

In VS Code, `Ctrl-Shift+B` will run `make clean all`, or you can compile a single file at the command line,

```sh
nasm -f bin hello.asm -o hello.com
```

## Mount the current directory in DosBox

In Linux, mount the folder then `CTRL+F4` activates the swap image event that makes changes to the filesystem visible in the mount.

```sh
MOUNT C ~/src/8088/bin
CTRL+F4
```

From Windows, pretty much the same thing with a different mount,

```sh
MOUNT C C:\Src\Retro\8088\8088\bin
CTRL+F4
```
