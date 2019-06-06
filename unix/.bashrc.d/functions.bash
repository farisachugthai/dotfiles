#!/usr/bin/env bash
# Maintainer: Faris Chugthai

# Functions to make the day a little easier

# mk: Create a new directory and enter it: {{{1
mk() {
    mkdir -pv "$@" && cd "$@" || exit
}

# extract: Handy Extract Program: {{{1
extract() {
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

# cs: Run cd and ls at once: {{{1
cs () {
    cd "$@" && ls -F
}

# ssh-day: Decrypt the ssh priv key for the day: {{{1
ssh-day () {
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        eval "$(ssh-agent -s)"
    else
        export SSH_AUTH_SOCK=''
        eval "$(ssh-agent -s)"
    fi
    ssh-add
}

# add-alias: Adds an alias to the current shell and to ~/.bashrc.d/alias: {{{1
add-alias () {
   local name=$1 value="$2"
   echo alias "$name"="$value" >> ~/.bashrc.d/alias.bash
   eval alias "$name"="$value"
   alias "$name"
}

# update-pip: Update the python packages you care about most: {{{1
update-pip () {
    local pu="pip install -Uq"
    $pu pip
    $pu ipython
    $pu virtualenv
    $pu jedi
    $pu flake8
}

# infovi: Send info to less for more reasonable keybindings: {{{1
infovi () {
    info "$1" | "$PAGER"
}

# byobu_prompt_status: From byobu: {{{1
byobu_prompt_status() { local e=$?; [ $e != 0 ] && echo -e "$e "; }


# Dropbox: {{{1
tldrbox_cheat() {
    tldr -m "$1" >> "$HOME/.cheat/$1" && termux-share "$1"
}

tldropbox_dir() {
    tldr -m "$1" >> "$PWD/$1" && termux-share "$1"
}

# Python / Environment Managers: {{{1
conda_switch() {
    conda deactivate && conda activate "$1"
}

# gpip: global pip. Disable required virtualenvs: {{{1
# Feb 21, 2019: gpip2 and gpip3 added
gpip() {
    export PIP_REQUIRE_VIRTUALENV=0;
    python -m pip "$@";
    export PIP_REQUIRE_VIRTUALENV=1 > /dev/null
}

gpip2() {
    export PIP_REQUIRE_VIRTUALENV=0;
    python2 -m pip "$@";
    export PIP_REQUIRE_VIRTUALENV=1 > /dev/null
}

gpip3() {
    export PIP_REQUIRE_VIRTUALENV=0;
    python3 -m pip "$@";
    export PIP_REQUIRE_VIRTUALENV=1 > /dev/null
}
# Oct 04, 2018
# in a manner similar to __fzf__history__ display all of hist to std out
# noninteractive tho
# hist_std_out: Edit previously run commands: {{{1
hist_std_out() {
    fc -nl 1 "$HISTFILESIZE"
}

# Other TODO: Possibly rewrite the man function here. IE if nvim then do that,
# elif most, else less

# bak: Back up a file using bracket expansion I.E. mv foo.py foo.py.bak: {{{1
bak() {
    mv $1{,.bak}
}

# nman: send `man` to nvim: {{{1
# I'm also gonna make it so that it stops shadowing the builtin. You have the choice if you want.
nman(){
    nvim -c "Man $1" -c'wincmd T'
}

# tre: tree with way too many options to memorize: {{{1
tre(){
    # Let's review a few of these options.
    # -L is max dir depth
    # -F:
    # Append a `/' for directories, a `=' for socket files, a `*' for
    # executable files, a `>' for doors (Solaris) and a `|' for
    # FIFO's, as per ls -F
    # Also, and I don't know why, the a and I must be together to ignore .git
    # In addition they MUST come last or .git gets included. Idk why man
    tree  -I '__pycache__' -I 'node_modules' --dirsfirst -h -L 5 -F -aI '.git'
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. {{{1
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# lk: {{{1 show symbolic links using fd or fallback to grep
function lk {
    if [[ -n "$(fd)" ]]; then
        ls -Fo --color=always -A "$@" | fd --type link --maxdepth 1 --hidden --color always
    else
        ls -Fo --color=always "$@" | grep ^l
    fi
}
