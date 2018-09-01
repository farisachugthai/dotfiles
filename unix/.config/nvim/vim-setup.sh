#!/usr/bin/env bash

# Set up neovim

if [[ -d "$HOME/.vim/autoload" ]]; then
    mkdir -pv "$HOME/.vim/autoload"
fi

if ! [[ -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -sSLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ "$(command -v conda)" ]]; then
    conda install neovim
fi
