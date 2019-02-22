#!/usr/bin/env bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# TODO: For everything that modifies path, run a check to ensure it's not already an entry.

# Set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Platform_Dependant: {{{1

if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi

export NVIMRUNTIME="$_ROOT/share/nvim/runtime"
export PATH="$_ROOT/local/bin/:$PATH"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"


if [[ -n "$PREFIX" ]]; then
    export MANPATH="$_ROOT/local/share/man:$_ROOT/share/man:$HOME/.fzf/man"
    export SHELL="$PREFIX/bin/bash"
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:$PREFIX/etc/xdg"
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$_ROOT/local/share:$_ROOT/share"
else
    export BROWSER="firefox"
    export SHELL=/bin/bash
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/usr/share/xsessions"
fi

# Ruby: {{{1
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
    # shellcheck source=/home/faris/.rvm/scripts/rvm disable=1091
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# Go: {{{1
# Add the Go std lib to the PATH if that's where it was put
if [[ -d "$_ROOT/local/go" ]]; then
    export PATH="$PATH:$_ROOT/local/go/bin"
fi

# Utilize GOPATH.
if [[ -n "$(command -v go)" ]]; then
    export GOPATH="$(go env GOPATH)"
    export PATH="$PATH:$GOPATH/bin"
fi

# JavaScript: {{{1
if [[ -n "$(command -v yarn)" ]]; then
    YARNPATH="$HOME/.yarn/bin:$HOME/.local/share/yarn/global/node_modules/.bin"
    export PATH="$PATH:$YARNPATH"

    if [[ -f "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash" ]]; then
        # shellcheck source=./.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash disable=1091
        source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
    fi

    if [[ -d "$HOME/.yarn/bin" ]]; then
        export PATH="$PATH:$HOME/.yarn/bin"
    fi

    if [[ -d "$HOME/.config/yarn/global/node_modules/.bin" ]]; then
        export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
    fi

fi

# Lisp: {{{1
if [[ -d "$HOME/.racket/7.1/bin" ]]; then
    export PATH="$PATH:$HOME/.racket/7.1/bin"
fi

# Environment Variables: {{{1
# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
# -K: exit less in response to Ctrl-C
# -M: Verbose prompt
# -L: Line numbers. Open a man page and hit 'G' to see what you're getting into
# export PAGER="less -JRKML"

if [[ -n "$(command -v bat)" ]]; then
    export BAT_THEME=OneHalfDark
    export BAT_PAGER=''
    export PAGER="bat"
fi
export VIMRUNTIME="$_ROOT/share/nvim/runtime"
export COLORTERM="truecolor"

# I love you vim but your manpager is driving me nuts.
# Still need to debug.
# export MANPAGER=kak

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ -n "$(command -v cheat)" ]];then
    export CHEATCOLORS=true
    export CHEATPATH="$HOME/python/tutorials:$HOME/python/site-packages:$CHEATPATH"
fi

# Set locale if it isn't explicitly stated elsewhere
export LANG=en_US.UTF-8                 # gathered from localectl
export LC_MESSAGES=C                    # man i3: Prevents program output translation
export LANGUAGE=en                      # nvim complains us region not supported
export LC_CTYPE=C.UTF-8                 # the python default
export PYTHONIOENCODING=utf-8:surrogateescape
export PYTHONDONTWRITEBYTECODE=1

# Enough vim plugins use either $TMPDIR or $TMP that this became necessary
if [[ -n "$TMPDIR" ]]; then
    export TMP="$TMPDIR"
else
    if [[ -d "/tmp" ]]; then
        export TMP="/var/tmp,/usr/tmp,/tmp"
        export TMPDIR="/var/tmp"
    fi
fi

if [[ -d "$HOME/.tmux" ]]; then export TMUXP_CONFIGDIR="$HOME/.tmux"; fi

# Disable MSFT pwsh telemetry
export POWERSHE_TELEMETRY_OPTOUT=1

export CURL_HOME="$HOME/.config/curl/curlrc"

# Rust: {{{1
if [[ -d "$HOME/.cargo/bin" ]]; then export PATH="$HOME/.cargo/bin:$PATH"; fi

# Sourced Files: {{{1

# Setup completions correctly.

# Help find your dotfiles faster
export DOT="$HOME/projects/dotfiles"
export VICONF="$HOME/projects/viconf/.config/nvim"
export NVIM="$HOME/.config/nvim"

# Source the bashrc last.
if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi
