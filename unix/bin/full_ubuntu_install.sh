#!/bin/bash
#
# Assumes Ubuntu
# Maintainer: Faris Chugthai


bash "minimal_ubuntu_install.sh"

a="apt-get install -y"

echo 'First access and restore your ssh configs and place them in the proper folders.'

echo 'Remember when creating the folders to run `chmod 700 ~/.ssh` and `chmod 600 ~/.ssh/*`'

# Utilities. OpenSSH and gufw are installed by minimal.
$a gparted
$a keepassx
$a synaptic

# Help on the command-line. Vim and Git are installed from minimal.
$a curl
$a fzf      # Not in the Ubuntu repos. Needs a git install.
$a gnupg
$a gnupg2
$a htop
$a rclone   # Not in repo. go get?
$a tmux
$a tree
$a wget


#For development
$a clang
$a gdb
$a hub      # go get i think
$a make
$a neovim
$a nodejs
$a python3-dev python2-dev


# Packages that aren't necessary at all but fun.
$a mpd
$a ncmpcpp
$a vlc
$a sl 
$a neofetch     # PPA but script already provided.
$a screenfetch 
$a cowsay 
$a fortune


# Fix bash's proclivity for global variables
unset a

# Let's put all optional packages in one folder out of the way
# TODO: Ask if the user wants it.

function opt-pkg()
{
    local instl=`bash "ubuntu-packages/$0"`
    echo "Now we'll be installing $0"
}


# Add Spotify
opt-pkg "spotify.sh"


# Neofetch for Ubuntu 16.10 >
# Neofetch 17.04 < has Neofetch in the repos
opt-pkg "neofetch.sh"

# Group all the stuff that requires a specific CPU arch together
if [[ `uname -m == x86_64` ]]; then
    opt-pkg "vs-code.sh"
fi


# TODO: ask if they want a few DE specific applications IE Would you like to
# download some KDE software? Or maybe even, I noticed you're running Lubuntu, would you like to download Thunar? Or something.
# Mention there are dotfiles for KDE?

exit 0
