#!/bin/bash
# Maintainer: Faris Chugthai

# Set up
# Check that the main entry point is there.:
if [[ -f "$HOME/.fzf.bash" ]]; then
    export FZF_TMUX_HEIGHT=80%
    export FZF_TMUX=1
else
    echo -e "\n"'****<.bashrc.d/fzf.bash>: FZF not installed.****'"\n"
fi

# **New**: FZF Preview Command:
if [[ -n "$(command -v bat)" ]]; then
  export FZF_PREVIEW_WINDOW='bat --style="${BAT_STYLE:-numbers}" --color=always --pager=never \
      --line-range=$FIRST:$LAST --highlight-line=$CENTER "$FILE"'
fi

if [[ -n "$(command -v fd)" ]]; then  # fd

    # Base FZF command: {{{
    # export FZF_DEFAULT_COMMAND="fd --follow -j 8 -d 6 --exclude .git"

    export FZF_DEFAULT_COMMAND=" rg --hidden --color ansi --no-messages --follow --files --passthru * $@ | tr -d '\017' "
    export FZF_DEFAULT_OPTS='--multi --cycle --reverse --prompt "Query: " --tiebreak=begin,length,index --ansi --filepath-word --border --header="FZF: File Browser. Press Alt-n to launch nvim." --bind alt-n:execute:"nvim {}" --bind change:top --bind ctrl-j:accept --bind ctrl-k:kill-line'

    #  --bind "?:toggle-preview" --preview-window=down:50%:wrap --preview "bat {}"

    # __fzf_history__: <Ctrl-r>:
    export FZF_CTRL_R_COMMAND="fd "
    export FZF_CTRL_R_OPTS="--sort --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' --bind change:top"

    # Change dirs with Alt C:
    export FZF_ALT_C_COMMAND=" fd --type d --hidden --follow --exclude .git --color always --ignore-file $HOME/.ignore "

    export FZF_ALT_C_OPTS=' --cycle --ansi --tiebreak begin,length,index --no-multi --filepath-word --bind "?:toggle-preview" --header "Press ? to toggle preview." --border --prompt "FZF Dir Finder" '

    # fzf-file-widget: <Ctrl-t>:
    export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow -j 8 -d 6 --exclude .git'

    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --ansi --tiebreak begin,length,index --filepath-word --bind alt-n:execute:"nvim {}" --bind change:top --bind=ctrl-j:accept --bind ctrl-k:kill-line '

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh && -n "$(command -v ruby)" ]]; then
        export FZF_CTRL_T_OPTS+="--preview-window=down:50%:wrap --bind ?:toggle-preview --header 'Press ? to toggle preview.' --preview ~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh' {} | bat -' "

    elif [[ -n "$(command -v bat)" ]]; then
        export FZF_CTRL_T_OPTS+=' --preview "bat {}" --preview-window=down:50%:wrap --bind ?:toggle-preview --header "Press ? to toggle preview."'
    else
        export FZF_CTRL_T_OPTS+=' --preview "head -n 100 {} " --preview-window=down:50%:wrap '
    fi

# Enhance path completion:
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

elif [[ -n "$(command -v rg)" ]]; then  #:

    # Base FZF command: `fzf`:
    # May 28, 2019: works
    # I wanna see a line but only one at a time. Also check the ripgreprc.
    # This works!!! Takes arguments, searches file contents not just titles. We got it man
    # Filepath helps you jump directories quickly, tiebreak begin makes a ton
    # of difference, ansi colors dude this is sweet
    export FZF_DEFAULT_COMMAND='rg --hidden  --no-messages --smart-case  --passthru --max-depth 10 --max-count 20 --max-columns 200 -C 0 -- .'
    export FZF_BACKUP_DEFAULT_COMMAND="rg --follow --hidden --smart-case --vimgrep -e ^.*$ "
    export FZF_DEFAULT_OPTS=' --multi --cycle --reverse --prompt "Query: " --tiebreak begin,length,index --ansi --filepath-word --border --header "FZF: File Browser"  '

    # fzf-file-widget: <Ctrl-t>:
    # Might be implemented as __fzf_select__
    # Also i think its the fzf-file-widget you see in the autocomplete suggestion so add --filepath-word

    # Works perfectly!!!
    # Display only filenames but provide a preview window.
    # Oct 08, 2019: Added nvim binding.
    export FZF_CTRL_T_COMMAND=" rg --hidden --follow --smart-case --passthru --max-depth 10 --max-count 20 --max-columns 200 -C 0  "

    export FZF_CTRL_T_OPTS=' --tiebreak begin,length,index --filepath-word --multi --cycle --border --reverse --preview-window=right:60%:wrap --ansi --bind "?:toggle-preview" --header "Press ? to toggle preview. Alt-n to launch nvim. " --bind "alt-n:execute(nvim {}) " '

    # if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh && -n "$(command -v ruby)" ]]; then
    #     # doesn't this stop tilde expansion?
    #     export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh {} | bat - ' "

    if [[ -n "$(command -v bat)" ]]; then
        # TODO: Fzf is reading these as options to itself not as bats options
        # export FZF_DEFAULT_BAT_OPTS=' "--italic-text always" "--wrap character" "--color always" "--paging always" {} '
        # export FZF_CTRL_T_OPTS+="--preview $FZF_DEFAULT_BAT_OPTS"
        export FZF_CTRL_T_OPTS+='--preview "bat {}" '
    else
        export FZF_CTRL_T_OPTS+=' --preview "head -n 100 {} " '
    fi
    # }}}

    # __fzf_history__: <Ctrl-r>: {{{
    export FZF_CTRL_R_COMMAND=" rg --hidden --color=ansi --smart-case --no-heading --no-filename --no-messages --smart-case --glob '!.git/*' -g '!node_modules/*' "
    export FZF_CTRL_R_OPTS=" --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' "

    if [[ -n "$(command -v fd)" ]]; then  # Change dirs with Alt C: {{{
        export FZF_ALT_C_COMMAND=" fd --type d --hidden --follow --exclude .git --color always --ignore-file $HOME/.ignore "
    # TODO: else
    fi  # }}}

else  # no rg or fd: Use find.
    export FZF_DEFAULT_COMMAND="find * -type f $@"

    # Options for FZF no matter what.
    export FZF_DEFAULT_OPTS=' --cycle --multi --border --ansi '

# To use custom commands instead of find, override _fzf_compgen_{path,dir}

  _fzf_compgen_path() {
    echo "$1"
    command find -L "$1" \
      -name .git -prune -o -name .hg -prune -o -name .svn -prune -o \( -type d -o -type f -o -type l \) \
      -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
  }

  _fzf_compgen_dir() {
    command find -L "$1" \
      -name .git -prune -o -name .hg -prune -o -name .svn -prune -o -type d \
      -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
  }

fi

# Extra Funcs Using FZF:

Ag() { ag -l -g "" | fzf-tmux $FZF_DEFAULT_OPTS - ; };
complete -F _fzf_path_completion -F _ag -o default -o bashdefault Ag ag

Rg() { $FZF_DEFAULT_COMMAND  | fzf-tmux $FZF_DEFAULT_OPTS -r 40; };
complete -F _fzf_path_completion -F _rg -o default -o bashdefault rg Rg

# TODO:
# termux doesnt have xclip or xsel
command -v tree > /dev/null && export FZF_ALT_C_OPTS+="--preview 'tree -aFh -I .git -I __pycache__ -C {} | head -200' "

# Colors:

_gen_fzf_default_opts() {

local color00='#1d2021'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_COLORSCHEME="--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
--color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
--color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
}

_seoul_fzf() {

export FZF_COLORSCHEME="--color='bg:#4B4B4B,bg+:#3F3F3F,info:#BDBB72,border:#6B6B6B,spinner:#98BC99'
              \ --color='hl:#719872,fg:#D9D9D9,header:#719872,fg+:#D9D9D9'
              \ --color='pointer:#E12672,marker:#E17899,prompt:#98BEDE,hl+:#98BC99'"
}

_gen_fzf_default_opts

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_COLORSCHEME"
export FZF_CTRL_R_OPTS="$FZF_CTRL_R_OPTS $FZF_COLORSCHEME"
export FZF_CTRL_T_OPTS="$FZF_CTRL_T_OPTS $FZF_COLORSCHEME"
export FZF_ALT_C_OPTS="$FZF_ALT_C_OPTS $FZF_COLORSCHEME"

# Vim: set fdm=syntax fdls=0:
