#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# Pathadd: {{{
pathadd() {
    # https://superuser.com/a/39995
    # Set PATH so it includes user's private bin directories and set them first in path
    # This checks whether the directory exists & is a directory before adding it, which you may not care about.
    # Note that PATH should already be marked as exported, so reexporting is not needed.
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# IDK if this is working correctly .local bin isnt in termuxs path
firstpath() {
    # Check if a dir exists and if it does, prepend it to the $PATH.
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:${PATH:+"$PATH"}"
    fi
}

# }}}

# Platform_Dependant: {{{
# Set PATH so it includes user's private bin directories and set them first in path
firstpath "$HOME/bin"
firstpath "$HOME/.local/bin"

# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CACHE_DIRECTORY="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# this is what xdg data dirs is set to with no modification on my part. That has so many simple errors in it
# /usr/share//usr/share/xsessions/plasma:/home/faris/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:

# Jul 25, 2019: Just realized I haven't added MIME dirs to the data dirs
# Plasma isn't a dir. flatpak is but exports isn't. same thing with var lib.
if [[ -n "$ANDROID_DATA" ]]; then

    export MANPATH="$_ROOT/local/share/man:$_ROOT/share/man:$HOME/.fzf/man:$_ROOT/share/fish/man:$PREFIX/lib/node_modules/npm/man"
    export SHELL="$PREFIX/bin/bash"
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:$PREFIX/etc/xdg"
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$_ROOT/local/share:$_ROOT/share:$XDG_DATA_HOME/mime"
    export CC='aarch64-linux-android-clang'
    umask 0077
else

    export SHELL=/bin/bash
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/usr/share/xsessions"
    # You forgot the one for snaps!
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_HOME/mime:$_ROOT/share:$_ROOT/share/xsessions:/var/lib/snapd/desktop:$XDG_DATA_HOME/flatpak:/var/lib/flatpak:$HOME/.local/share:/usr/share:/usr/xsessions/plasma:/usr/local/share:/usr/share/mime"
    pathadd "$_ROOT/lib/x86_64-linux-gnu/libexec"
    umask 0022
fi  # }}}

# GNU specified directory vars: {{{
# https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
export SYSCONFDIR="$_ROOT/etc"
export BINDIR="$_ROOT/bin"
export DATADIR="$_ROOT/share"
export DATAROOTDIR="$_ROOT/share"
# cscope
export INCDIR="$_ROOT/include"
export INCLUDEDIR="$_ROOT/include"
export INCLUDEDIRS="$_ROOT/include:$_ROOT/local/include"
export LD_LIBRARY_PATH="$_ROOT/lib:$_ROOT/local/lib:$HOME/.local/lib"
# }}}

# Pkgconfig: {{{
if [[ -d "$_ROOT/share/pkgconfig" ]]; then
    export PKG_CONFIG_PATH="$_ROOT/share/pkgconfig"
# TODO
# export PKG_CONFIG_PATH=/mnt/c/Users/faris/src/neovim/.deps/usr/lib/pkgconfig
# need a pathadd function for all these pkg_config dirs i'm finding
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$_ROOT/lib/x86_64-linux-gnu/pkgconfig"
fi

export CFLAGS="-I$_ROOT/include -I$_ROOT/local/include -I$HOME/.local/include"
# }}}

# Python: {{{

export PYTHONIOENCODING=utf-8:surrogateescape
export PYTHONDONTWRITEBYTECODE=1
export IPYTHONDIR="$HOME/.ipython"
export PYTHONCOERCECLOCALE=warn
if [[ -n "$(command -v ipdb)" ]];  then export PYTHONBREAKPOINT="ipdb"; fi
export PYTHONUNBUFFERED=1
# }}}

# Ruby: {{{
pathadd "$HOME/.gem/bin"
if [[ -n "$(command -v rvm)" ]]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    pathadd "$HOME/.rvm/bin"
    # shellcheck source=/home/faris/.rvm/scripts/rvm disable=1091
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_PATH:$GEM_HOME:$_ROOT/lib/ruby"  # idk if this is right
# }}}

# JavaScript: {{{
if [[ -n "$(command -v yarn)" ]]; then
    pathadd "$HOME/.yarn/bin"

    pathadd "$XDG_DATA_HOME/yarn/global/node_modules/.bin"

    if [[ -f "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash" ]]; then
        # shellcheck source=./.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash disable=1091
        source "$HOME/.local/share/yarn/global/node_modules/tldr/bin/autocompletion.bash"
    fi
fi
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_log.js"  # }}}

# Rust: {{{

# Remember to keep rust above the environment variables. If ./.cargo/bin isn't
# added to the path when we evaluate the PAGER var, then we end up with less
# even if we have bat installed.
firstpath "$HOME/.cargo/bin"

if [[ -f "$HOME/.ripgreprc" ]]; then export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"; fi
# }}}

# Go: {{{
# Also check out :Man go and !go env
if [[ -n "$(command -v go)" ]]; then
    export GOPATH="$HOME/go"
    export GOHOME="$HOME/go"
    export GOTMPDIR="/tmp"

    pathadd "$GOPATH/bin"
    pathadd "$_ROOT/local/go/bin"
fi # }}}

# Miscellaneous: {{{
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8                 # the python default
export LC_IDENTIFICATION=C          	# got this from `locale -c language` I don't know if set right
export LC_COLLATE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8              # man i3: Prevents program output translation
export LC_NUMERIC="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
pathadd "$_ROOT/games"

# From man bash - Bash Variables - lines ~1300
export PROMPT_DIRTRIM=3
export TIMEFORMAT=$'\nreal\t%3lR\nuser\t%3lU\nsys\t%3lS='
export EXECIGNORE=.dll,.mui,.config  # fuckin windows
# }}}

# Other Environment Variables: {{{

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ -n "$(command -v cheat)" ]];then
    export CHEATCOLORS=true
    export CHEATPATH="$HOME/python/tutorials:$HOME/python/site-packages:$CHEATPATH"
fi

# Idk if this is or isn't a bad idea
export LDFLAGS="$LDFLAGS -lm"
if [[ -d "/mnt/c/Users/faris/src/neovim/.deps/usr/lib" ]]; then  # literally only true on wsl in win10
   export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/mnt/c/Users/faris/src/neovim/.deps/usr/lib"
fi

# Emacs doesn't read Xresources files????
export XENVIRONMENT=~/.Xresources  # }}}

# Tmp: {{{
if [[ -n "$TMPDIR" ]]; then
    export TMP="$TMPDIR"
else
    if [[ -s "$_ROOT/tmp" ]]; then
        # don't have tmp set to more than one thing dingus
        export TMP="$_ROOT/var/tmp"
        export TMPDIR="$_ROOT/var/tmp"
    else
        export TMPDIR=/tmp
        export TMP=/tmp
    fi
fi
export TEMP="$TMP"  # }}}

# More other: {{{
if [[ -d "$HOME/.tmux" ]]; then export TMUXP_CONFIGDIR="$HOME/.tmux"; fi

export POWERSHELL_TELEMETRY_OPTOUT=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export CLOUDSDK_CORE_DISABLE_USAGE_REPORTING=1
export IHOPEYOUALLKNOWITHINKYOUAREFUCKINGCLOWNS=1
export CURL_HOME="$HOME/.config/curl/curlrc"
# Help find your dotfiles faster and setup nvim
export DOT="$HOME/projects/dotfiles"
export VICONF="$HOME/projects/viconf"
export NVIM_CONF="$HOME/.config/nvim"
export NVIM_LOG_FILE="$XDG_DATA_HOME/nvim/nvim.log"
export NVIM_PYTHON_LOG_FILE="$XDG_DATA_HOME/nvim/nvim_python.log"
export NVIMRUNTIME="$_ROOT/share/nvim/runtime"
pathadd "$_ROOT/local/bin"

export MANPAGER=bat
# }}}

# Source The Bashrc Last: {{{
# oh one last thing. why isn't this showing up???
shopt -s hostcomplete

# shellcheck source=/home/faris/.bashrc
if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi   # }}}

# Vim: set fdm=marker:
