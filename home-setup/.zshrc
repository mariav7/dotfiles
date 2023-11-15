# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

#42 Header Settings for VIM
# https://github.com/42Paris/42header -- repo to insert header in vim
export USER="mflores-"
export MAIL="mflores-@student.42.fr"

# custom mod file
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias vimrc="vim ~/.vimrc"

# Custom Commands
alias lsl="ls -l --group-directories-first"
cdd() {cd "$1" && ls -l --group-directories-first}

# Change "path-to-your/projectName" to your folder's path
# Project Files
alias github-repos="cd path-to-your/github-repos && lsl"
alias cursus42="cd path-to-your-folder/ && lsl"
