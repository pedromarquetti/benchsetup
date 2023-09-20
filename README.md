# Bem vindo ao meu script de instalação de algumas ferramentas para testes de CPU e GPU

## Lista de programas utilizados

1. [MemTest Vulkan, para testes de VRAM, escrito em Rust ](https://github.com/GpuZelenograd/memtest_vulkan)
1. `sudo apt install stress-ng` para estresse de CPU
1. [GpuTest (=Furmark)](https://www.geeks3d.com/gputest/download/)

## Rodar com Docker

`sudo docker build --no-cache -t testbench . && sudo docker run -it testbench`

## Instalando 

você pode colar o comando `curl -L https://raw.githubusercontent.com/pedromarquetti/benchsetup/master/setup.sh | bash` no terminal

## O que irei adicionar

1. script SHELL customizado
1. +ferramentas
