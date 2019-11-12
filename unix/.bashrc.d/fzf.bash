#==============================================================================
#         NAME:  fzf.bash
#  DESCRIPTION:  From my bashrc
#==============================================================================

# Jun 11, 2019: Just had the passing thought...only the exports and the tests
# make this bash specific. Sub those out and this is a ps1 script too
# So we tested it out and pwsh doesn't like the local keyword at the bottom.
# Otherwise good to go!

# Check that the main entry point is there. {{{1
if [[ -f ~/.fzf.bash ]]; then
    export FZF_TMUX_HEIGHT=80%
    export FZF_TMUX=1
    # shellcheck source=/home/faris/.fzf.bash
    source "$HOME/.fzf.bash"
    # should we do else; git clone fzf repo?
else
    echo -e 'FZF not installed.'
fi

# }}}

if [[ -n "$(command -v rg)" ]]; then  # Rg {{{1

    # Base FZF command: {{{2
    # May 28, 2019: works
    # I wanna see a line but only one at a time. Also check the ripgreprc.
    # export FZF_DEFAULT_COMMAND="rg --hidden --no-messages --follow "

    # This works!!! Takes arguments, searches file contents not just titles. We got it man
    # Filepath helps you jump directories quickly, tiebreak begin makes a ton
    # of difference, ansi colors dude this is sweet
    export FZF_DEFAULT_COMMAND='rg --hidden --color=ansi --follow --no-messages --no-heading --smart-case --no-filename --glob "!.git/*" -g "!node_modules/*" --passthru  --max-depth 10 --max-count 20 --max-columns 200 -C 0 --files'

    # export FZF_DEFAULT_COMMAND="rg --follow --vimgrep -e ^.*$ "
    export FZF_DEFAULT_OPTS=' --multi --cycle --reverse --prompt "Query: " --tiebreak begin,length,index --ansi --filepath-word --border --header "FZF: File Browser"  '


    # <Ctrl-t>: {{{2
    # Might be implemented as __fzf_select__
    # Also i think its the fzf-file-widget you see in the autocomplete suggestion so add --filepath-word

    # Works perfectly!!!
    # Display only filenames but provide a preview window
    # export FZF_CTRL_T_COMMAND=" rg --hidden --color ansi --no-messages --follow --files --passthru * $@ | tr -d '\017' "
    # Jul 04, 2019: Copied the old command because it was too exciting getting it to work to then
    # have to search `git log -p`

    # Oct 08, 2019: Added nvim binding.
    export FZF_CTRL_T_COMMAND=" rg --hidden --color=ansi --no-messages --follow --files --smart-case --glob '!.git/*' -g '!node_modules/*' --passthru --max-depth 10 --max-count 20 --max-columns 200 -C 0 "

    export FZF_CTRL_T_OPTS=' --tiebreak begin,length,index --filepath-word --multi --cycle --border --reverse --preview-window=right:60%:wrap --ansi --bind "?:toggle-preview" --header "Press ? to toggle preview. Alt-n to launch nvim. " --bind "alt-n:execute(nvim {}) " '

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb && -n "$(command -v ruby)" ]]; then
        # doesn't this stop tilde expansion?
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | bat - ' "

    elif [[ -n "$(command -v bat)" ]]; then
        # TODO: Fzf is reading these as options to itself not as bats options
        export FZF_DEFAULT_BAT_OPTS=' "--italic-text always" "--wrap character" "--color always" "--paging always" {} '

        # export FZF_CTRL_T_OPTS+="--preview $FZF_DEFAULT_BAT_OPTS"
        export FZF_CTRL_T_OPTS+='--preview "bat {}" '

    else
        export FZF_CTRL_T_OPTS+=' --preview "head -n 100 {} " '
    fi

    # __fzf_history__: {{{2
    # works
    export FZF_CTRL_R_COMMAND=" rg --hidden --color=ansi --smart-case --no-heading --no-filename --no-messages --smart-case --glob '!.git/*' -g '!node_modules/*' "
    export FZF_CTRL_R_OPTS=" --cycle --reverse --prompt 'Query: ' --tiebreak begin,length,index --history-size=10000 --ansi --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' "

    # Change dirs with Alt C: {{{2
    # TODO: else
    if [[ -n "$(command -v fd)" ]]; then
        export FZF_ALT_C_COMMAND=" fd --type d --hidden --follow --exclude .git --color always --ignore-file $HOME/.ignore "
    fi

    export FZF_ALT_C_OPTS=' --cycle --ansi --tiebreak begin,length,index --no-multi --filepath-word --bind "?:toggle-preview" --header "Press ? to toggle preview." --border --prompt "FZF Dir Finder" '

    # Extra funcs from fzf
    Ag() { ag -l -g "" | fzf-tmux $FZF_DEFAULT_OPTS - ; };
    Rg() { $FZF_DEFAULT_COMMAND  | fzf-tmux $FZF_DEFAULT_OPTS -r 40; };


elif [[ -n "$(command -v fd)" ]]; then  # fd {{{2

    # Base FZF command: {{2
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -j 8 -d 6 --exclude .git $@"

    # Alt-C dir change: {{{2
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git '

    # <Ctrl-t> file widget: {{{2
    export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow -j 8 -d 6 --exclude .git'

    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview "bat {}" --preview-window=down:50%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview."'

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | bat -200'"
    fi

else  # no rg or fd {{{1
    export FZF_DEFAULT_COMMAND="find * -type f $@"

    # Options for FZF no matter what.
    export FZF_DEFAULT_OPTS=' --cycle --multi --border --ansi '
fi

# More additions: {{{1

if [[ -n "$(command -v bat)" ]]; then
    export BAT_PAGER="less -JRKMLige"
    export BAT_THEME="base16"
    export BAT_STYLE="full"
fi
# TODO:
# termux doesnt have xclip or xsel

command -v tree > /dev/null && export FZF_ALT_C_OPTS+="--preview 'tree -aF -I .git -I __pycache__ -C {} | head -200' "

# Enhance path completion: {{{2
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

if [[ -n "$(command -v fd)" ]]; then
    _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
    }
    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }
fi

complete -F _fzf_path_completion -o default -o bashdefault rg
complete -F _fzf_dir_completion -o default -o bashdefault tree

# Universal Options: {{{1

# TODO: Add prompts to this as well

# Colors: {{{2

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

export FZF_COLORSCHEME="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"
}
_gen_fzf_default_opts

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_COLORSCHEME"
export FZF_CTRL_R_OPTS="$FZF_CTRL_R_OPTS $FZF_COLORSCHEME"
export FZF_CTRL_T_OPTS="$FZF_CTRL_T_OPTS $FZF_COLORSCHEME"
export FZF_ALT_C_OPTS="$FZF_ALT_C_OPTS $FZF_COLORSCHEME"
