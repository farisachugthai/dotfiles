#!/bin/bash
#
# Assumes Ubuntu
# Maintainer: Faris Chugthai


bash "minimal_ubuntu_install.sh"

a="apt-get install -y"

echo 'First access and restore your ssh configs and place them in the proper folders.'

echo 'Remember when creating the folders to run `chmod 700 ~/.ssh` and `chmod 600 ~/.ssh/*`'

# Utilities
$a gparted

# Help on the command-line. Termux comes with close to nothing out of the box.
$a curl
$a fzf
$a gnupg2
$a htop
$a rclone
$a tmux
$a tree
$p wget


#For development
$a clang
$a gdb
$a hub
$a make
$a neovim
$a nodejs
$a python3-dev python2-dev


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
$a spotify-client

# TODO: ask if they want a few DE specific applications.
# Mention there are dotfiles for KDE.


exit 0
