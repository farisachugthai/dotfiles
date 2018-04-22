#!/data/data/com.termux/files/usr/bin/bash
# Maintainer: Faris Chugthai
#
# Assumes Termux


#Help on the command-line. Termux comes with close to nothing out of the box.
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

# Setup vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install vundle and all relevant plugins.
vim +PluginInstall +qall

# Packages that aren't necessary at all but fun.
pkg install -y sl 
pkg install -y neofetch  
pkg install -y screenfetch 
pkg install -y cowsay 
pkg install -y fortune


# Termux specific package
pkg install -y termux-api


# Setup sd card support and access shared storage
termux-setup-storage


exit 0
