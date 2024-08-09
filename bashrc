# basic colored bash prompt

# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# Colorized 'ls' output:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lh'
alias l='ls $LS_OPTIONS -lAh'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Custom alias section
alias clear='clear -x'
alias sudos='sudo su -'

if [ "$(id -u)" -eq 0 ]; then
  # root
  PS1='\[\e[91;1m\]\u\[\e[0;90m\]@\[\e[97m\]\H \[\e[90m\][\[\e[0m\]\w\[\e[90m\]]\[\e[0m\]\$ '
else
  # normal user
  PS1='\[\e[38;5;129;1m\]\u\[\e[0;90m\]@\[\e[97m\]\H \[\e[90m\][\[\e[0m\]\w\[\e[90m\]]\[\e[0m\]\$ '
fi
