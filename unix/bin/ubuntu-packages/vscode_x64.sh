#!/bin/bash
#
# Assumes a 64bit CPU. Will be modified to ensure that this is true.
# Maintainer: Faris Chugthai

# TODO: Run a uname type thing to make sure that they actually have a 64bit CPU. You can even crash 
# if they don't but damn dude these scripts are garbage.
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg

# I mean i'm sure we do but should we check if that's a folder that comes with vanilla ubuntu?

# Also i'd be surprised if it was a problem, but shouldn't we also modify `mv` to not clobber? maybe a lil mv -pv or w/e?
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
