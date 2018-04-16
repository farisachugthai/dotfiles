#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai


# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "`pip completion --bash`"

# Set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add Go to the PATH
PATH="/usr/local/go/bin:$PATH"

# Define environment variables as we need them
export PAGER="/bin/less"
export COLORTERM="colorterm"

# Add Conda to the path
if [ -d ~/miniconda3 ]; then
   . ~/miniconda3/etc/profile.d/conda.sh
fi

# Source the bashrc in last
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
