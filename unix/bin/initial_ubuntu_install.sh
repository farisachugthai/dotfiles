#!/bin/bash
# This script will install the bare minimum number of packages required for
# successful installation of all the dotfiles and a automatically generated
# development environment
#
#Objectives: Install the minimum number of packages required to create a
# working python development environment
# In addition, get the newest versions of each package.
#
# This script does assume a user with installation permissions
# Maintained by Faris Chugthai

apt update && apt upgrade -y && apt autoremove -y

# Get the newest version of Git and corresponding documentation
add-apt-repository ppa:git-core/ppa
apt update
apt install -y git git-man git-doc

# The default version of Vim in the repositories is currently 7.4 but we prefer
# Vim 8.0
add-apt-repository ppa:jonathonf/vim
apt update
apt install vim-gtk3

# Then install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install pip and conda.
# Currently independent of x86 or x64 however still assumes Linux
apt install python3-pip
wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-`uname -m`.sh

# TODO: Add in modifications so that downloading Conda is completely automated
