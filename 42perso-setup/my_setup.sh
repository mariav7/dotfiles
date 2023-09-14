#!/bin/bash

orange=$'\033[0;33m'
lblue=$'\033[1;34m'
blue=$'\033[34m'
green=$'\033[0;32m'
reset=$'\033[0m'

# setup GIT

echo "$blue Setting up git ... $reset"

git config --global user.name "$USER"

echo "$lblue Enter email for git: $reset"

read varname

git config --global user.email $varname

echo "$blue Setting VIM as git core editor ... $reset"

git config --global core.editor vim

# SETUP VIM - NERDTREE

if [ [ -d "~/.vim/pack/vendor/start/nerdtree" ] ]
then

echo "$blue NERDTree is already installed $reset"

else

echo "$blue Cloning NERDTree repo ... $reset"

git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree

echo "$lblue helptags : NERDTree $reset"

vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

fi

# SETUP VIM - SPACEGRAY THEME

if [ [ -d "~/.vim/pack/vendor/start/Spacegray" ] ]

then

echo "$blue Spacegray theme is already installed $reset"

else

echo "$blue Cloning Spacegray theme ... $reset"

cp -r ~/Desktop/Github-perso/vimrc-zshrc-setup/42perso-setup/themes/Spacegray ~/.vim/pack/vendor/start/

fi

echo "$green BASIC SETUP [DONE] $reset"

# SETUP VIMRC

if [ [ -e ~/.vimrc ] ]
then

echo "$orange Backing up current vimrc config $reset"

mv ~/.vimrc ~/Desktop/Github-perso/vimrc-zshrc-setup/42perso-setup/back-ups/.vimrc.bakup

echo "$orange backed to ~/Desktop/Github-perso/vimrc-zshrc-setup/42perso-setup/back-ups $reset"

fi

echo "$green Adding .vimrc file ... $reset"

cp ~/Desktop/Github-perso/vimrc-zshrc-setup/42perso-setup/.vimrc ~/.vimrc

echo "$green SETUP [COMPLETED] $reset"
echo "$orange check ~/Desktop/Github-perso/vimrc-zshrc-setup/42perso-setup for backups $reset"
echo "$blue ENJOY $reset $green  =] $reset"
