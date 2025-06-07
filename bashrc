#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ -n $PS1 ]] || return

# Set Environment variables
export EDITOR='vim'
export TZ='America/New_York'
export VISUAL='vim'

# Add ssh identity
eval $(ssh-agent) 1>/dev/null
ssh-add ~/.ssh/carbon_ed25519_sk 2>/dev/null

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

# 256 color in tmux
alias tmux='TERM=xterm-256color tmux'

# Other Aliases
alias clear='clear -x'
alias sudos='sudo su -'
alias ..='echo "cd .."; cd ..'
grep --color=auto < /dev/null &>/dev/null && alias grep='grep --color=auto' # colorized grep (if supported)

# bashrc color prompt
if [ "$(id -u)" -eq 0 ]; then
	# root (green)
	PS1='\[\e[32;1m\]\u\[\e[0;30;2m\]@\[\e[0m\]\H\[\e[37;2m\] \[\e[30m\][\[\e[0m\]\w\[\e[30;2m\]]\[\e[0m\]\$ '
elif [ "$(id -u)" -eq 1000 ]; then
	# main user (red)
	PS1='\[\e[31;1m\]\u\[\e[0;30;2m\]@\[\e[0m\]\H\[\e[37;2m\] \[\e[30m\][\[\e[0m\]\w\[\e[30;2m\]]\[\e[0m\]\$ '
else
	# other (white)
	PS1='\[\e[1m\]\u\[\e[0;30;2m\]@\[\e[0m\]\H\[\e[37;2m\] \[\e[30m\][\[\e[0m\]\w\[\e[30;2m\]]\[\e[0m\]\$ '
fi
