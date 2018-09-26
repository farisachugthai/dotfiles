#!/usr/bin/env bash
# Maintainer: Faris Chugthai

# Functions to make the day a little easier
# Create a new directory and enter it
mk() {
    mkdir -p "$@" && cd "$@"
}

# Handy Extract Program
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

# Run cd and ls at once
cs () {
    cd "$@" && ls
}

# Decrypt the ssh priv key for the day
ssh-day () {
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        eval "$(ssh-agent -s)"
    fi
    ssh-add -t 86400
}

# Adds an alias to the current shell and to ~/.bashrc.d/alias
add-alias () {
   local name=$1 value="$2"
   echo alias "$name"="$value" >> ~/.bashrc.d/alias.bash
   eval alias "$name"="$value"
   alias "$name"
}

# Update the python packages you care about most
update-pip () {
    local pu="pip install -Uq"
    $pu pip
    $pu ipython
    $pu virtualenv
    $pu jedi
    $pu flake8
}

# I really don't like anything that smells like Emacs keybindings
infovi () {
    info "$1" | less
}

# From byobu
byobu_prompt_status() { local e=$?; [ $e != 0 ] && echo -e "$e "; }

# FZF:
# commits in a repo
fzf_commits() {
  git log --pretty=oneline --abbrev-commit | fzf --preview-window=right:50% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always' | cut -f 1 -d " "
}

# for existing man pages
fzf_apropos() {
  apropos '' | fzf --preview-window=right:50% --preview 'echo {} | cut -f 1 -d " " | xargs man' | cut -f 1 -d " "
}

# view EVERYTHING set in your env
fzf_env() {
    set | tr = "\t" | fzf | cut -f 1
}


fzf_nvim() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

tldrbox_cheat() {
    tldr -m "$1" >> "$HOME/.cheat/$1" && termux-share "$1"
}

tldropbox_dir() {
    tldr -m "$1" >> "$PWD/$1" && termux-share "$1"
}

conda_switch() {
    conda deactivate && conda activate "$1"
}

# TODO:
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
# fstash() {
#   local out q k sha
#   while out=$(
#     git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
#     fzf --ansi --no-sort --query="$q" --print-query \
#         --expect=ctrl-d,ctrl-b);
#   do
#     mapfile -t out <<< "$out"
#     q="${out[0]}"
#     k="${out[1]}"
#     sha="${out[-1]}"
#     sha="${sha%% *}"
#     [[ -z "$sha" ]] && continue
#     if [[ "$k" == 'ctrl-d' ]]; then
#       git diff $sha
#     elif [[ "$k" == 'ctrl-b' ]]; then
#       git stash branch "stash-$sha" $sha
#       break;
#     else
#       git stash show -p $sha
#     fi
#   done
# }
