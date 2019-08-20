#!/usr/bin/env bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# Pathadd: {{{1
# https://superuser.com/a/39995
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# Note that PATH should already be marked as exported, so reexporting is not needed.
# This checks whether the directory exists & is a directory before adding it, which you may not care about.

# Platform_Dependant: {{{1

# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# this is what xdg data dirs is set to with no modification on my part. That has so many simple errors in it
# /usr/share//usr/share/xsessions/plasma:/home/faris/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:

# Jul 25, 2019: Just realized I haven't added MIME dirs to the data dirs
# Plasma isn't a dir. flatpak is but exports isn't. same thing with var lib.
if [[ -n "$PREFIX" ]]; then
    export MANPATH="$_ROOT/local/share/man:$_ROOT/share/man:$HOME/.fzf/man:$_ROOT/share/fish/man"
    export SHELL="$PREFIX/bin/bash"
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:$PREFIX/etc/xdg"
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$_ROOT/local/share:$_ROOT/share:$XDG_DATA_HOME/mime"
    pathadd "$_ROOT/libexec"
    pathadd "$_ROOT/libexec/git-core"
    export CFLAGS='-I/data/data/com.termux/files/usr/includes'
    export CC='aarch64-linux-android-clang'
else
    export BROWSER="firefox "
    export SHELL=/bin/bash
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/usr/share/xsessions"
    # You forgot the one for snaps!
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_HOME/mime:$_ROOT/share:$_ROOT/share/xsessions:/var/lib/snapd/desktop:$XDG_DATA_HOME/flatpak:/var/lib/flatpak:$HOME/.local/share:/usr/share:/usr/xsessions/plasma:/usr/local/share:/usr/share/mime"
    pathadd "$_ROOT/lib/x86_64-linux-gnu/libexec"
fi


# User dirs first: {{{1

# Set PATH so it includes user's private bin directories and set them first in path
pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"

# Python: {{{1

export PYTHONIOENCODING=utf-8:surrogateescape
export PYTHONDONTWRITEBYTECODE=1
export IPYTHONDIR="$HOME/.ipython"
export PYTHONCOERCECLOCALE=warn
if [[ -n "$(command -v ipdb)" ]];  then export PYTHONBREAKPOINT="ipdb"; fi
export PYTHONUNBUFFERED=1

# Ruby: {{{1
# This is gonna need a for loop soon.

pathadd "$HOME/.gem/ruby/2.5.0/bin"
pathadd "$HOME/.gem/ruby/2.6.0/bin"
pathadd "$HOME/.gem/ruby/2.7.0/bin"

if [[ -n "$(command -v rvm)" ]]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    pathadd "$HOME/.rvm/bin"
    # shellcheck source=/home/faris/.rvm/scripts/rvm disable=1091
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_PATH:$HOME/.gem:$_ROOT/lib/ruby"  # idk if this is right

# JavaScript: {{{1
if [[ -n "$(command -v yarn)" ]]; then
    pathadd "$HOME/.yarn/bin"

    pathadd "$XDG_DATA_HOME/yarn/global/node_modules/.bin"

    if [[ -f "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash" ]]; then
        # shellcheck source=./.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash disable=1091
        source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
    fi
fi
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_log.js"

# Lisp: {{{1
pathadd "$HOME/.racket/7.1/bin"

# Rust: {{{1

# Remember to keep rust above the environment variables. If ./.cargo/bin isn't
# added to the path when we evaluate the PAGER var, then we end up with less
# even if we have bat installed.
pathadd "$HOME/.cargo/bin"

if [[ -f "$HOME/.ripgreprc" ]]; then export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"; fi

# Other Environment Variables: {{{1

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ -n "$(command -v cheat)" ]];then
    export CHEATCOLORS=true
    export CHEATPATH="$HOME/python/tutorials:$HOME/python/site-packages:$CHEATPATH"
fi

# Set locale if it isn't explicitly stated elsewhere: {{{2
# This lang setting messes up neon
# export LANG=en_US.UTF-8               # gathered from localectl
export LANG=C.UTF-8
export LC_MESSAGES=C.UTF-8              # man i3: Prevents program output translation
# export LANGUAGE=en_US                   # nvim complains us region not supported
export LC_CTYPE=C.UTF-8                 # the python default
# export LC_IDENTIFICATION=en_US          # got this from `locale -c language` I don't know if set right
export LC_COLLATE=C.UTF-8
export LC_ALL=C.UTF-8

# Idk if this is or isn't a bad idea
export LDFLAGS=" -lm"
# export LANG="en_US.UTF-8"                 # gathered from localectl

# Emacs doesn't read Xresources files????
export XENVIRONMENT=~/.Xresources

# Tmp: {{{2
if [[ -n "$TMPDIR" ]]; then
    export TMP="$TMPDIR"
else
    if [[ -d "/tmp" ]]; then
        # don't have tmp set to more than one thing dingus
        export TMP="/var/tmp"
        export TMPDIR="/var/tmp"
    fi
fi

if [[ -d "$HOME/.tmux" ]]; then export TMUXP_CONFIGDIR="$HOME/.tmux"; fi

# Disable MSFT pwsh telemetry: {{{2
export POWERSHELL_TELEMETRY_OPTOUT=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export IHOPEYOUALLKNOWITHINKYOUAREFUCKINGCLOWNS=1
export CLOUDSDK_CORE_DISABLE_USAGE_REPORTING=1

# cURL: {{{2
export CURL_HOME="$HOME/.config/curl/curlrc"

# Sourced Files: {{{1

# Setup completions correctly.

# Help find your dotfiles faster and setup nvim
export DOT="$HOME/projects/dotfiles"
export VICONF="$HOME/projects/viconf/.config/nvim"
export NVIM_CONF="$HOME/.config/nvim"
export NVIM_LOG_FILE="$XDG_DATA_HOME/nvim/nvim.log"
export NVIM_PYTHON_LOG_FILE="$XDG_DATA_HOME/nvim/nvim_python.log"
export NVIMRUNTIME="$_ROOT/share/nvim/runtime"
pathadd "$_ROOT/local/bin"

# Source the bashrc last.
# shellcheck source=/home/faris/.bashrc
if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi
