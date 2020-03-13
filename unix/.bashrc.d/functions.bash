#!/bin/bash
# Maintainer: Faris Chugthai

# Functions to make the day a little easier

mk() {  # mk: Create a new directory and enter it: {{{1
    mkdir -pv "$@" && cd "$@" || exit
}
# }}}

extract() {  # extract: Handy Extract Program: {{{1
if [ -f "$1" ]; then
    case "$1" in
        *.tar.bz2) tar xvjf "$1" ;;
        *.tar.gz) tar xvzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xvf "$1" ;;
        *.tbz2) tar xvjf "$1" ;;
        *.tgz) tar xvzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.tar.xz) tar xvf "$1" ;;
    # Alternatively you could run xz -d file.tar.xz; tar xvf file.tar
        *) echo "'$1' cannot be extracted via >extract<" ;;
    esac
else
    echo "'$1' is not a valid file!"
fi
}
# }}}

cs () {  # cs: Run cd and ls at once: {{{1
    cd "$@" && ls -F
}
# }}}

ssh-day () {  # ssh-day: Decrypt the ssh priv key for the day: {{{1
    gpg-agent --daemon -v -s --enable-ssh-support

    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        eval "$(ssh-agent -s)"
    else
        export SSH_AUTH_SOCK=''
        eval "$(ssh-agent -s)"
    fi
    ssh-add
}
# }}}

add-alias () {  # add-alias: Adds an alias to the current shell and to ~/.bashrc.d/alias: {{{1
   local name=$1 value="$2"
   echo alias "$name"="$value" >> ~/.bashrc.d/alias.bash
   eval alias "$name"="$value"
   alias "$name"
}
# }}}

update-pip () {  # update-pip: Update the python packages you care about most: {{{1
    local pu="pip install -Uq"
    $pu pip
    $pu ipython
    $pu virtualenv
    $pu jedi
    $pu flake8
}
# }}}

# infovi: Send info to less for more reasonable keybindings: {{{1
infovi () {
    info "$1" | "$PAGER"
}
# }}}

# Dropbox: {{{1
tldrbox_cheat() {
    tldr -m "$1" >> "$HOME/.cheat/$1" && termux-share "$1"
}
# }}}

tldropbox_dir() {  # {{{
    tldr -m "$1" >> "$PWD/$1" && termux-share "$1"
}
# }}}

# Python / Environment Managers: {{{1
conda_switch() {
    conda deactivate && conda activate "$1"
}
# }}}

# gpip: global pip. Disable required virtualenvs: {{{1
# Feb 21, 2019: gpip2 and gpip3 added
gpip() {
    export PIP_REQUIRE_VIRTUALENV=0;
    python -m pip "$@";
    export PIP_REQUIRE_VIRTUALENV=1 > /dev/null
}
# }}}

gpip2() {  # {{{
    export PIP_REQUIRE_VIRTUALENV=0;
    python2 -m pip "$@";
    export PIP_REQUIRE_VIRTUALENV=1 > /dev/null
}
# }}}

gpip3() {  # {{{
    export PIP_REQUIRE_VIRTUALENV=0;
    python3 -m pip "$@";
    export PIP_REQUIRE_VIRTUALENV=1 > /dev/null
}
# }}}
# Oct 04, 2018
# in a manner similar to __fzf__history__ display all of hist to std out
# noninteractive tho
# hist_std_out: Edit previously run commands: {{{1
hist_std_out() {
    fc -nl 1 "$HISTFILESIZE"
}
# }}}

# Other TODO: Possibly rewrite the man function here. IE if nvim then do that,
# elif most, else less

# bak: Back up a file using bracket expansion I.E. mv foo.py foo.py.bak: {{{1
bak() {
    mv $1{,.bak}
}
# }}}

# nman: send `man` to nvim: {{{1
# I'm also gonna make it so that it stops shadowing the builtin. You have the choice if you want.
nman(){
    nvim -c "Man $1" -c'wincmd T'
}
# }}}

# lk: {{{1 show symbolic links using fd or fallback to grep
lk() {
    if [[ -n "$(command -v fd)" ]]; then
        ls -Fo --dereference -A "$@" | fd --type symlink --maxdepth 1
    else
        ls -Fo "$@" | grep ^l
    fi
}
# }}}

# ssh-agent: {{{1
# Refactored https://help.github.com/en/articles/working-with-ssh-key-passphrases
# to be one function and make variables they unset local so we don't need to
setup_ssh() {
    local env
    env=~/.ssh/agent.env

    test -f "$env" && . "$env" >| /dev/null || break
    # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
    agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

    if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        (umask 077; ssh-agent >| "$env")
        . "$env" >| /dev/null
        ssh-add
    elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
    fi
}
# }}}

filetree() {  # {{{1
    if [[ -n "$1" ]]; then
        ls -R "$1" | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'
    else
        ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'
    fi
}
# }}}

recursive_line_count() {  # {{{1
    if [[ -z "$1" ]]; then
        fd -H --follow -t f . | xargs cat | wc -l
    else
        fd -H --follow -t f . "$1" | xargs cat | wc -l
    fi
}
# }}}
