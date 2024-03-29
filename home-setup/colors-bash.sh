#! /bin/bash

# This Bash script is a simple tool designed to print colorful text in the terminal using ANSI escape codes.
# Its primary purpose is to aid users in checking how their current terminal handles different ANSI escape 
# codes for text and background colors.

# This script is particularly valuable if working with themes in tools like zsh, vim, etc... as specific 
# color configurations are often required for optimal functionality.

n=32
arg=setaf
text='Hello World! This is %s %d'

_help()
{
    printf 'usage: %s [--help|-H] [--16] [--256] [-t|--tiny] [--background|-b]\n' "$(basename $0)"
    exit 0
}

while (( $# > 0 ))
do
    case "$1" in
        256|--256|-256)
            n=256
            shift
            ;;

        16|--16|-16)
            n=16
            shift
            ;;

        --background|-b)
            arg=setab
            shift
            ;;

        --tiny|-t)
            text='█'
            shift
            ;;

        --help|-H)
            _help
            ;;

        --*|-*)
            _help
            ;;
    esac
done

for f in $(seq $n)
do
    tput $arg $f
    printf "$text" $arg $f
    tput sgr0
    if (( f % 16 == 0 )) || [[ "$arg" == 'setab' ]] || [[ "$text" != '█' ]]
    then
        printf '\n'
    fi
done
