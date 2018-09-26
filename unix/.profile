#!/usr/bin/env bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# All: {{{

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Ruby: {{{
# This is gonna need a for loop soon.

if [[ -d ~/.gem/ruby/2.5.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
fi

# Load RVM into a shell session *as a function*
if [[ -d ~/.gem/ruby/2.6.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
fi

if [[ "$(command -v rvm)" ]]; then
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
if [[ "$(which go)" ]]; then
    export GOPATH="$(go env GOPATH)"
    export PATH="$PATH:$GOPATH/bin"
fi
# }}}

# JavaScript: {{{
if [[ "$(command -v yarn)" ]]; then
    YARNPATH=$HOME/.yarn/bin:$HOME/.local/share/yarn/global/node_modules/.bin
    export PATH="$PATH:$YARNPATH"

    if [[ -f "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash" ]]; then
        source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
    fi

fi
# }}}

# Environment Variables: {{{

# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
export PAGER="less -JR"

# Man pages are difficult to read on Termux with line numbers
export MANPAGER="less -R"

export COLORTERM="truecolor"

# These are the defaults but for the sake of being explicit rather than implicit
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# dropping these but don't use them yet
# export XDG_CONFIG_DIRS="/etc/xdg"
# export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ "$(which cheat)" ]]; then export CHEATCOLORS=true; fi

if [[ -n "$PREFIX" ]]; then
    export SHELL="$PREFIX/bin/bash"
    export BROWSER="w3m"
    export XDG_CONFIG_DIRS="$PREFIX/etc/xdg"
    export XDG_DATA_DIRS="$PREFIX/local/share:$PREFIX/share"
else
    export SHELL="/bin/bash"
    export BROWSER="firefox"
fi

# Set locale if it isn't explicitly stated elsewhere
export LANG=en_US.UTF-8                 # gathered from localectl
export LC_MESSAGES=C                    # man i3: Prevents program output translation
export LANG=en_US.UTF-8                 # gathered from localectl

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

export TMUXP_CONFIGDIR='$HOME/.tmux'

export CURL_HOME="$HOME/.config/curl/curlrc"
# }}}

# Rust: {{{
if [[ -d "$HOME/.cargo/bin" ]]; then export PATH="$HOME/.cargo/bin:$PATH"; fi
# }}}

# Sourced files: {{{
export TMUXP_CONFIGDIR='$HOME/.tmux'

# Help find your dotfiles faster
export DOT="$HOME/projects/dotfiles"
# }}}

# Tmux the culprit as usual
if [[ -n "$TMUX" ]]; then
    source "$HOME/.bashrc"
fi

# }}}
