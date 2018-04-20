#!/bin/bash
# Maintainer: Faris Chugthai
#
# Assumes Termux


#Help on the command-line
pkg install -y bash-completion
pkg install -y binutils
pkg install -y busybox
pkg install -y command-not-found
pkg install -y file
pkg install -y findutils
pkg install -y fzf
pkg install -y gawk
pkg install -y gnupg2
pkg install -y grep
pkg install -y gzip
pkg install -y htop 
pkg install -y linux-man-pages
pkg install -y mlocate
pkg install -y openssh
pkg install -y poppler
pkg install -y sed
pkg install -y texinfo
pkg install -y tmux
pkg install -y tree

#For development
pkg install -y python-dev python2-dev
pkg install -y git
pkg install -y gdb
pkg install -y make
pkg install -y hub
pkg install -y vim-python

# Lets setup vundle
#directly from https://github.com/VundleVim/Vundle.vim/blob/master/README.md
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#now lets install
vim +PluginInstall +qall

# fun ones
pkg install -y sl 
pkg install -y neofetch  
pkg install -y screenfetch 
pkg install -y cowsay 
pkg install -y fortune

# we should use some apt-add-repositories and get stuff you want

pkg install -y termux-api
#setup sd card support and public folders
termux-setup-storage

#TODO: add dropbox symlink or put in initialInstall.py. also make symlink in ~/bin/termux-file-editor and termux-url-opener

exit 0
