#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# Python
# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "$(pip completion --bash)"

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

if [[ -d ~/.gem/ruby/2.5.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
fi

# Go
# Add the Go std lib to the PATH if that's where it was put
if [[ -d "/usr/local/go" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
elif [[ -d "$PREFIX/local/go" ]]; then
    export PATH="$PATH:$PREFIX/local/go/bin"
fi

# Utilize GOPATH. 
if [[ $(which go) ]]; then
    export GOPATH="$(go env GOPATH)"
    export PATH="$PATH:$GOPATH/bin"
fi

# JavaScript 
if [[ $(command -v yarn) ]]; then
    YARNPATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
    export PATH="$PATH:$YARNPATH"
    source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
fi


# Environment Variables 
# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
export PAGER="less -JR"

# Man pages are difficult to read on Termux with line numbers
export MANPAGER="less -R"

# Allow a color terminal. Oddly it seems like Konsole sets this for us.
export COLORTERM="colorterm"

# These are the defaults but for the sake of being explicit rather than implicit
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# cheat.py
if [[ $(which cheat) ]]; then
    export CHEATCOLORS=true
fi

# kinda hacky but this is a real easy way to determine
# if were using termux or ubuntu. termux defines prefix.
if [[ -n "$PREFIX" ]]; then
    export SHELL="$PREFIX/bin/bash"
    export BROWSER="w3m"
else
    export SHELL="/bin/bash"
    export BROWSER="firefox"
fi

# Set locale if it isn't explicitly stated elsewhere
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8                 # gathered from localectl

# if [ "$(command -v manpath)" ] ; then MANPATH="$(manpath)"; export MANPATH; fi

if [[ -d "$HOME/.cargo/bin" ]]; then export PATH="$HOME/.cargo/bin:$PATH"; fi

# Tmux the culprit as usual
if [[ -n "$TMUX" ]]; then
    source "$HOME/.bashrc"
fi
