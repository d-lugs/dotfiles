#!/usr/bin/bash

# pull latest dotfiles into a temp directory
path="/tmp/dotfiles$(date +%s)"
rm -rf $path
git clone -q https://github.com/d-lugs/dotfiles.git $path

# go through each dotfile in repo
filelist=$(find $path/dotfiles | cut -d'/' -f5- | grep -vP "^(.git/|README.md|setup.sh)$")

# print diff, get user confirmation before writing
write_file(){
    diff $path/dotfiles/$file ~/$file 2>/dev/null
    while true; do
        read -p "Write changes? (y/n) " yn </dev/tty
        case $yn in
            [Yy]*)
                mkdir -p ~/$(dirname $file)
                cp -frv $path/dotfiles/$file ~/$file
                return 0 ;;
            [Nn]*)
                echo -e "Skipping $(basename $1)..."
                return 0 ;;
        esac
    done
}

# check if file contains changes or exists
check_file(){
    if cmp -s -- $path/dotfiles/$file ~/$file 2>/dev/null && [ -e ~/$file ]; then
        return
    elif [ -e ~/$file ]; then
        echo -e "\nChanges to ~/$file found."
        write_file $file
    else
        echo -e "\n~/$file not found."
        write_file $file
    fi
}

for file in $filelist; do
    if [ -f $path/dotfiles/$file ]; then
        check_file $file
    fi
done

echo -e "\nDotfiles are up to date.\n"

# source and clean up
source ~/.bashrc
rm -rf $path
