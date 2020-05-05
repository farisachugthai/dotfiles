#!/bin/bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

# Setup: {{{
case $- in
    *i*);;
    *) exit 0;;
esac

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

# shellcheck disable=2153
if [[ -n "$PREFIX" ]]; then
    export _ROOT="$PREFIX"
else
    export _ROOT="/usr"
fi
# }}}

# Builds: {{{
[[ -z "$(command -v lesspipe.sh)" ]] && export LESSOPEN="|lesspipe.sh %s"; eval "$(lesspipe.sh)"

# Shellcheck
if [[ -n "$(command -v shellcheck)" ]]; then
  export SHELLCHECKOPTS='--shell=bash -X --exclude=SC2016'
fi

test "$(command -v luarocks)" && eval "$(luarocks path --bin)"

export BYOBU_CONFIG_DIR="$HOME/.config/byobu"
export BYOBU_PREFIX_DIR="$_ROOT/share/byobu"
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
set -o emacs
# To check what options you've set with set, check the output of: $: echo $-
# Don't just run `set` on the command line! It'll echo every var that's been set.
# As of Aug 28, 2019 I got: bhimBCHs
# Also you can run set -o
set -o histexpand
# set -o keyword  don't ever set it echoes EVERYTHING
# set -o nounset Autocompletion gets annoying
shopt -s autocd cdable_vars
shopt -s dotglob hostcomplete
shopt -u failglob
shopt -s checkhash
shopt -s hostcomplete
shopt -s extdebug
shopt -s extglob extquote
set -o pipefail
# I always forget keep this below set -o vi!
# Dont know how i never thought source my shit first
[[ -f ~/.bashrc.d/fzf.bash ]] && source ~/.bashrc.d/fzf.bash
# source this directly from the .inputrc so that when we update the
# keybindings we dont lose our fzf bindings. that raises an error.
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

bind -f "$HOME/.inputrc"

# Be notified of asynchronous jobs completing in the background
set -o notify
set -ha
shopt -s checkwinsize
shopt -s lastpipe
# shellcheck disable=SC2128
if [[ $BASH_VERSINFO -gt 3 ]]; then shopt -s globstar; fi
shopt -s checkjobs

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
shopt -s nocasematch
set -o noclobber    # Still dont want to clobber things
shopt -s xpg_echo   # Allows echo to read backslashes like \n and \t
shopt -s dirspell   # Autocorrect the spelling if it can
shopt -s cdspell

# If you try to complete something that isn't a command, check if its an alias
if [[ $BASH_VERSINFO -gt 4 ]]; then shopt -s progcomp_alias; fi

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
lesskey -o ~/.lesskey.output ~/.lesskey
export LESS="-JRKMrLIgeFW  -j0.5 --no-histdups --save-marks --follow-name -k $HOME/.lesskey.output"

export BAT_PAGER="less $LESS"
export LESS_TERMCAP_mb=$(printf '\e[01;31m')       # enter blinking mode ... red
export LESS_TERMCAP_md=$(printf '\e[01;38;5;180m') # enter double-bright mode ... bold light orange
export LESS_TERMCAP_me=$(printf '\e[0m')       # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m')       # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[03;38;5;202m') # enter standout mode ... orange background highlight (or italics)
export LESS_TERMCAP_ue=$(printf '\e[0m')       # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;139m') # enter underline mode ... underline aubergine
# }}}

# JavaScript: {{{

# Export nvm if the directory exists
if [[ -d "$HOME/.config/nvm" ]]; then
    export NVM_DIR="$HOME/.config/nvm"
elif [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
fi

# shellcheck source=/home/faris/.nvm/nvm.sh
test $NVM_DIR && source "$NVM_DIR/nvm.sh" && npm config delete prefix && nvm use default --delete-prefix

pathadd "$NVM_DIR"
# }}}

# Fasd: {{{
fasd_cache="$HOME/.fasd-init-bash"
if [[ -n "$(command -v fasd)" ]]; then
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install > "$fasd_cache"
    fi
    source "$fasd_cache"
    export _FASD_VIMINFO="$XDG_DATA_HOME/nvim/shada/main.shada"
fi
# }}}

# Sourced files: {{{
firstpath "$HOME/bin"
firstpath "$HOME/.local/bin"
pathadd "$_ROOT/local/bin"
pathadd "$_ROOT/libexec"

# add some cool colors to ls
eval "$( dircolors -b $HOME/.dircolors )"

if [[ -d ~/.bashrc.d ]]; then
    for config in $HOME/.bashrc.d/*.bash; do
        # shellcheck source=/home/faris/.bashrc.d/*.bash
        source $config;
    done
    unset -v config
fi
# }}}

# Completions: {{{
# dynamic completions. from man bash
_completion_loader()
{
    # source the bash-completions directory as needed
    . "$_ROOT/share/bash-completion/completions/*" >/dev/null 2>&1 && return 124
}

# oh also fzf. but -A command is a bad idea so don't do that.
# dude bash should complete its own fucking keywords. oh man is this nice.
# `-k` is the same as -A keyword
complete -D -F _completion_loader -F _fzf_path_completion -k -f -d
# -o plusdirs -F _fzf_complete

# modify how completions are created by default
compopt -D -o bashdefault -o default

# From /usr/share/doc/bash/README.md.bash-completion
export COMP_CONFIGURE_HINTS=1

# Here's one for the terminal
if [[ -n "$(command -v kitty)" ]]; then
    source <(kitty + complete setup bash)
fi

# Never noticed this before!
# this variable is called in ~/.fzf/shell/completion.bash with each command in the var fed to this
# __fzf_defc "$cmd" _fzf_dir_completion "-o nospace -o dirnames"
export FZF_COMPLETION_DIR_COMMANDS="cd cs pushd rmdir mkdir mk du tree dlink ctags"

# From man bash Programmable Completion

#        First, the actions specified by the compspec are used.  Only matches
#        which are prefixed by the word being completed are returned.  When the
#        -f or -d option is used for filename or directory name completion, the
#        shell variable FIGNORE is used to filter the matches.

# This allows set to behave slightly more as expected.  -k is keyword.
complete -k -A setopt -A shopt -F _fzf_var_completion set unset

# The -A flag is fucking amazing for getting complete to behave as expected
complete -A hostname -F _longopt -F _fzf_host_completion -F _known_hosts ssh traceroute ping

complete -A alias -F _fzf_alias_completion alias unalias
# where did _terms come from?
complete -A export -F _terms -F _longopt -F _fzf_var_completion env export
complete -F _fzf_var_completion echo

complete -o bashdefault -o default -F _longopt -F _completion_loader -F _fzf_path_completion \
    a2ps awk base64 bash bc bison cat chroot colordiff cp \
    csplit cut date df diff dir enscript expand find fmt fold gperf \
    grep grub head irb ld ldd less ln ls m4 md5sum mkfifo mknod \
    mv netstat nl nm nvim objcopy objdump od paste pr ptx readelf   \
    sed seq sha{,1,224,256,384,512}sum shar sort split strip sum tac tail tee \
    texindex touch tr uname unexpand uniq units vi vim vdir wc who

obviously_a_terrible_idea() {
    for i in $_ROOT/share/bash-completion/completions/*; do
        source "$i"
    done
}

# }}}

# Prompt: {{{

_prompt_git_branch() {   # {{{
    if branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"; then
        [[ -n "$(git status --porcelain 2> /dev/null)" ]] && echo -n "\[$LIGHT_RED\]Dirty: "
        echo -ne "\[$CYAN\]$branch "
        # Idk if this is a new sub command but i just found it with git 2.25.1 and its neat
        if [[ -n "$(command -v git show-branch)" ]]; then
            echo -en "\[$GREEN\]$(git show-branch --color=always --reflog=1)"
        fi
    fi
}  # }}}

_venv() {
    [[ -n "$VIRTUAL_ENV" ]] && echo -n "\[$CYAN\]$(basename $VIRTUAL_ENV) "
}

_status() {
    # Also im gonna just mash this in here
    local error="$?"
    [[ $error != 0 ]] && echo -n "\[$RED\]$error"
}

uhw() {   # {{{
    # Named so because the standard escapes in a prompt are \u@\h \w
    # You know. For username, hostname, working directory.
    echo -n "\[$WHITE\]\u @ \[$BLUE\]\h \[$BROWN\]\w "
    # Why the fuck is \A a timestamp you may say? I don't know.
    echo -n "\[$YELLOW\]\A "
    # Just realized that \$ is the root normal user check that symbol used to be
    # Also \j is jobs. i really didn't need that job function either!
    echo -n "\[$SALMON\]\j "
}  # }}}

# Git, PS1 and Prompt Command: {{{

# TODO: removing $(git_branch) for the time being because this shit doesn't
# re-evaluate when you change dir... Which is shitty because the cwd does
# so it's objectively possible but idk how or what to do.
# fuck were doing something wrong because status doesnt re-evaluate on every prompt either
# Git bash is really struggling with this one.
export PS1="$(_venv)$(uhw)\n\[$UGREEN\]In [\#] \[$RED\]\$ \[$RESET\]"

# I got so close. But i don't even know how to debug whatever problem the
# below is having. When used in prompt_command, git_ps1 needs 2 to 3 arguments.

# export PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$yellow`basename $VIRTUAL_ENV`$RESET]}" "$PS1 \\\$" "[%s]"'
# PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$YELLOW`basename $VIRTUAL_ENV`$COLOR_OFF]}" "$TMP_PS1" "[%s]"'
# }}}

# }}}

# Local bashrc
if [[ -f "$HOME/.bashrc.local" ]]; then
    # shellcheck source=/home/faris/.bashrc.local
    . "$HOME/.bashrc.local"
fi

# Vim: set foldlevelstart=0 fdm=marker et sw=4 sts=4 ts=4:
