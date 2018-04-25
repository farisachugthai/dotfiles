#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai


# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "`pip completion --bash`"

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

### Go
# Add the Go std lib to the PATH if that's where it was put
if [ -d /usr/local/go ]; then
    export PATH="/usr/local/go/bin:$PATH"
elif [ -d $PREFIX/local/go ]; then
    export PATH="$PREFIX/local/go/bin:$PATH"
fi

# Utilize GOPATH. 
export GOPATH=$(go env GOPATH)

#Use gofmt as a check for whether Go is installed or not.
if [ $(which gofmt) ]; then
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# Define environment variables as we need them
# Most doesn't even use vi style hotkeys???
# R is what we need for ansi colors
# N for line numbers
export PAGER="less -RN"

# Man pages are difficult to read on Termux with line numbers
export MANPAGER="less -R"

# Allow a color terminal
export COLORTERM="colorterm"

# This is the default but for the sake of being explicit rather than implicit
export XDG_CONFIG_HOME=~/.config
