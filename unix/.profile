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
# You can do the below with simply:
# [ -x /usr/bin/most ]; then
# might be more "classic bash" to do it this way. use which when in venvs def
if [ $(which most) ]; then
    export PAGER="/usr/bin/most"
else
    export PAGER="less -r"
fi

export COLORTERM="colorterm"

# Source the bashrc in last
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
