#!/bin/bash
# Maintainer: Faris Chugthai

# For a user with no admin access
# Useful for a new user account


# Setup Vim's package manager.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install vundle and all relevant plugins.
vim +PluginInstall +qall


# Now let's put Miniconda on our workstation.
# From: 
# https://conda.io/docs/user-guide/install/macos.html#installing-in-silent-mode

wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh 

bash ~/miniconda.sh -b -p $HOME/miniconda3

exit 0
