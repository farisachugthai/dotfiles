#!/bin/bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

set -h
# this can get really annoying. good for debugging.
# set -u

# Don't run if not interactive: {{{
case $- in
    *i*);;
    *) exit 0;;
esac
# }}}

pathadd() {  # {{{
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

# $_ROOT: {{{
# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi  # }}}

# Python: {{{

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
# }}}

# Defaults in Ubuntu bashrcs: {{{
# .....have i really not set this?
export SHELL=/bin/bash 
export COLORTERM='16m'

bind -r "\C-c": self-insert
bind -r "\C-x": self-insert
bind -r "\C-\\": self-insert
bind -r "\C-^": self-insert
bind -f "$HOME/.inputrc"

if [[ -n "$TERM"  ]]; then
    export TERM='xterm-256color'
fi
# make less more friendly for non-text input files, see lesspipe(1)
# Also lesspipe is described in Input Preprocessors in man 1 less.
# This is raising in error in mintty and it's driving me nuts fix this later
[[ -z "$(command -v lesspipe.sh)" ]] && export LESSOPEN="|lesspipe.sh %s"; eval "$(lesspipe.sh)"

export GREP_COLORS="ms=01;38;5;202:mc=01;31:sl=:cx=:fn=01;38;5;132:ln=32:bn=32:se=00;38;5;242"
# }}}

# Vim: {{{
if [[ -n "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"
export FCEDIT=nvim
# Here because i include it on account of nvim
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
# }}}

# Builds: {{{

# Shellcheck
if [[ -n "$(command -v shellcheck)" ]]; then
  export SHELLCHECKOPTS='--shell=bash -X --exclude=SC2016'
fi
if [[ -d "$_ROOT/share/pkgconfig" ]]; then export PKG_CONFIG_PATH="$_ROOT/share/pkgconfig"; fi
test "$(command -v luarocks)" && eval "$(luarocks path --bin)"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# }}}

# History: {{{

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

# Shopt and set: {{{

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
# if a pipe fails it returns the far most right expr which could be 0.
# stop that shit let me know what the err code was!
shopt -s lastpipe

# ** will match all files and zero or more directories and subdirectories.
# shellcheck disable=SC2128
if [[ $BASH_VERSINFO -gt 3 ]]; then shopt -s globstar; fi

# If an attempt is made to exit bash , list currently running jobs, their status and a warning
shopt -s checkjobs

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
shopt -s nocasematch
set -o noclobber    # Still dont want to clobber things
shopt -s xpg_echo   # Allows echo to read backslashes like \n and \t
shopt -s dirspell   # Autocorrect the spelling if it can
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
# }}}

# Less And $PAGER --- Checkout .lesskey for more {{{

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
export LESS_TERMCAP_me=$(printf '\e[0m')       # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m')       # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[03;38;5;202m') # enter standout mode – orange background highlight (or italics)
export LESS_TERMCAP_ue=$(printf '\e[0m')       # leave underline mode
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

if [[ -n "$(command -v yarn)" ]]; then
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# }}}

# Fasd: {{{1

fasd_cache="$HOME/.fasd-init-bash"
if [[ -n "$(command -v fasd)" ]]; then
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install > "$fasd_cache"
    fi
    source "$fasd_cache"
fi

# }}}

# Completions: {{{

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

# This allows set to behave slightly more as expected
complete -A setopt -A shopt  set

# this is good to konw about
# complete -F _known_hosts traceroute
complete -F _known_hosts -A hostname -F _longopt ssh

obviously_a_terrible_idea() {
    for i in /usr/share/bash-completion/completions/*; do
        source "$i"
    done
}

# }}}

# Sourced files: {{{
# shellcheck source=/usr/share/bash-completion/bash_completion
test  -f "$_ROOT/share/bash-completion/bash_completion" && source "$_ROOT/share/bash-completion/bash_completion"

firstpath "$HOME/bin"
firstpath "$HOME/.local/bin"

# add some cool colors to ls
eval "$( dircolors -b $HOME/.dircolors )"

if [[ -d ~/.bashrc.d ]]; then
    for config in $HOME/.bashrc.d/*.bash; do
    # shellcheck source=/home/faris/.bashrc.d/*.bash
    source $config;
    done
    unset -v config
fi

if [[ -f "$HOME/.bashrc.local" ]]; then
    # shellcheck source=/home/faris/.bashrc.local
    . "$HOME/.bashrc.local"
fi
# }}}

# Prompt: {{{
export RESET="\033[0m"
export PS2="\001\033[32m\002  ...:\001$RESET\002 "
export RED="\[\e[31m\]"
export LIGHT_RED="\[\e[91m\]"
export ORANGE="\[\e[38;5;208m\]"
export yellow="\[\033[0;33m\]"
export YELLOW="\[\e[38;5;214m\]"
export GREEN="\[\e[38;5;71m\]"
export UGREEN="\[\e[38;5;71;1;4m\]"
export SALMON="\[\e[38;5;167m\]"
export BROWN="\[\e[38;5;166m\]"
export CYAN="\[\e[36m\]"
export WHITE="\[\e[97m\]"
export BLUE="\[\e[38;5;116m\]"

git_branch() {
    if branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"; then
        [[ -n "$(git status --porcelain 2> /dev/null)" ]] && echo -n "\[$LIGHT_RED\]Dirty: "
        echo -ne "\[$CYAN\]$branch "
        # Idk if this is a new sub command but i just found it with git 2.25.1 and its neat
        if [[ -n "$(command -v git show-branch)" ]]; then 
            echo -en "\[$GREEN\]$(git show-branch --color=always --reflog=1)"
        fi
    fi
}

_status() {
    local error="$?"
    [[ $error != 0 ]] && echo -en "\[$RED\]$error"
}

uhw() {
    # Named so because the standard escapes in a prompt are \u@\h \w
    # You know. For username, hostname, working directory.
    echo -n "\[$WHITE\]\u @ \[$BLUE\]\h \[$BROWN\]\w "

    [[ -n "$VIRTUAL_ENV" ]] && echo -n "\[$ORANGE\]$(basename $VIRTUAL_ENV) "

    # Why the fuck is \A a timestamp you may say? I don't know.
    echo -n "\[$YELLOW\]\A "
    # Just realized that \$ is the root normal user check that symbol used to be
    # Also \j is jobs. i really didn't need that job function either!
    echo -n "\[$SALMON\]\j "
}

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose git"
export GIT_PS1_DESCRIBE_STYLE="tag"
# TODO: removing $(git_branch) for the time being because this shit doesn't
# re-evaluate when you change dir... Which is shitty because the cwd does
# so it's objectively possible but idk how or what to do.

# I don't know why quoting it like this makes it work but trust me when i say
# EVERYTHING broke the more obvious way
export PS1='$(__git_ps1)'"$(_status) $(uhw)\n\[$UGREEN\]In [\#] \[$RED\]\$ \[$RESET\]"

# I got so close. But i don't even know how to debug whatever problem the
# below is having
# export PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$yellow`basename $VIRTUAL_ENV`$RESET]}" "$PS1 \\\$" "[%s]"'
# }}}

# Vim: set foldlevelstart=0 fdm=marker et sw=4 sts=4 ts=4:
