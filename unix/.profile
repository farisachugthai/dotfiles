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

# Less Colors for Man Pages 
export LESS_TERMCAP_mb=$'\e[01;31m' # begin blinking
# 
export LESS_TERMCAP_md=$'\e[01;38;5;74m' # begin bold 
export LESS_TERMCAP_me=$'\e[0m' # end mode 
export LESS_TERMCAP_se=$'\e[0m' # end standout-mode 
export LESS_TERMCAP_so=$'\e[38;5;246m' # begin standout-mode info box 
export LESS_TERMCAP_ue=$'\e[0m' # end underline 
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# Man pages are difficult to read on Termux with line numbers
export MANPAGER="less -R"

# Allow a color terminal
export COLORTERM="colorterm"

# This is the default but for the sake of being explicit rather than implicit
export XDG_CONFIG_HOME="$HOME/.config"

export XDG_CACHE_HOME="$HOME/.cache"
