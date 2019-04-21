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

# Note that PATH should already be marked as exported, so reexporting is not needed. This checks whether the directory exists & is a directory before adding it, which you may not care about.

# Also, this adds the new directory to the end of the path; to put at the beginning, use PATH="$1${PATH:+":$PATH"}" instead of the above PATH= line.

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

# this is what xdg data dirs is set to with no modification on my part. like god that has so many simple errors in it
# /usr/share//usr/share/xsessions/plasma:/home/faris/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:

# Plasma isn't a dir. flatpak is but exports isn't. same thing with var lib.


if [[ -n "$PREFIX" ]]; then
    export MANPATH="$_ROOT/local/share/man:$_ROOT/share/man:$HOME/.fzf/man"
    export SHELL="$PREFIX/bin/bash"
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:$PREFIX/etc/xdg"
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$_ROOT/local/share:$_ROOT/share"
else
    export BROWSER="firefox"
    export SHELL=/bin/bash
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/usr/share/xsessions"
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$_ROOT/share:$_ROOT/share/xsessions:$XDG_DATA_HOME/flatpak:/var/lib/flatpak:/home/faris/.local/share:/usr/share:/usr/xsessions/plasma:/usr/local/share:/usr/share/mime"
fi

# User dirs first: {{{1

# Set PATH so it includes user's private bin directories and set them first in path

if [[ -d "$HOME/bin" ]]; then export PATH="$HOME/bin:$PATH"; fi
if [[ -d "$HOME/.local/bin" ]]; then export PATH="$HOME/.local/bin:$PATH"; fi

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

# Go: {{{1
# Add the Go std lib to the PATH if that's where it was put

# Utilize GOPATH.
if [[ -n "$(command -v go)" ]]; then
    pathadd "$_ROOT/local/go/bin"
    export GOPATH="$(go env GOPATH)"
    export PATH="$PATH:$GOPATH/bin"
fi

# JavaScript: {{{1
if [[ -n "$(command -v yarn)" ]]; then
    pathadd "$HOME/.yarn/bin"

    pathadd "$XDG_DATA_HOME/yarn/global/node_modules/.bin"

    if [[ -f "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash" ]]; then
        # shellcheck source=./.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash disable=1091
        source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
    fi

fi

# Lisp: {{{1
pathadd "$HOME/.racket/7.1/bin"

# Rust: {{{1

# Remember to keep rust above the environment variables. If ./.cargo/bin isn't
# added to the path when we evaluate the PAGER var, then we end up with less
# even if we have bat installed.
pathadd "$HOME/.cargo/bin"

if [[ -f "$HOME/.ripgreprc" ]]; then export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"; fi

# History: {{{1

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=-1
export HISTFILESIZE=-1
# https://unix.stackexchange.com/a/174902
export HISTTIMEFORMAT="%F %T: "
# Ignore all the damn cds, ls's its a waste to have pollute the history
export HISTIGNORE='exit:ls:cd:history:ll:la:gs'
# Apparently I never named histfile?
export HISTFILE="$HOME/.bash_history"

# Append to the history file, don't overwrite it
shopt -s histappend
shopt -s histreedit

# Shopt: {{{1

# Be notified of asynchronous jobs completing in the background
set -o notify
# Check the window size after each command and update the values of LINES and COLUMNS.
# Now the default in Bash 5!!!
shopt -s checkwinsize

# ** will match all files and zero or more directories and subdirectories.
# shellcheck disable=SC2128
if [[ $BASH_VERSINFO -gt 3 ]]; then
    shopt -s globstar
fi

# If an attempt is made to exit bash , list currently running jobs, their status and a warning
shopt -s checkjobs

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
set -o noclobber        # Still dont want to clobber things
shopt -s xpg_echo       # Allows echo to read backslashes like \n and \t
shopt -s dirspell       # Autocorrect the spelling if it can
shopt -s cdspell

# This should be enabled by default but termux is listing it as off
shopt -s hostcomplete

# If you try to complete something that isn't a command, check if its an alias
if [[ $BASH_VERSINFO -gt 4 ]]; then
    shopt -s progcomp_alias
fi

# Print verbose error messages when using shift
shopt -s shift_verbose

shopt -s no_empty_cmd_completion
# If set, and the cmdhist option is enabled, multi-line commands are saved to
# the history with embedded newlines rather than using semicolon separators
# where possible.
shopt -s lithist

shopt -s direxpand

# Pagers: {{{1

if [[ -n "$(command -v bat)" ]]; then
    export BAT_THEME="OneHalfDark"
    export PAGER="bat --italic-text always --wrap never $*"
    export BAT_STYLE="changes,numbers"
    export BAT_PAGER="less -JRKML"
else
# -J displays a status column at the left edge of the screen
# -R is what we need for ansi colors
# -K: exit less in response to Ctrl-C
# -M: Verbose prompt
# -L: Line numbers. Open a man page and hit 'G' to see what you're getting into
    export PAGER="less -JRKML"
fi

export BYOBU_PAGER="nvim"
export COLORTERM="truecolor"

# Other Environment Variables: {{{1

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ -n "$(command -v cheat)" ]];then
    export CHEATCOLORS=true
    export CHEATPATH="$HOME/python/tutorials:$HOME/python/site-packages:$CHEATPATH"
fi

# Set locale if it isn't explicitly stated elsewhere: {{{2
export LANG=en_US.UTF-8                 # gathered from localectl
export LC_MESSAGES=C                    # man i3: Prevents program output translation
export LANGUAGE=en                      # nvim complains us region not supported
export LC_CTYPE=C.UTF-8                 # the python default
export PYTHONIOENCODING=utf-8:surrogateescape
export PYTHONDONTWRITEBYTECODE=1

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

export CURL_HOME="$HOME/.config/curl/curlrc"

# Sourced Files: {{{1

# Setup completions correctly.

# Help find your dotfiles faster and setup nvim
export DOT="$HOME/projects/dotfiles"
export VICONF="$HOME/projects/viconf/.config/nvim"
export NVIM_CONF="$HOME/.config/nvim"
export NVIM_LOG_FILE="$XDG_DATA_HOME/nvim/nvim.log"
export NVIMRUNTIME="$_ROOT/share/nvim/runtime"
pathadd "$_ROOT/local/bin"

# Source the bashrc last.
# shellcheck source=/home/faris/.bashrc
if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi
