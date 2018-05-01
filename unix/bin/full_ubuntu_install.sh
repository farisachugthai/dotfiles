#!/bin/bash
#
# Assumes Ubuntu
# Maintainer: Faris Chugthai

# Once again this requires root permissions and has vundle. 
# Should there be a minimal root install and a "full" install. we can source root.
# But then we're STILL gonna need to have a normal user install script. ergh.

bash "root_ubuntu_install.sh"

a="apt-get install -y"

echo "First access and restore your ssh configs and replace them properly."

# Security 
$a gufw
$a openssh-server
$a openssh-client

# Utilities
$a gparted

# Help on the command-line. Termux comes with close to nothing out of the box.
pkg install -y bash-completion
pkg install -y binutils
pkg install -y busybox
pkg install -y command-not-found
$p curl
$a fzf
$a gnupg2
pkg install -y gzip
pkg install -y htop 
pkg install -y linux-man-pages
pkg install -y mlocate
pkg install -y poppler
$a rclone
$a tmux
$a tree
$p wget
pkg install -y xz-utils


#For development
$a clang
$a gcc
$a gdb
$a hub
$a make
$a neovim
$a nodejs
$a python3-dev python2-dev
$a vim-gtk3

# Setup vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install vundle and all relevant plugins.
vim +PluginInstall +qall

# Packages that aren't necessary at all but fun.
$a sl 
$a neofetch  
$a screenfetch 
$a cowsay 
$a fortune


# Fix bash's proclivity for global variables
unset a

# Add Spotify
# TODO: Ask if the user wants it.
# 
# This wasn't put in the root script since it's a superfluous package.
#
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
apt-get update

# 4. Install Spotify
apt-get install spotify-client

# TODO: ask if they want a few DE specific applications.
# Mention there are dotfiles for KDE.


exit 0
