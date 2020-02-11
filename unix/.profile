#!/bin/bash
# Initialization file for login, non-interactive shell
# Maintainer: Faris Chugthai

# Pathadd: {{{
pathadd() {
    # https://superuser.com/a/39995
    # Note that PATH should already be marked as exported, so reexporting is not needed.
    # This checks whether the directory exists & is a directory before adding it, which you may not care about.
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}   # }}}

# Platform_Dependant: {{{

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
    export CFLAGS="-I$_ROOT/include -I$_ROOT/local/include -I$HOME/.local/include"
    export CC='aarch64-linux-android-clang'
    umask 0077
else

    export SHELL=/bin/bash
    export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:/usr/share/xsessions"
    # You forgot the one for snaps!
    export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_HOME/mime:$_ROOT/share:$_ROOT/share/xsessions:/var/lib/snapd/desktop:$XDG_DATA_HOME/flatpak:/var/lib/flatpak:$HOME/.local/share:/usr/share:/usr/xsessions/plasma:/usr/local/share:/usr/share/mime"
    pathadd "$_ROOT/lib/x86_64-linux-gnu/libexec"
    export CFLAGS="-I$_ROOT/include -I$_ROOT/local/include -I$HOME/.local/include"
    umask 0022
fi  # }}}

# GNU specified directory vars: {{{
# https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
if [[ -n "$ANDROID_DATA" ]]; then
    export SYSCONFDIR="$PREFIX/etc"
    export BINDIR="$PREFIX/bin"
    export DATADIR="$PREFIX/share"
    export DATAROOTDIR="$PREFIX/share"
    # cscope
    export INCDIR="$PREFIX/include"
    export INCLUDEDIR="$PREFIX/include"
    export INCLUDEDIRS="/usr/include:/usr/local/include"
    export LD_LIBRARY_PATH="$_ROOT/lib:$_ROOT/local/lib:$HOME/.local/lib"
else
    export SYSCONFDIR="/etc"
    export BINDIR="/usr/bin"
    export DATADIR="/usr/local/share"
    export DATAROOTDIR="/usr/share"
    export INCDIR="/usr/include"
    export INCLUDEDIR="/usr/include"
    export INCLUDEDIRS="/usr/include:/usr/local/include"
fi  # }}}

# Pkgconfig: {{{
if [[ -d "$_ROOT/share/pkgconfig" ]]; then
    export PKG_CONFIG_PATH="$_ROOT/share/pkgconfig"
# TODO
# export PKG_CONFIG_PATH=/mnt/c/Users/faris/src/neovim/.deps/usr/lib/pkgconfig
# need a pathadd function for all these pkg_config dirs i'm finding
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$_ROOT/lib/x86_64-linux-gnu/pkgconfig"
fi  # }}}

# Pathadds --- User dirs first: {{{1

# Set PATH so it includes user's private bin directories and set them first in path
pathadd "$HOME/bin"
pathadd "$HOME/.local/bin" # }}}

# Python: {{{

export PYTHONIOENCODING=utf-8:surrogateescape
export PYTHONDONTWRITEBYTECODE=1
export IPYTHONDIR="$HOME/.ipython"
export PYTHONCOERCECLOCALE=warn
if [[ -n "$(command -v ipdb)" ]];  then export PYTHONBREAKPOINT="ipdb"; fi
export PYTHONUNBUFFERED=1  # }}}

# Ruby: {{{
pathadd "$HOME/.gem/bin"
if [[ -n "$(command -v rvm)" ]]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    pathadd "$HOME/.rvm/bin"
    # shellcheck source=/home/faris/.rvm/scripts/rvm disable=1091
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_PATH:$GEM_HOME:$_ROOT/lib/ruby"  # idk if this is right }}}

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
pathadd "$HOME/.cargo/bin"

if [[ -f "$HOME/.ripgreprc" ]]; then export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"; fi # }}}

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
export EXECIGNORE=.dll  # fuckin windows

# }}}

# Other Environment Variables: {{{1

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
    if [[ -s "_ROOT/tmp" ]]; then
        # don't have tmp set to more than one thing dingus
        export TMP="$_ROOT/var/tmp"
        export TMPDIR="$_ROOT/var/tmp"
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
export VICONF="$HOME/projects/viconf/.config/nvim"
export NVIM_CONF="$HOME/.config/nvim"
export NVIM_LOG_FILE="$XDG_DATA_HOME/nvim/nvim.log"
export NVIM_PYTHON_LOG_FILE="$XDG_DATA_HOME/nvim/nvim_python.log"
export NVIMRUNTIME="$_ROOT/share/nvim/runtime"
pathadd "$_ROOT/local/bin"  # }}}

# Pager Colors: {{{1


# Thank byobu for these ones. Man pages now look pretty awesome
export GREP_COLORS="ms=01;38;5;202:mc=01;31:sl=:cx=:fn=01;38;5;132:ln=32:bn=32:se=00;38;5;242"
export LESS_TERMCAP_mb=$(printf '\e[01;31m')       # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;38;5;180m') # enter double-bright mode – bold light orange
export LESS_TERMCAP_me=$(printf '\e[0m')           # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m')           # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[03;38;5;202m') # enter standout mode – orange background highlight (or italics)
export LESS_TERMCAP_ue=$(printf '\e[0m')           # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;139m') # enter underline mode – underline aubergine
# }}}

# Source The Bashrc Last: {{{
# oh one last thing. why isn't this showing up???
shopt -s hostcomplete

# shellcheck source=/home/faris/.bashrc
if [[ -f "$HOME/.bashrc" ]]; then . "$HOME/.bashrc"; fi   # }}}

# Vim: set fdm=marker:
