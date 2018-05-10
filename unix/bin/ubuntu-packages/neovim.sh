#!/bin/bash
# Maintainer: Faris Chugthai

# Downloads Neovim

add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install neovim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
