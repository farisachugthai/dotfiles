#!/bin/bash
# Assumes Ubuntu due to the use of PPA's. 
# TODO: Run uname or some equivalent to make sure that they don't already have it 
# in their repositories...like if it's in the original .deb repo then just 
# get it from there

# for ubuntu 16.04 and below you have to install a PPA.
# from https://github.com/dylanaraps/neofetch/wiki/Installation#ubuntu-1610-and-below

# add-apt-repository isn't a built-in command even on ubuntu. need to check if
# it's installed first and if not, then proceed to do so

# more than likely not how this conditional is supposed to be written
if [ ! $(command -v add-apt-repository) ]; then
	sudo apt-get update && sudo apt-get install add-apt-repository
fi

sudo add-apt-repository ppa:dawidd0811/neofetch
sudo apt update 
sudo apt install neofetch

exit 0
