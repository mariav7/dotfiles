#!/bin/bash

orange=$'\033[0;33m'
lblue=$'\033[1;34m'
blue=$'\033[34m'
green=$'\033[0;32m'
reset=$'\033[0m'

# setup GIT

echo "$blue setup git $reset"

git config --global user.name "$USER"

echo "$lblue enter email for git $reset"

read varname

git config --global user.email $varname

echo "$blue set vim as git core editor $reset"

git config --global core.editor vim

# SETUP VIM - NERDTREE

if [ [ -d "~/.vim/pack/vendor/start/nerdtree" ] ]
then

echo "$blue NERDTree Installed !! $reset"

else

echo "$blue Cloning NERDTree repo $reset"

git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree

echo "$lblue helptags : NERDTree $reset"

vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

fi

# SETUP VIM - SPACEGRAY THEME

if [ [ -d "~/.vim/pack/vendor/start/Spacegray" ] ]

then

echo "$blue Spacegray Install !! $reset"

else

echo "$blue Cloning Spacegray Theme $reset"

git clone https://github.com/ackyshake/Spacegray.vim.git ~/.vim/pack/vendor/start/Spacegray

fi

echo "$green BASIC SETUP - DONE $reset"

# SETUP VIMRC

if [ [ -e ~/.vimrc ] ]
then

echo "$orange Backing up current vimrc config $reset"

mv ~/.vimrc ~/Desktop/My_setup-VIM/.vimrc.bak

echo "$orange backed to ~/my_setup $reset"

fi

echo "$green Adding 5atchm1n .vimrc $reset"

cp ~/Desktop/My_setup-VIM/.vimrc ~/.vimrc

echo "$green SETUP COMPLETED $reset"
echo "$orange check ~/Desktop/My_setup-VIM for backups $reset"
echo "$blue ENJOY $reset $green  =] $reset"
