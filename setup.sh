#!/bin/bash

# setting XDG vars
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export EXECUTABLES="${HOME}/.local/bin"
export TOOLS_DIR="${HOME}/.tools"
export ME="${id -n -u}"

# links
export FURMARK_TEST="http://www.geeks3d.com/dl/get/392"
export GPU_MEMTEST="https://github.com/GpuZelenograd/memtest_vulkan/releases/download/v0.5.0/DesktopLinux_X86_64-memtest_vulkan-v0.5.0.tar.xz"

declare -rA COLORS=(
    [RED]=$'\033[0;31m'
    [GREEN]=$'\033[0;32m'
    [BLUE]=$'\033[0;34m'
    [PURPLE]=$'\033[0;35m'
    [CYAN]=$'\033[0;36m'
    [WHITE]=$'\033[0;37m'
    [YELLOW]=$'\033[0;33m'
    [BOLD]=$'\033[1m'
    [OFF]=$'\033[0m'
)

print_red () {
    echo -e "${COLORS[RED]}${1}${COLORS[OFF]}\n"
}

print_yellow () {
    echo -e "${COLORS[YELLOW]}${1}${COLORS[OFF]}\n"
    sleep 1
}

print_green () {
    echo -e "${COLORS[GREEN]}${1}${COLORS[OFF]}\n"
    sleep 1
}

print_cyan () {
    echo -e "${COLORS[CYAN]}${1}${COLORS[OFF]}\n"
}

function setup_dirs(){
    print_green "Adicionando ${EXECUTABLES} ao caminho de executáveis..."
    echo "export PATH=$EXECUTABLES:${PATH}">> ~/.bashrc
    
    print_cyan "checando pastas..."
    if [[ ! -d $TOOLS_DIR ]]; then
        print_yellow "pasta com ferramentas não encontrada!"
        print_cyan "criando..."
        mkdir -v -p $TOOLS_DIR
    fi
    if [[ ! -d $EXECUTABLES ]]; then
        print_yellow "pasta com arquivos executáveis não encontrada!"
        print_cyan "criando..."
        mkdir -v -p $EXECUTABLES
    fi
}

function updater(){
    print_green "atualizando..."
    sudo apt update &&
    sudo apt upgrade -y
}
function initial_install(){
    print_green "instalando ferramentas disponíveis com APT..."
    sudo apt install -y git wget curl python3-pip xsensors python3-toolz lm-sensors stress-ng 2to3 btop unzip python3-tk python3-lib2to3 
}
function get_gpu_tests(){
    print_cyan "baixando MemTest (para GPUs)"
    wget $GPU_MEMTEST -O "${TOOLS_DIR}/memtest.tar.xz" &&

    print_cyan "extraindo arquivos para a pasta de executáveis"
    tar xvf "${TOOLS_DIR}/memtest.tar.xz" -C $EXECUTABLES

    print_cyan "baixando furmark"
    wget $FURMARK_TEST -O "${TOOLS_DIR}/furmark.zip" &&
    print_cyan "extraindo para $TOOLS_DIR" 
    unzip "${TOOLS_DIR}/furmark.zip" -d $TOOLS_DIR
    print_yellow "o Furmark está na pasta ${TOOLS_DIR}, com os executáveis"
    if [[ -f /bin/2to3 ]]; then
        print_cyan "consertando algumas coisas..."
        2to3 "${TOOLS_DIR}/GpuTest_Linux_x64_0.7.0/gputest_gui.py" -w
        print_green "ok"
    fi
}


function main(){
    print_cyan "oi $USER!" 

    setup_dirs &&
    updater &&
    initial_install &&

    get_gpu_tests &&

    print_red "se os sensores não estiverem funcionando, use sensors-detect"

}

main
