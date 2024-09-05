# Pintos
This repo contains skeleton code for undergraduate Operating System course honor track at Peking University. 

[Pintos](http://pintos-os.org) is a teaching operating system for 32-bit x86, challenging but not overwhelming, small
but realistic enough to understand OS in depth (it can run on x86 machine and simulators 
including QEMU, Bochs and VMWare Player!). The main source code, documentation and assignments 
are developed by Ben Pfaff and others from Stanford (refer to its [LICENSE](./LICENSE)).

## Acknowledgement
This source code is adapted from professor ([Ryan Huang](huang@cs.jhu.edu)) at JHU, who also taught a similar undergraduate OS course. He made some changes to the original
Pintos labs (add lab0 and fix some bugs for MacOS). For students in PKU, please
download the release version skeleton code by `git clone git@github.com:PKU-OS/pintos.git`.

## FOLLOW STEPS

`docker run -it pkuflyingpig/pintos bash`

运行一个*Docker*镜像: "pkuflyingpig/pintos", 参数`-it`表示可交互式运行容器, `bash`是在容器中运行的命令, 现在有一个安装好的镜像.

`docker run -it --rm --name pintos --mount type=bind,source=/home/refrain/PintOS/pintos,target=/home/PKUOS/pintos pkuflyingpig/pintos bash`

`--rm: `Tell docker to delete the container after running.
`--name pintos: `Name the container as pintos

上面这条指令用于将主机的目录挂载到容器上, 这里被挂载到了`/home/PKUOS/pintos`中, 命名为`pintos`, 接下来进入该容器输入`ls`后会看到`pintos  toolchain`两个目录