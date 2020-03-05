#!/bin/bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

set -h
# this can get really annoyijg. good for debugging.
# set -u

bind -r "\C-c": self-insert
bind -r "\C-x": self-insert
bind -r "\C-\\": self-insert
bind -r "\C-^": self-insert
bind -f ~/.inputrc

# Don't run if not interactive: {{{1
case $- in
    *i*);;
    *) exit 0;;
esac
# }}}

pathadd() {  # {{{1
    if [ -d "$1" ] && [ ":$PATH:" != *":$1:"* ]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# IDK if this is working correctly .local bin isnt in termuxs path
firstpath() {
    # Check if a dir exists and if it does, prepend it to the $PATH.
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:${PATH:+"$PATH"}"
    fi
}  # }}}

# $_ROOT: {{{1
# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi  # }}}

# Python: {{{1

export PYTHONASYNCIODEBUG=1
# Put python first because we need conda initialized right away
export PYTHONDONTWRITEBYTECODE=1
# LDflags gets defined in here and as a result numpy fails to build
export NPY_DISTUTILS_APPEND_FLAGS=1
export PYTHONDOCS="$HOME/python/official-python-docs/3.7/library/build/html"
export PYTHONIOENCODING=utf-8:surrogateescape
export IPYTHONDIR="$HOME/.ipython"
export PYTHONCOERCECLOCALE=warn

if [[ -n "$(command -v ipdb)" ]];  then export PYTHONBREAKPOINT="ipdb"; fi
# This actually messes with prompt_toolkit pretty bad
export PYTHONUNBUFFERED=0
export RANGER_LOAD_DEFAULT_RC=False

# >>> conda initialize >>>  {{{
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
        source "$HOME/miniconda3/etc/profile.d/conda.sh"
        # commented out by conda initialize
    elif [[ -d "$HOME/miniconda3/bin" ]]; then
        pathadd "$HOME/miniconda3/bin"
    fi
fi
unset __conda_setup
# }}}

# GCloud: {{{

if [[ -d ~/google-cloud-sdk ]]; then
    # shellcheck source=~/google-cloud-sdk/completion.bash.inc
    source "$HOME/google-cloud-sdk/completion.bash.inc"
    # shellcheck source=~/google-cloud-sdk/path.bash.inc
    source "$HOME/google-cloud-sdk/path.bash.inc"
fi   # }}}

# Defaults in Ubuntu bashrcs: {{{

# make less more friendly for non-text input files, see lesspipe(1)
# Also lesspipe is described in Input Preprocessors in man 1 less.
# This is raising in error in mintty and it's driving me nuts fix this later
# [[ -z "$(command -v lesspipe.sh)" ]] && export LESSOPEN="|lesspipe.sh %s"; eval "$(SHELL=/bin/bash lesspipe.sh)"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

export GREP_COLORS="ms=01;38;5;202:mc=01;31:sl=:cx=:fn=01;38;5;132:ln=32:bn=32:se=00;38;5;242"
# }}}
# }}}

# Vim: {{{1

if [[ -n "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"

export FCEDIT=nvim
# }}}

# Builds: {{{1

# Shellcheck
if [[ -n "$(command -v shellcheck)" ]]; then
  export SHELLCHECKOPTS='--shell=bash -X --exclude=SC2016'
fi
if [[ -d "$_ROOT/share/pkgconfig" ]]; then export PKG_CONFIG_PATH="$_ROOT/share/pkgconfig"; fi
test "$(command -v luarocks)" && eval "$(luarocks path --bin)"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# }}}

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
shopt -s histverify
# So on a related note let's set up shell options
# }}}

# Shopt and set: {{{1

set -o vi
# To check what options you've set with set, check the output of: $: echo $-
# Don't just run `set` on the command line! It'll echo every var that's been set.
# As of Aug 28, 2019 I got: bhimBCHs
# Also you can run set -o
set -o histexpand
# set -o keyword  don't ever set it echoes EVERYTHING
# set -o nounset Autocompletion gets annoying
shopt -s autocd
shopt -s dotglob
shopt -s checkhash

# I always forget keep this below set -o vi!
# Dont know how i never thought source my shit first
[[ -f ~/.bashrc.d/fzf.bash ]] && source ~/.bashrc.d/fzf.bash
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Be notified of asynchronous jobs completing in the background
set -o notify

# Check the window size after each command and update the values of LINES and COLUMNS.
# Now the default in Bash 5!!!
shopt -s checkwinsize

# Why the hell does termux have this listed as off?
# if a pipe fails it returns the far most right expr which could be 0. stop that shit let me know what the err code was!
shopt -s lastpipe

# ** will match all files and zero or more directories and subdirectories.
# shellcheck disable=SC2128
if [[ $BASH_VERSINFO -gt 3 ]]; then shopt -s globstar; fi

# If an attempt is made to exit bash , list currently running jobs, their status and a warning
shopt -s checkjobs

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
shopt -s nocasematch
set -o noclobber        # Still dont want to clobber things
shopt -s xpg_echo       # Allows echo to read backslashes like \n and \t
shopt -s dirspell       # Autocorrect the spelling if it can
shopt -s cdspell

# This should be enabled by default but termux is listing it as off
shopt -s hostcomplete

# If you try to complete something that isn't a command, check if its an alias
if [[ $BASH_VERSINFO -gt 4 ]]; then shopt -s progcomp_alias; fi

# Print verbose error messages when using shift
shopt -s shift_verbose

shopt -s no_empty_cmd_completion
# If set, and the cmdhist option is enabled, multi-line commands are saved to
# the history with embedded newlines rather than using semicolon separators
shopt -s lithist cmdhist
shopt -s direxpand
# if a pipe fails it returns the far most right expr which could be 0. stop that shit let me know what the err code was!
shopt -s lastpipe
# }}}

# Less And $PAGER --- Checkout .lesskey for more {{{1
export COLORTERM="truecolor"
# I think the lowercase r is messing bat up on wsl
export PAGER="less -JRKMrLigeFW"
export LESSHISTSIZE=5000  # default is 100

LESSOPEN="|lesspipe.sh %s"; export LESSOPEN
export LESSCOLORIZER=pygmentize
# Oh shit! --mouse is a bash>5 feature!
if [[ $BASH_VERSINFO -gt 4 ]]; then export PAGER="$PAGER --mouse --no-histdups --save-marks "; fi

export LESSCHARSET=utf-8
export LESS='-JRKMrLIgeFW  -j0.5 --no-histdups --save-marks --follow-name'

export BAT_PAGER="less $LESS"
export LESS_TERMCAP_mb=$(printf '\e[01;31m')       # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;38;5;180m') # enter double-bright mode – bold light orange
export LESS_TERMCAP_me=$(printf '\e[0m')           # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m')           # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[03;38;5;202m') # enter standout mode – orange background highlight (or italics)
export LESS_TERMCAP_ue=$(printf '\e[0m')           # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;139m') # enter underline mode – underline aubergine
# }}}

# JavaScript: {{{1

# Export nvm if the directory exists
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    # shellcheck source=/home/faris/.nvm/nvm.sh
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" # This loads nvm
    # shellcheck source=/home/faris/.nvm/bash_completion
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
    pathadd "$HOME/.nvm"  # Not a ton of good reasons but good to see it in path
    npm config delete prefix
    nvm use default --delete-prefix
fi
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_log.js"
export NODE_PRESERVE_SYMLINKS=1
# }}}

# Fasd: {{{1

fasd_cache="$HOME/.fasd-init-bash"
if [[ -n "$(command -v fasd)" ]]; then
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install > "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
fi

# }}}

# Completions: {{{1

# dynamic completions. from man bash
_completion_loader()
{
    # source the bash-completions directory as needed
    . "$_ROOT/share/bash_completion/completions/*" >/dev/null 2>&1 && return 124
}

# oh also fzf
complete -D -F _completion_loader -o bashdefault -o  default -o plusdirs -A command -F _fzf_complete

# modify how completions are created by default
compopt -D -o bashdefault -o dirnames -o plusdirs -o default

# From /usr/share/doc/bash/README.md.bash-completion
export COMP_CONFIGURE_HINTS=1

# Here's one for the terminal
if [[ -n "$(command -v kitty)" ]]; then
    source <(kitty + complete setup bash)
fi

# Just figured this one out! Especially useful as I've been building universal-ctags from source
complete -o bashdefault -o default -F _longopt ctags

# I'm embarrassed by how happy figuring this out made me
test "$(command -v dlink2)" && complete -o bashdefault -o default -F _fzf_path_completion dlink2

complete -o bashdefault -o default -F _longopt -F _fzf_path_completion du
complete -o bashdefault -o default -A alias -F _fzf_alias_completion alias
complete -o bashdefault -o default -F _longopt  -F _fzf_path_completion nvim

# }}}

# Sourced files: {{{1

# shellcheck source=/usr/share/bash-completion/bash_completion
test  -f "$_ROOT/share/bash-completion/bash_completion" && source "$_ROOT/share/bash-completion/bash_completion"

if [[ -d ~/.bashrc.d ]]; then
    for config in $HOME/.bashrc.d/*.bash; do
        # shellcheck source=/home/faris/.bashrc.d/*.bash
        source $config;
    done
    unset -v config
fi

firstpath "$HOME/bin"
firstpath "$HOME/.local/bin"

# add some cool colors to ls
eval "$( dircolors -b $HOME/.dircolors )"

export _term_reset="\033[0m"
# This is ugly because not only do we have a bunch of ansi escape
# sequences, but we also have to wrap each escape code in \001 and \002
# for readline to be able to insert history matches properly.
export prompt_in2="\001\033[32m\002      ...:\001$_term_reset\002 "
export PS2=$prompt_in2

# export PS1="\u@\h \w \@ \n \001\033[32m\002In [\001\033[32;1m\002 \# \001\033[0;32m\002] \$:\001$_term_reset\002 "
# }}}

# Prompt: {{{

function git_branch() {
    if branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"; then
        echo -n " $branch"
        [ -n "$(git status --porcelain 2> /dev/null)" ] && echo -n '*'
    fi
}

function job_count() {
  local count=$(jobs | wc -l)
  printf -v spaces "%${count}s" ' '
  (($count > 0)) && echo " ${spaces// /&}";
}

export green=$(tput setaf 2)
export red=$(tput setaf 1)
export yellow=$(tput setaf 3)
export idk=$(tput setaf 4)
export neither=$(tput setaf 5)
export cyan=$(tput setaf 6)
export normal=$(tput sgr0)

export PS1="\[\e[31m\]$(byobu_prompt_status)\[\e[00;32m\]\u\[$neither\]@\h \w \@ \[$cyan\] $(git_branch) \[$red\] $(job_count)\n\[$green\] In [\#]\[$normal\] \$: "

if [[ -f "$HOME/.bashrc.local" ]]; then
    # shellcheck source=/home/faris/.bashrc.local
    . "$HOME/.bashrc.local"
fi
# }}}

# byobu: {{{
case "$TERM" in
    xterm)
        # Try to ensure we have 256 colors
        export TERM="xterm-256color"
    ;;
esac

if [ -n "$TMUX" ] || [ "${TERMCAP#*screen}" != "${TERMCAP}" ]; then

    # Ensure that we're in bash, in a byobu environment
if [ -n "$BYOBU_BACKEND" ] && [ -n "$BASH" ]; then

byobu_prompt_status() {
    local e=$?; [ $e != 0 ] && echo -e "$e ";
}
[ -n "$BYOBU_CHARMAP" ] || BYOBU_CHARMAP=$(locale charmap 2>/dev/null || echo)

byobu_prompt_symbol() {
    if [ "$USER" = "root" ]; then
        printf "%s" "#";
    else
        printf "%s" "\$"
    fi
}

# Use Googley colors (blue / red / yellow / blue / green / red )
PS1="${debian_chroot:+($debian_chroot)}\[\e[31m\]\$(byobu_prompt_status)\[\e[38;5;69m\]\u\[\e[38;5;214m\]@\[\e[38;5;167m\]\h\[\e[38;5;214m\]:\[\e[38;5;71m\]\w\[\e[38;5;214m\]\$(byobu_prompt_symbol)\[\e[00m\] "
fi
fi
# Vim: set foldlevelstart=0 fdm=marker:
