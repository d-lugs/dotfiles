#!/usr/bin/bash

# get absolute path of script
path=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
cd $path

user_confirm(){
    while true; do
        read -p "Update $1? (y/n) " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
        esac
    done
}

write_config(){
    if $(user_confirm $1); then
        cp -vrf $1 $2
    else
        echo "Skipping $1...";
    fi
}

# pull dotfiles/dirs
filelist=$(ls -l $path | grep '^-' | grep -vP "(README.md|setup.sh)" | awk '{print $NF}')
for file in $filelist; do
    if cmp -s -- $file ~/.$file && [ -e ~/.$file ]; then
        continue
    elif [ -e ~/.$file ]; then
        echo "Changes to $file found."
    fi
    write_config $file ~/.$file
done

dirlist=$(ls -l $path | grep '^d' | awk '{print $NF}')
for dir in $dirlist; do
    if [ $(diff -r $dir ~/.config/$dir 2>/dev/null | wc -l) -eq 0 ] && [ -d ~/.config/$dir ]; then
        continue
    elif [ -d ~/.config/$dir ]; then
        echo "Changes to $dir found."
    fi
    write_config $dir ~/.config/$dir
done

# source dotfiles
. ~/.bashrc

echo "Dotfiles are up to date."
