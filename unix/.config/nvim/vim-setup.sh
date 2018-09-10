#!/usr/bin/env bash

# Set up vim
if [[ -d "$HOME/.vim/autoload" ]]; then
    mkdir -pv "$HOME/.vim/autoload"
fi

if ! [[ -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -sSLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ "$(command -v conda)" ]]; then
    conda install neovim
else
    pip install -U neovim
fi

# Set up neovim

if [[ -d "$HOME/.local/share/nvim/site/autoload" ]]; then
    mkdir -pv "$HOME/.local/share/nvim/site/autoload"
fi

ln -s "$HOME/.vim/autoload/plug.vim" "$HOME/.local/share/nvim/site/autoload"

exit 0
