#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# Necessary setup: {{{
# All the stuff that has to come first
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

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CACHE_DIRECTORY="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# }}}

# Platform_Dependant: {{{
# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi

if [[ -n "$TERM"  ]]; then
    if [[ -n "$TMUX" ]]; then
        export TERM='tmux-256color'
    else
        export TERM='xterm-256color'
    fi
fi

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

# Builds: {{{
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

if [[ -z "$PKG_CONFIG_PATH" ]]; then
    PKG_CONFIG_PATH=""
fi

# TODO: Really should come up with a functino similar to pathadd that does what
# I repeat 3 times in a row here
if [[ -d "$_ROOT/share/pkgconfig" ]]; then
    export PKG_CONFIG_PATH="$_ROOT/share/pkgconfig:$PKG_CONFIG_PATH"
fi

if [[ -d "$_ROOT/lib/x86_64-linux-gnu/pkgconfig" ]]; then
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$_ROOT/lib/x86_64-linux-gnu/pkgconfig"
fi

if [[ -d "$_ROOT/local/lib/pkgconfig" ]]; then
    export PKG_CONFIG_PATH="$_ROOT/local/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

# This is probably wrong
# export CFLAGS="-I$_ROOT/include -I$_ROOT/local/include -I$HOME/.local/include -fstack-protector-strong -O3 -Wno-unused-value -Wno-empty-body -Qunused-arguments -no-integrated-as"

if [[ -d "$_ROOT/lib/pkgconfig" ]]; then
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$_ROOT/lib/pkgconfig"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
test "$(command -v clang)" && export CC=clang; export CXX=clang++

# LDflags gets defined in here and as a result numpy fails to build
# export LDFLAGS="-L$_ROOT/lib -lm -L$_ROOT/local/lib -L$HOME/.local/lib -lncursesw -liconv -L$_ROOT/lib/python3.8/config-3.8/ -lpython3.8m -lcrypt -ldl -lreadline -i"
export LDFLAGS="-L$_ROOT/lib -L$_ROOT/local/lib -L$HOME/.local/lib -L$_ROOT/lib/python3.8/config-3.8 -lm -lcompiler_rt"
export INPUTRC="$HOME/.inputrc"
export NPY_NUM_BUILD_JOBS=1
if [[ -d "$_ROOT/share/pkgconfig" ]]; then export PKG_CONFIG_PATH="$_ROOT/share/pkgconfig"; fi
# }}}

# Python: {{{
# Put python first because we need conda initialized right away
export IPYTHONDIR="$HOME/.ipython"
export NPY_DISTUTILS_APPEND_FLAGS=1
export PYTHONCOERCECLOCALE=warn
export PYTHONDOCS="$HOME/python/official-python-docs/3.7/library/build/html"
export PYTHONDONTWRITEBYTECODE=1
export PYTHONIOENCODING=utf-8:surrogateescape
if [[ -n "$(command -v ipdb)" ]];  then export PYTHONBREAKPOINT="ipdb"; fi
# export PYTHONPROFILEIMPORTTIME=1
export PYTHONSTARTUP="$HOME/site_customize.py"
# This actually messes with prompt_toolkit pretty bad
export PYTHONUNBUFFERED=0
export RANGER_LOAD_DEFAULT_RC=False
# }}}

# Ruby: {{{
pathadd "$HOME/.gem/bin"
pathadd "$HOME/.gem/ruby/2.7.0/bin"
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
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_log.js"
export NODE_PRESERVE_SYMLINKS=1
# }}}

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

# Vim: {{{
if [[ -n "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"
export FCEDIT=nvim
# }}}

# Git: {{{

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM="auto verbose git"
export GIT_PS1_DESCRIBE_STYLE="tag"
# }}}

# Miscellaneous: {{{
export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8                # man i3: Prevents program output translation
export LC_IDENTIFICATION=C          	      # got this from `locale -c language` I don't know if set right
export LC_NUMERIC=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_TIME=en_US.UTF-8
# Python runtime initialized with LC_CTYPE=C (a locale with default ASCII
# encoding), which may cause Unicode compatibility problems. Using C.UTF-8,
# C.utf8, or UTF-8 (if available) as alternative Unicode-compatible locales
# is recommended.
export LC_CTYPE=en_US.UTF-8

pathadd "$_ROOT/games"
# From man bash - Bash Variables - lines ~1300
export PROMPT_DIRTRIM=3
export TIMEFORMAT=$'\nreal\t%3lR\nuser\t%3lU\nsys\t%3lS='
# A **colon-separated** list of shell patterns
export EXECIGNORE=.dll:.mui:.config  # fuckin windows
export FIGNORE=.dll:.mui:.config
export COLORTERM=truecolor

test "$(command -v clang)" && export CC=clang; export CXX=clang++

# Idk if this is or isn't a bad idea
export LDFLAGS="-L$_ROOT/lib -lm -L$_ROOT/local/lib -L$HOME/.local/lib"
# Emacs doesn't read Xresources files????
export XENVIRONMENT=~/.Xresources
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
export MANPAGER=bat
# export BAT_STYLE="OneHalfDark"
export PYGMENTIZE_STYLE="InkPot"
# }}}

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
export TEMP="$TMP"
export GREP_COLORS="ms=01;38;5;202:mc=01;31:sl=:cx=:fn=01;38;5;132:ln=32:bn=32:se=00;38;5;242"
# }}}

# Colors: {{{

export BLACK="\[\033[0;30m\]"
export BLACKBOLD="\[\033[1;30m\]"
export RED="\[\033[0;31m\]"
export REDBOLD="\[\033[1;31m\]"
export GREEN="\[\033[0;32m\]"
export GREENBOLD="\[\033[1;32m\]"
export YELLOW="\[\033[0;33m\]"
export YELLOWBOLD="\[\033[1;33m\]"
export BLUE="\[\033[0;34m\]"
export BLUEBOLD="\[\033[1;34m\]"
export PURPLE="\[\033[0;35m\]"
export PURPLEBOLD="\[\033[1;35m\]"
export CYAN="\[\033[0;36m\]"
export CYANBOLD="\[\033[1;36m\]"
export WHITE="\[\033[0;37m\]"
export WHITEBOLD="\[\033[1;37m\]"
export RESET="\033[0m"
export PS2="\001\033[32m\002  ...:\001$RESET\002 "
export LIGHT_RED="\[\e[91m\]"
export ORANGE="\[\e[38;5;208m\]"
# Different shade
export yellow="\[\e[38;5;214m\]"
export GREEN="\[\e[38;5;71m\]"
export UGREEN="\[\e[38;5;71;1;4m\]"
export SALMON="\[\e[38;5;167m\]"
export BROWN="\[\e[38;5;166m\]"
# }}}

# Source The Bashrc Last:
# shellcheck source=/home/faris/.bashrc
if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi

# Vim: set fdm=marker:
