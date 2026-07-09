#!/usr/bin/bash

# pull latest dotfiles into a temp directory
path="/tmp/dotfiles"
rm -rf $path
git clone -q https://github.com/d-lugs/dotfiles.git $path

user_confirm(){
    while true; do
        read -ep "Update $1? (y/n) " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
        esac
    done
}

write_config(){
    diff $1 $2
    while true; do
        read -p "Update $(basename $1)? (y/n) " yn </dev/tty
        case $yn in
            [Yy]*) cp -vrf $1 $2 ; return 0 ;;
            [Nn]*) echo "Skipping $1..." ; return 0 ;;
        esac
    done
    return
}

# pull dotfiles/dirs
filelist=$(ls -l $path | grep '^-' | grep -vP "(README.md|setup.sh)" | awk '{print $NF}')
for file in $filelist; do
    if cmp -s -- $path/$file ~/.$file && [ -e ~/.$file ]; then
        continue
    elif [ -e ~/.$file ]; then
        echo "Changes to $file found."
    fi
    write_config $path/$file ~/.$file
done

dirlist=$(ls -l $path | grep '^d' | awk '{print $NF}')
for dir in $dirlist; do
    if [ $(diff -r $path/$dir ~/.config/$dir 2>/dev/null | wc -l) -eq 0 ] && [ -d ~/.config/$dir ]; then
        continue
    elif [ -d ~/.config/$dir ]; then
        echo "Changes to $dir found."
    fi
    write_config $path/$dir ~/.config/$dir
done

# source dotfiles
. ~/.bashrc

echo "Dotfiles are up to date."

# cleanup
rm -rf $path
