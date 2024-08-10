#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ -n $PS1 ]] || return

# Set Environment variables
export EDITOR='vim'
export TZ='America/New_York'
export VISUAL='vim'

# Colorized 'ls' output:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lh'
alias l='ls $LS_OPTIONS -lAh'

# Safety precautions:
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Aliases
alias clear='clear -x'
alias sudos='sudo su -'
alias ..='echo "cd .."; cd ..'
grep --color=auto < /dev/null &>/dev/null && alias grep='grep --color=auto' # colorized grep (if supported)

# bashrc color prompt
# <user>@<hostname> [<pwd>]<$|#> 
if [ "$(id -u)" -eq 0 ]; then
  # root (red)
  PS1='\[\e[91;1m\]\u\[\e[0;90m\]@\[\e[97m\]\H \[\e[90m\][\[\e[0m\]\w\[\e[90m\]]\[\e[0m\]\$ '
elif [ "$(id -u)" -eq 1000 ]; then
  # main user (purple)
  PS1='\[\e[38;5;129;1m\]\u\[\e[0;90m\]@\[\e[97m\]\H \[\e[90m\][\[\e[0m\]\w\[\e[90m\]]\[\e[0m\]\$ '
else
  # other (white)
  PS1='\u\[\e[2m\]@\[\e[0m\]\H \[\e[2m\][\[\e[0m\]\w\[\e[2m\]]\[\e[0m\]\$ '
fi
