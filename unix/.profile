#!/usr/bin/env bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Ruby: {{{
# This is gonna need a for loop soon.

if [[ -d ~/.gem/ruby/2.5.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
fi

if [[ -d ~/.gem/ruby/2.6.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
fi

if [[ -d "$HOME/.rvm" ]]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi
# }}}

# Go: {{{
# Add the Go std lib to the PATH if that's where it was put
if [[ -d "/usr/local/go" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
elif [[ -d "$PREFIX/local/go" ]]; then
    export PATH="$PATH:$PREFIX/local/go/bin"
fi

# Utilize GOPATH.
if [[ "$(command -v go)" ]]; then
    export GOPATH="$(go env GOPATH)"
    export PATH="$PATH:$GOPATH/bin"
fi
# }}}

# JavaScript: {{{
if [[ $(command -v yarn) ]]; then
    YARNPATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
    export PATH="$PATH:$YARNPATH"
    if [[ -f "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash" ]]; then
        source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
    fi
fi
# }}}

# Environment Variables: {{{
# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
if [[ "$(command -v most)" ]]; then
    export PAGER=most
else
    export PAGER="less -JRMX"
fi

export COLORTERM="truecolor"

# These are the defaults but for the sake of being explicit rather than implicit
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# cheat.py
if [[ "$(command -v cheat)" ]]; then export CHEATCOLORS=true; fi

# kinda hacky but this is a real easy way to determine
# if were using termux or ubuntu. termux defines prefix.
if [[ -n "$PREFIX" ]]; then
    export SHELL="$PREFIX/bin/bash"
    export BROWSER="w3m"
else
    # export SHELL="/bin/bash"
    export BROWSER="firefox"
fi

# Enough vim plugins use either $TMPDIR or $TMP that this became necessary
# Also because termux doesn't set $TMPDIR to /tmp/
if [[ -n "$TMPDIR" ]]; then
    export TMP="$TMPDIR"
else
    if [[ -d "/tmp" ]]; then
        TMPDIR="/tmp"
        export TMP="$TMPDIR"
    fi
fi

export LANG=en_US.UTF-8                 # gathered from localectl
export LANGUAGE=en
export LC_CTYPE=C.UTF-8                   # the only thing defined in /usr/lib/locale right now
# if [ "$(command -v manpath)" ] ; then MANPATH="$(manpath)"; export MANPATH; fi

export TMUXP_CONFIGDIR='$HOME/.tmux'
# is this syntax right or should i just specify the dir?
export CURL_HOME="$HOME/.config/curl/curlrc"

# Help find your dotfiles faster
export DOT="$HOME/projects/dotfiles"
# }}}

# Rust: {{{
if [[ -d "$HOME/.cargo/bin" ]]; then export PATH="$PATH:$HOME/.cargo/bin"; fi

# }}}

# Tmux the culprit as usual
if [[ -n "$TMUX" ]]; then
    tmux new
else
    # hoping that makes an array and by not specifying an index i only pick the 1st
    tmux attach -t "$(tmux ls)"
fi

if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi
