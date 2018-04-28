#!/data/data/com.termux/files/usr/bin/bash
#
# Assumes Termux
# Maintainer: Faris Chugthai

p="pkg install -y"

echo "First access and restore your ssh configs and lace them properly."


# Help on the command-line. Termux comes with close to nothing out of the box.
pkg install -y bash-completion
pkg install -y binutils
pkg install -y busybox
pkg install -y command-not-found
$p curl
pkg install -y hub
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
$p rclone
pkg install -y sed
pkg install -y texinfo
pkg install -y tmux
pkg install -y tree
$p wget
pkg install -y xz-utils


#For development
pkg install -y gdb
pkg install -y git
$p go
pkg install -y hub
pkg install -y make
$p neovim
pkg install -y nodejs
pkg install -y python-dev python2-dev
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


# Termux specific packages
pkg install -y termux-api;
# Termux-tools gives you bins like termux-fix-shebang
pkg install -y termux-tools;

# Fix bash's proclivity for global variables
unset p

# Setup sd card support and access shared storage
termux-setup-storage;

# TODO: Adding repos so that you can get packages like gcc and scipy

exit 0
