#!/data/data/com.termux/files/usr/bin/bash
# Objectives:
# Establish a functional python development on Termux
#
#
# A script that installs python libs as conda doesnt work on a phone
# Upgrade libraries if it has already been installed
#
# Maintainer: Faris Chugthai

pkg install python-dev

pip install -U pip
pip install -U ipython
pip install -U virtualenv
pip install -U tldr
pip install -U cheat 
pip install -U youtube-dl 
pip install -U flake8
pip install -U neovim

#Now lets add some color to cheat
cd $PREFIX/etc/bash_completion.d/
curl -so cheat.bash https://raw.githubusercontent.com/chrisallenlane/cheat/master/cheat/autocompletion/cheat.bash

exit 0
