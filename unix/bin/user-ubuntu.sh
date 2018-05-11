#!/bin/bash
# Maintainer: Faris Chugthai

# For a user with no admin access
# Useful for a new user account


# Setup Vim's package manager.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install vundle and all relevant plugins.
vim +PluginInstall +qall

# Or setup vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Now let's put Miniconda on our workstation.
# From: 
# https://conda.io/docs/user-guide/install/macos.html#installing-in-silent-mode
wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh;
bash ~/miniconda.sh -b -p $HOME/miniconda3;

# TODO: Create a conda_ubuntu.sh file.
source "$HOME/projects/dotfiles/unix/.condarc"

# TODO: Is there a conda flag to say yes automatically?
# Install all conda packages in the base environment that are used globally on a regular basis
conda activate base
conda update -n base --all
conda install ipython
conda install jupyter notebook
conda install flake8
conda install jedi
conda install jupyter-lab

exit 0
