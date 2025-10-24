#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ -n $PS1 ]] || return

# Set Environment variables
export EDITOR='vim'
export TZ='America/New_York'
export VISUAL='vim'

# Add ssh identity
eval $(ssh-agent) 1>/dev/null
ssh-add ~/.ssh/${HOSTNAME}_ed25519_sk 2>/dev/null

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
alias xx='exit'
alias ..='echo "cd .."; cd ..'
grep --color=auto < /dev/null &>/dev/null && alias grep='grep --color=auto' # colorized grep (if supported)

# bashrc color prompt
if [ "$(id -u)" -eq 0 ]; then
	# root (green)
	PS1='\[\e[32;1m\]\u\[\e[0;90;2m\]@\[\e[0m\]\H\[\e[37;2m\] \[\e[90m\][\[\e[0m\]\w\[\e[90;2m\]]\[\e[0m\]\$ '
elif [ "$(id -u)" -eq 1000 ]; then
	# main user (red)
	PS1='\[\e[31;1m\]\u\[\e[0;90;2m\]@\[\e[0m\]\H\[\e[37;2m\] \[\e[90m\][\[\e[0m\]\w\[\e[90;2m\]]\[\e[0m\]\$ '
else
	# other (white)
	PS1='\[\e[1m\]\u\[\e[0;90;2m\]@\[\e[0m\]\H\[\e[37;2m\] \[\e[90m\][\[\e[0m\]\w\[\e[90;2m\]]\[\e[0m\]\$ '
fi

# activate venv if ./venv exists in current dir
if [[ -d ./venv ]] ; then
	source ./venv/Scripts/activate
fi

# determine if venv needs to be sourced whenever cd-ing to a new directory
function cd() {
	builtin cd "$@"

	# check if venv is set or if ./venv directory exists
	if [[ -z "$VIRTUAL_ENV" || -d ./venv ]] ; then
		# if env folder is foudn then activate the virtual environment
		if [[ -d ./venv ]] ; then
			source ./venv/Scripts/activate
		fi
	else
		# check the current folder belongs to earlier VIRTUAL_ENV folder
		# ${var,,} converts to lowercase
		# if yes then do nothing, else deactivate
		parentdir="$(dirname "$VIRTUAL_ENV")"
		if [[ "${PWD,,}"/ != "${parentdir,,}/* ]] ; then
			deactivate
		fi
	fi
}

# activate venv if ./venv exists in curernt dir
# or supply a dir name in ~/ as an argument to activate a specific env
function venv() {
	if [[ -d ./venv ]] ; then
		source ./venv/Scripts/activate
	elif [[ -d ~/$1/venv ]] ; then
		source ~/$1/venv/Scripts/activate
	else
		if [[ -v 1 ]] ; then
			echo "~/$1/venv not found"
		else
			echo "venv not found"
		fi
		return 1
	fi
}
