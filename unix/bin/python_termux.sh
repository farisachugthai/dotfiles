#!/data/data/com.termux/files/usr/bin/bash
# Objectives:
# Establish a functional python development on Termux
#
#
# A script that installs python libs as conda doesnt work on a phone
# Upgrade libraries if it has already been installed
#
# Maintainer: Faris Chugthai

# Pkg up automatically runs apt update && apt upgrade
pkg up -y

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


# Add a community repo so you can download Jupyter Notebooks on your phone!
# The following is copy/pasted with modifications from:
# https://raw.githubusercontent.com/its-pointless/gcc_termux/master/setup-pointless-repo.sh

# Make the sources.list.d directory
mkdir -pv $PREFIX/etc/apt/sources.list.d

# Write the needed source file
# should add a test to ensure no file exists there or that the repo isn't in their sources.list
echo "deb [trusted=yes] https://its-pointless.github.io/files/ termux extras" >> $PREFIX/etc/apt/sources.list.d/pointless.list

# Download signing key from https://its-pointless.github.io/pointless.gpg 
wget -O "pointless.gpg" https://its-pointless.github.io/pointless.gpg 
apt-key add pointless.gpg 

# Now lets install all the necessary dependecies
pkg install -y clang fftw libzmq libzmq-dev freetype freetype-dev libpng libpng-dev pkg-conf   

# Setup the compiler
LDFLAGS=" -lm -lcompiler_rt"

# Install pip packages
pi="pip install -U"
$pi numpy 
$pi matplotlib 
$pi pandas 
$pi jupyter
unset pi

exit 0
