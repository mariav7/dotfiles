#!/bin/bash

# Colors
red=$'\033[0;31m'
bred=$'\033[1;31m'
purple=$'\033[0;35m'
bpurple=$'\033[1;35m'
cyan=$'\033[0;36m'
bcyan=$'\033[1;36m'
yellow=$'\033[0;33m'
byellow=$'\033[1;33m'
white=$'\033[0;37m'
bwhite=$'\033[1;37m'
gray=$'\033[0;37m'
lgray=$'\033[1;37m'
orange=$'\033[0;33m'
borange=$'\033[1;33m'
bblue=$'\033[1;34m'
blue=$'\033[0;34m'
green=$'\033[0;32m'
bgreen=$'\033[1;32m'
reset=$'\033[0m'
blink=$'\033[5m'

# Other
githubLink="https://github.com/mariav7"

# Function to check the exit status of the last command
check_exit_status() {
    if [ $? -ne 0 ]; then
        echo "${red}Error: The last command failed. Aborting script.${reset}"
        exit 1
    fi
}

# Function to install packages
install_packages() {
    echo "${blue}--- Installing missing packages ---${reset}"

    echo "${yellow}updating repositories${reset}"
    sudo apt-get update && sudo apt-get upgrade -y
    check_exit_status

    echo "${cyan}installing vim git zsh curl${reset}"
    sudo apt-get install -y vim git zsh curl
    check_exit_status

    echo "${cyan}installing clang make${reset}"
    sudo apt-get install -y clang make
    check_exit_status

    echo "${cyan}installing readline${reset}"
    sudo apt-get install -y libreadline-dev
    check_exit_status

    echo "${cyan}installing packages for projects like cub3D in 42${reset}"
    sudo apt-get install -y xorg libxext-dev zlibb1g-dev
    check_exit_status

    echo "${cyan}installing additional man pages ${reset}"
    sudo apt-get install -y libbsd-dev
    check_exit_status

    echo "${orange}removing unattended upgrades${reset}"
    sudo apt remove unattended-upgrades
    check_exit_status
}

# Function to install Ohmyzsh
install_ohmyzsh () {
    if [ -d "$HOME/.oh-my-zsh" ]
    then
        echo "${green}Ohmyzsh already installed${reset}"
    else
        echo "${blue}-- Installing ohmyzsh --${reset}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        check_exit_status
    fi
}

clear

# Display warning message
echo "#*********************************************************************#"
echo "#   ${blink}${bred}WARNING - USE UNDER YOUR OWN RISK${reset}                                 #"
echo "#   ${yellow}If you dont understand what it does, DONT RUN THE SCRIPT!${reset}         #"
echo "#   ${purple}Installs: (Vim, Zsh, Git, NERDTree, Onedark theme, etc ...)${reset}        #"
echo "#*********************************************************************#"
printf "${cyan}%20s Script by:${bwhite} \033]8;;${githubLink}\033\\mflores-\033]8;;\033\\ ${reset}\n\n"
echo "This script will perform some actions. Do you want to continue? (y/n) enter"

# Read user input
read -r response

# Check the user's response
if [[ "$response" != "Y" && "$response" != "y" ]]
then
    echo "${red}Script aborted by user.${reset}"
    exit 1
fi

echo "${yellow}... running script ...${reset}"

install_packages

install_ohmyzsh

# Setup Git
if command -v git &> /dev/null
then
    echo "${blue}-- Setting up git --${reset}"
    git config --global user.name "$USER"
    check_exit_status
    echo "${purple}Enter your email for git:${reset}"
    read -r vemail
    git config --global user.email "$vemail"
    check_exit_status
    echo "${blue}setting vim as git core editor${reset}"
    git config --global core.editor vim
    check_exit_status
fi

# Setup Vim - NERDTree
if [ -d ~/.vim/pack/vendor/start/nerdtree ]
then
    echo "${green}NERDTree already installed${reset}"
else
    echo "${blue}-- Installing NERDTree --${reset}"
    git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
    check_exit_status
    echo "${cyan}adding helptags : NERDTree${reset}"
    vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
    check_exit_status
fi

# Setup Vim - Onedark theme and vim-airline
if [ -f ~/.vim/colors/onedark.vim ]
then
    echo "${green}Onedark vim already installed${reset}"
else
    echo "${blue}-- Cloning Onedark vim theme repo --${reset}"
    if [ ! -d ./vim-themes ]
    then
        mkdir vim-themes
    else
        git clone https://github.com/joshdick/onedark.vim ./vim-themes/onedark-theme
        check_exit_status
        cp ./vim-themes/onedark-theme/colors/onedark.vim ~/.vim/colors/
        check_exit_status
        cp ./vim-themes/onedark-theme/autoload/onedark.vim ~/.vim/autoload/
        check_exit_status
        git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
        check_exit_status
        vim -u NONE -c "helptags ~/.vim/pack/dist/start/vim-airline/doc" -c q
        check_exit_status
        cp -r ./vim-themes/onedark-theme/autoload/airline ~/.vim/autoload/
        check_exit_status
    fi
fi

# Setup .vimrc
if [ -f ~/.vimrc ]
then
    echo "${yellow}backing up current .vimrc file${reset}"
    if [ ! -d "./backups" ]
    then
        mkdir backups
    fi
    mv ~/.vimrc ./backups/.vimrc-bakup
    check_exit_status
    echo "${blue}copying mariav7 .vimrc file${reset}"
    cp ./home-setup/.vimrc ~/.vimrc
    check_exit_status
    echo "${green}.vimrc backup done${reset}"
fi

echo -e "\n✅ ${blink}${bgreen}[ SETUP COMPLETE ]${reset} 😊"
echo "${purple}Check ${bwhite}${PWD}/backups ${purple}for backups${reset}"
