#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai


# Python
# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "`pip completion --bash`"

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"


# Go
# Add the Go std lib to the PATH if that's where it was put
if [[ -d "/usr/local/go" ]]; then
    export PATH="/usr/local/go/bin:$PATH"
elif [[ -d "$PREFIX/local/go" ]]; then
    export PATH="$PREFIX/local/go/bin:$PATH"
fi

# Utilize GOPATH. 
export GOPATH=$(go env GOPATH)

#Use gofmt as a check for whether Go is installed or not.
if [[ $(which gofmt) ]]; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi


## JavaScript
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


# Environment Variables
#
# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
# -N for line numbers
export PAGER="less -JRN"

# Man pages are difficult to read on Termux with line numbers
export MANPAGER="less -R"

# Allow a color terminal
export COLORTERM="colorterm"

# This is the default but for the sake of being explicit rather than implicit
export XDG_CONFIG_HOME="$HOME/.config"

export XDG_CACHE_HOME="$HOME/.cache"

# tldr
# https://github.com/tldr-pages/tldr-python-client/
if [[ $(which tldr) ]]; then
    export TLDR_COLOR_BLANK="white"
    export TLDR_COLOR_NAME="white"
    export TLDR_COLOR_DESCRIPTION="white"
    export TLDR_COLOR_EXAMPLE="white"
    export TLDR_COLOR_COMMAND="white"
    export TLDR_COLOR_PARAMETER="white"
    export TLDR_CACHE_ENABLED=1
    export TLDR_CACHE_MAX_AGE=168
fi

# cheat.py
if [[ $(which cheat) ]]; then
    export CHEATCOLORS=true
fi

# For byobu and Termux specific configuration
export BYOBU_CONFIG_DIR="$HOME/.config/byobu"

if [[ "$PREFIX" ]]; then
    export BYOBU_PREFIX="$PREFIX"
fi

# For tmux
source ~/.bashrc
