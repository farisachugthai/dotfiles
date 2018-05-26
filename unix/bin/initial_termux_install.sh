#!/data/data/com.termux/files/usr/bin/bash
#
# Assumes Termux
# Maintainer: Faris Chugthai

p="pkg install -y"

echo 'First access and restore your ssh configs and place them in the proper folders.'

echo 'Remember when creating the folders to run `chmod 700 ~/.ssh` and `chmod 600 ~/.ssh/*`'

# Help on the command-line. Termux comes with close to nothing out of the box.
$p bash-completion
$p binutils
$p busybox
$p command-not-found
$p curl
$p dnsutils     # we didn't have dig, nslookup or host before this
$p hub
$p file
$p findutils
$p fzf
$p gawk
$p gnupg2
$p grep
$p gzip
$p htop 
$p linux-man-pages
$p mlocate
$p openssh
$p poppler
$p rclone
$p sed
$p texinfo
$p tmux
$p tree
$p util-linux
$p wget
$p xz-utils


#For development
$p gdb
$p git
$p go
$p hub
$p make
$p neovim
$p nodejs
$p python-dev python2-dev
$p vim-python


# Setup vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install vundle and all relevant plugins.
vim +PluginInstall +qall

# Packages that aren't necessary at all but fun.
$p cowsay 
$p fortune
$p neofetch  
$p screenfetch 
$p sl 

# Termux specific packages
$p termux-api;
# Termux-tools gives you bins like termux-fix-shebang
$p termux-tools;

# Fix bash's proclivity for global variables
unset p

# Setup sd card support and access shared storage
termux-setup-storage;

# Now let's set up our python environment
bash python_termux.sh;

# When apps share a file or URL to Termux, Termux calls whatever is placed
# at termux-file-editor and termux-url-editor
ln -s "$HOME/bin/termux-file-editor" `command -v nvim`

# assuming the file is run in this dir
ln -s "$HOME/bin/termux-url-opener" "$PWD/termux-url-opener"

# cant run yet until the command is generalized but at some point
# bash ubuntu_packages/neovim.sh;

exit 0
