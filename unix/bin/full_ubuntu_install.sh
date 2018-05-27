#!/bin/bash 
# Assumes Ubuntu
# Maintainer: Faris Chugthai

bash "minimal_ubuntu_install.sh"

a="apt-get install -y"

echo "If you haven't already, please access and restore your ssh configs and place them in the proper folders."
mkdir -pv "$HOME/.ssh"

echo "Let's set your home directory as read-write-executable for only you and no permissions for other users. [700 in octal]"
chmod 700 "$HOME"
chmod 700 "$HOME/.ssh"

touch "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"


# Security and Administration. OpenSSH and gufw are installed by minimal.
$a apt-transport-https
$a apt-transport-tor
$a autossh
$a avahi-discover
$a bleachbit
$a gnupg gnupg-doc
$a gnupg2
$a keepassxc		# So KeePassXC is in the official 18.04 repos which I'm crazy excited about. Check the OS version
$a xdotool


# Help on the command-line. Vim and Git are installed from minimal.
$a bash-completion
$a file
$a fzf      		# Not in the Ubuntu repos. Needs a git install.
$a htop			# Interestingly now a snap
$a ncdu
$a ntfs-3g
# $a rclone   # Not in repo. go get?
$a tree
$a virt-manager
$a xclip
$a xsel


# Utilities
$a dnsutils
$a findutils
$a hfsutils
$a hfsprogs
$a hfsutils
$a id-utils
$a poppler-utils
$a sensible-utils
$a xzutils


# Docs
$a freebsd-manpages
$a info
$a manpages         # apt list --manual-installed has THIS here?
$a manpages-posix
$a manpages-posix-dev
$a texinfo


# Terminal specific
$a byobu
# $a i3wm		# alrady installed just nervous about setup
$a rxvt-unicode-256color
$a tmux
$a yakuake          # love the dropdown. move to kde specific.


#For development
$a adb
$a clang
$a easy-git         # its difficult software guys
$a exuberant-ctags
$a gdb
$a git-hub              # go get i think
$a make

# Internet. Add firefox nightly below.
$a chromium-browser
$a chromium-browser-l10n
$a chromium-chromedriver
$a chromium-codecs-ffmpeg-extra
# $a curl		# already installed
$a deluge
$a network-manager
$a sockstat         # gotta thank the BSD boys
$a torbrowser-launcher
$a w3m
# $a wget		# already installed
$a wpasupplicant

# Packages that aren't necessary at all but fun and/or convenient.
$a cherrytree
$a cowsay
$a fortune
$a mpd
$a ncmpcpp
# $a neofetch         # PPA but script already provided.
$a octicons
$a onionshare
$a sl 
$a screenfetch
$a vlc
$a weechat
$a zim              # PPA and in repo

# Fonts. Can't think of something less pressing.
f="$a fonts"
"$f-fantasque-sans"
"$f-font-awesome"
"$f-hack-ttf"
"$f-mathjax"
"$f-noto"


# DE Specific [is definitely gonna end up it's own file soon enough]
# if GNOME
$a gparted
$a grsync
$a gdebi
$a synaptic		# Move to a gtk focused script along with gparted. kde has partitionmanager and qapt

# Fix bash's proclivity for global variables
unset a f

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

# add docker, atom, ffnightly, virtualbox, gitter, dropbox, powershell, signal-desktop, skypeforlinux, tails-installer

# Now snap's
sudo snap refresh
# maybe try if [ command -v snap ]; then 
sudo snap install --channel=edge shellcheck        # should test a little more
    					           # wonderful choice
# sudo snap install signal-desktop
# sudo snap install pycharm-community --channel=edge --classic
# sudo snap install rclone 			# is an option. idk if it's better to get as a snap or not
# same thing with firefox but we don't get nightly sooooo

# huh so i just ran a blank `snap search` and it responded with 'interesting packages'
# htop has one. apt installs version 2.1. termux has 2.2. snap stable is 2.2. edge is 3.0?
# i realize it's dumb to need the newest version of htop but that was just interesting to me
# other notable things are nextcloud, docker and hugo. like not bad! 
# i'm assuming these installations are WAY bigger than the usual one would be but it's....idk more portable? i get packages i don't
# get otherwise? what is the benefit of a snap? autoupdate i guess?
# but i wouldn't want vscode from a snap. actually i shouldn't even get it from my own script i need to get it from miniconda fuck.


if ask "Would you like to install optional KDE-specific software?" N; then
    bash "ubuntu-packages/kde-specific.sh"
fi

if ask "Would you like to install optional GNOME-specific software?" N; then
    echo "Coming shortly! Sorry."
fi


# modified version of ask.sh
# from: https://gist.github.com/davejamesmiller/1965569#file-ask-sh
# So thank you Dave!

# This is a general-purpose function to ask Yes/No questions in Bash, either
# with or without a default answer. It keeps repeating the question until it
# gets a valid answer.

ask() {
    # https://djm.me/ask
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # can we just put
        ques="Would you like to install "
        # and now for prompt all i have to write is
        # ask "$ques + "packagename (y/n)" Y; then
        # 1. how does string concatenation work in bash.
        # 2. what data types does it use?
        # 3. prompt needs to be tue 1st argument. do we end up woth 2 if
        # we do it this way?

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}


# thanks vim.
# :159,194s/^/#/gc
# EXAMPLE USAGE:
#
#if ask "Do you want to do such-and-such?"; then
#    echo "Yes"
#else
#    echo "No"
#fi
#
## Default to Yes if the user presses enter without giving an answer:
#if ask "Do you want to do such-and-such?" Y; then
#    echo "Yes"
#else
#    echo "No"
#fi
#
## Default to No if the user presses enter without giving an answer:
#if ask "Do you want to do such-and-such?" N; then
##    echo "Yes"
#else
#    echo "No"
#fi
#
## Only do something if you say Yes
#if ask "Do you want to do such-and-such?"; then
#    said_yes
#fi
#
## Only do something if you say No
#if ! ask "Do you want to do such-and-such?"; then
#    said_no
#fi
#
## Or if you prefer the shorter version:
#ask "Do you want to do such-and-such?" && said_yes
#
#ask "Do you want to do such-and-such?" || said_no
exit 0
