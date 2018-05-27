#!/bin/bash
# Maintainer: Faris Chugthai
#
# Objectives: Install the minimum number of packages required to create a
# working python development environment
# In addition, get the newest versions of each package.


if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# Update the system
apt update && apt upgrade -y && apt autoremove -y;

# Install OpenSSH
apt install -y openssh-server;
apt install -y openssh-client;

# Setup a minimal firewall.
apt install -y gufw;

# In case it's already running restart it
ufw disable && ufw enable;

# Enable default deny
ufw default deny incoming;

# Limit how often you get SSH requests
ufw limit OpenSSH;

# Restart the firewall for changes to take effect
ufw disable;
ufw enable;

# Before we start adding repositories, let's backup our old sources
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Get the newest version of Git and corresponding documentation
# Adding repositories requires the user to hit 'Enter' to proceed which is
# An acceptable amount of user interaction
add-apt-repository ppa:git-core/ppa
apt update
apt install -y git git-man git-doc

# The default version of Vim in the repositories is currently 7.4 but we prefer
# Vim 8.1
add-apt-repository ppa:jonathonf/vim
apt update
apt install vim-gtk3
# should we also uninstall vim.tiny while we're digging around because i see it still being linked to things 
# when update-alternatives runs

# Installing conda can be done without any special permissions
# so once we make an initial_ubuntu_install.sh file throw this in here.
# you can modify the call to run silently as well!


# or can we just prepend sudo to every command in the script and tell that one to run sudo -H? i genuinely don't know.
# wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-`uname -m`.sh

exit 0
