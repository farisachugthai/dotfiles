#!/usr/bin/env bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

# All: {{{ 1

# Don't run if not interactive: {{{
case $- in
    *i*);;
    *) return 0;;
esac
# }}}

# History: {{{
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
# TODO: What are the units on either of these?
# still don't kniw but fc maxes out at 32767
HISTFILESIZE=50000
# https://unix.stackexchange.com/a/174902
HISTTIMEFORMAT="%F %T: "
# Ignore all the damn cds, ls's its a waste to have pollute the history
HISTIGNORE='exit:ls:cd:history:ll:la:gs'
# }}}

# Shopt: {{{
# Be notified of asynchronous jobs completing in the background
set -o notify
# Append to the history file, don't overwrite it
shopt -s histappend
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [[ $BASH_VERSINFO -gt 3 ]]; then
    shopt -s globstar
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
set -o noclobber        # Still dont want to clobber things
shopt -s xpg_echo       # Allows echo to read backslashes like \n and \t
shopt -s dirspell       # Autocorrect the spelling if it can
shopt -s cdspell
# }}}

# Defaults in Ubuntu bashrcs: {{{
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
# }}}

# Prompt: {{{
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
    if [[ -x "$PREFIX/bin/tput" ]] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# https://www.unix.com/shell-programming-and-scripting/207507-changing-ps1.html
if [ "$color_prompt" = yes ]; then
    TMP_PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\] "
else
    TMP_PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

if [[ -f "$HOME/.bashrc.d/git-prompt.sh" ]]; then
    . "$HOME/.bashrc.d/git-prompt.sh";
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export Color_Off="\[\033[0m\]"
    export Yellow="\[\033[0;33m\]"
    PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$Yellow`basename $VIRTUAL_ENV`$Color_Off]}" "$TMP_PS1" "[%s]"'
fi

# Set 'man' colors.
if [ "$color_prompt" = yes ]; then
    man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
    }
fi

unset color_prompt force_color_prompt
# }}}

# Vim: {{{
set -o vi
if [[ "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"
# }}}

# JavaScript: {{{
# Source npm completion if its installed
if [[ "$(which npm)" ]]; then
    source ~/.bashrc.d/npm-completion.bash
fi

# Export nvm if the directory exists
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" # This loads nvm
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
fi
# }}}

# FZF: {{{
# Remember to keep this below set -o vi or else FZF won't inherit vim keybindings!
if [[ -f ~/.fzf.bash ]]; then
    . "$HOME/.fzf.bash"
fi

fzf-down() {
  fzf --height 50% "$@" --border
}

# This is gonna be hard to organize. so let's start with getting one set up perfectly.
# TODO: Get an Alt-C and C-r for ag

# Is it going to be better to have these blocks for each keybinding? as it
# stands C-r isn't defined when ag is present.
if [[ "$(command -v ag)" ]]; then
    export FZF_CTRL_T_COMMAND='ag  --hidden --nocolor --noheading --nobreak --nonumbers -l'
    export FZF_CTRL_T_OPTS=' --preview "head -100 {}" --preview-window=right:50%:wrap --cycle --multi '
# Junegunn's current set up per his bashrc with an added check for fd.
elif [[ "$(command -v rg)" ]]; then
    export FZF_CTRL_T_COMMAND='rg --hidden --max-count 10'
    export FZF_CTRL_T_OPTS='--multi --color=bg+:24 --bind "enter:execute(less {})" --preview-window=right:50%:wrap --cycle'
elif [[ "$(command -v fd)" ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow'

    if [[ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    fi
else
    export FZF_DEFAULT_COMMAND='find * -type f'
fi

# Suggestion: Dont put anything in FZF_DEFAULT_OPTS for a little while. 
# Ensure that all 4 commands {ag, rg, fd and bland find} can handle these options appropriately.
# Once you've spent enough time perfecting all 4 commands, and don't feel any
# rush to do so, factor out all similar options and throw them in the default.
# But the best way to do tackle something this complicated is in a piece meal manner.
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--layout=reverse --bind "enter:execute(nvim {})" --multi --cycle --color=bg+:24 --border --exclude .git,.__pycache__'

# termux doesnt have xclip or xsel

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -aI .git -C {} | head -200'"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree
# }}}

# Python: {{{
if [[ -d "$HOME/miniconda3/bin/" ]]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('$HOME/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

# If this env var isn't set it will equal 0. So also run a check that we have conda
# TODO: Also could be 0 if it's unset. Need to check for that as well.
if [[ $CONDA_SHLVL -eq 0 ]]; then
    if [[ -d "$HOME/miniconda3/etc/profile.d" ]]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
        conda activate base
    fi
elif [[ $CONDA_SHLVL -eq 1 ]]; then
    continue
fi

# https://pip.pypa.io/en/stable/user_guide/#command-completion
if [[ "$(command -v pip)" ]]; then
# https://pip.pypa.io/en/stable/user_guide/#command-completion
    eval "$(pip completion --bash)"
fi
# }}}

# gcloud: {{{
# The next line updates PATH for the Google Cloud SDK.
# can we do if "{$PREFIX,/bin}/g...{completion,path}.b..." and make this all one line?
# The next line updates PATH for the Google Cloud SDK.
if [[ -f ~/bin/google-cloud-sdk/path.bash.inc ]]; then source ~/bin/google-cloud-sdk/path.bash.inc; fi
# The next line enables shell command completion for gcloud.
if [[ -f ~/bin/google-cloud-sdk/completion.bash.inc ]]; then source ~/bin/google-cloud-sdk/completion.bash.inc; fi

if [[ -f "$PREFIX/google-cloud-sdk/path.bash.inc" ]]; then source "$PREFIX/google-cloud-sdk/path.bash.inc"; fi
if [[ -f "$PREFIX/google-cloud-sdk/completion.bash.inc" ]]; then source "$PREFIX/google-cloud-sdk/completion.bash.inc"; fi

# }}}

# Sourced files: {{{
if [[ -d ~/.bashrc.d ]]; then
    for config in ~/.bashrc.d/*.bash; do
        source "$config"
    done
unset -v config
fi

# For the secrets
if [[ -f "$HOME/.bashrc.local" ]]; then
    . "$HOME/.bashrc.local"
fi
# }}}

# Alacritty doesn't provide much functionality outside of it's absurd speed
# However, tmux covers any functionality that Alacritty isn't trying to give
# So let's just activate it automatically

# So this actually is pretty great; however, this should be modified to find
# a detached session to attach to before creating a new one.
# [[ -z "$TMUX"  ]] && exec tmux
[[ -n "$TMUX" ]] && FZF_TMUX=1 && FZF_TMUX_HEIGHT=80%
# }}}

# }}}
