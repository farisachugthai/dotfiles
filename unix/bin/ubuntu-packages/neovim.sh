#!/bin/bash
# Maintainer: Faris Chugthai

<<<<<<< Updated upstream
# TODO: Check if they have add-apt-repository it's not a default package
sudo add-apt-repository ppa:neovim-ppa/unstable
# sudo apt-get update				# does add-apt-repository autorun update? apparently it does.
sudo apt-get install neovim

# This is probably a good way to check if Conda is installed
# Debating whether to use this one because it ensures that they've activated conda
# if [ "$CONDA_SHLVL" -gt 0 ]; then 
# or this one because it means we have the executable
if [ -n "$CONDA_EXE" ]; then
# wth bash is telling me conda: command not found....
# i'm getting nothing from `which conda` but command -v is finding it. sigh let's come up with a cheap workaround
    if [ $(which conda) ]; then
        conda install neovim;
        conda upgrade neovim;
    else
	    $(echo $CONDA_EXE) install neovim;
	    $(echo $CONDA_EXE) upgrade neovim;
    fi
else 
    if [ $(command -v pip3) ]; then
        pip3 install --user -U neovim
    fi
fi

# Oh my god it finally worked.
# TODO: Install vim-plug. I swear that's in one of these scripts.
=======
# this is just ridiculously lazy. like come on man run some checks, see if they
# need it, see if they have the right permissions like jesus christ this is 
# literally as bad as it gets

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

# should we run a check to see if pip3 is installed? 
# also i'm still really stuck on the permissions things. how long will all of this take?
# long enough for sudo to timeout because it usually doesn't take that long to happen
pip3 install --user -U neovim
>>>>>>> Stashed changes

exit 0
