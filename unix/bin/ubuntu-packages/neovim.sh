#!/bin/bash
# Maintainer: Faris Chugthai

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

exit 0
