#!/usr/bin/bash

# get absolute path of script
path=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
cd $path

# pull dotfiles/dirs
filelist=$(ls -l $path | grep '^-' | grep -vP "(README.md|setup.sh)" | awk '{print $NF}')
for file in $filelist; do
    cp $file "~./.$file"
done

dirlist=$(ls -l $path | grep '^d' | awk '{print $NF}')
for dir in $dirlist; do
    cp -pR $dir "~/.config/"
done

# source dotfiles
cd
. ~/.bashrc
