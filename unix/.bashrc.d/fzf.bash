<<<<<<< HEAD
#===============================================================================
#         NAME:  fzf.bash
#  DESCRIPTION:  From my bashrc
#===============================================================================

# Remember to keep this below set -o vi or else FZF won't inherit vim keybindings!
if [[ -f ~/.fzf.bash ]]; then
    export FZF_TMUX_HEIGHT=80%
    # shellcheck source=/home/faris/.fzf.bash
    source "$HOME/.fzf.bash"
fi

if [[ -n "$(command -v rg)" ]]; then  # {{{1

    # Base command: {{{2
    export FZF_DEFAULT_COMMAND="rg --hidden --no-messages --files $*"
    export FZF_DEFAULT_OPTS='--multi --cycle  --ansi'

    # <Ctrl-t>: {{{2
    # Might be implemented as __fzf_select__
    export FZF_CTRL_T_COMMAND="rg --hidden --no-messages --max-count 10 --files $*"
    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview-window=right:60%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview." '

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    else
        export FZF_CTRL_T_OPTS+='--preview "head -100 {}"'
    fi

    # __fzf_history__: {{{2
    export FZF_CTRL_R_COMMAND="rg --no-messages $*"
    export FZF_CTRL_R_OPTS="--cycle --ansi --preview 'echo {}' --preview-window=down:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' "

    # idk what dirs only is but A-c now works!
    # export FZF_ALT_C_COMMAND="rg --files $*"
    if [[ -n "$(command -v fd)" ]]; then
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi

    Ag() { ag -l -g "" | fzf; };
    Rg() { $FZF_DEFAULT_COMMAND  | fzf-tmux $FZF_DEFAULT_OPTS -r 40; };


elif [[ -n "$(command -v fd)" ]]; then  # {{{2

    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow -j 8 -d 6 --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow -j 8 -d 6 --exclude .git'

    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview "head -100 {}" --preview-window=down:50%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview."'

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    fi

else  # {{{2
    export FZF_DEFAULT_COMMAND='find * -type f'

    # Options for FZF no matter what.
    export FZF_DEFAULT_OPTS=' --cycle'
fi

# More: {{{1
# termux doesnt have xclip or xsel

command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -aF -I .git -I __pycache__ -C {} | head -200' "

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

complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree
||||||| merged common ancestors
=======
#===============================================================================
#         NAME:  fzf.bash
#  DESCRIPTION:  From my bashrc
#===============================================================================

# Remember to keep this below set -o vi or else FZF won't inherit vim keybindings!
if [[ -f ~/.fzf.bash ]]; then
    export FZF_TMUX_HEIGHT=80%
    # shellcheck source=/home/faris/.fzf.bash
    source "$HOME/.fzf.bash"
fi

if [[ -n "$(command -v rg)" ]]; then  # {{{1

    # Base command: {{{2
    export FZF_DEFAULT_COMMAND="rg --hidden --no-messages --files $*"
    export FZF_DEFAULT_OPTS='--multi --cycle  --ansi'

    # <Ctrl-t>: {{{2
    # Might be implemented as __fzf_select__
    export FZF_CTRL_T_COMMAND="rg --hidden --no-messages --max-count 10 --files $*"
    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview-window=right:60%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview." '

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    else
        export FZF_CTRL_T_OPTS+='--preview "head -100 {}"'
    fi

    # __fzf_history__: {{{2
    export FZF_CTRL_R_COMMAND="rg --no-messages $*"
    export FZF_CTRL_R_OPTS="--cycle --ansi --preview 'echo {}' --preview-window=down:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' --header 'Press CTRL-Y to copy command into clipboard' "

    if [[ -n "$(command -v fd)" ]]; then
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi

    Ag() { ag -l -g "" | fzf; };
    Rg() { $FZF_DEFAULT_COMMAND  | fzf-tmux $FZF_DEFAULT_OPTS -r 40; };


elif [[ -n "$(command -v fd)" ]]; then  # {{{2

    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow -j 8 -d 6 --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow -j 8 -d 6 --exclude .git'

    export FZF_CTRL_T_OPTS='--multi --cycle --border --reverse --preview "head -100 {}" --preview-window=down:50%:wrap --ansi --bind ?:toggle-preview --header "Press ? to toggle preview."'

    if [[ -x ~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb ]]; then
        export FZF_CTRL_T_OPTS+=" --preview '~/.local/share/nvim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
    fi

else  # {{{2
    export FZF_DEFAULT_COMMAND='find * -type f'

    # Options for FZF no matter what.
    export FZF_DEFAULT_OPTS=' --cycle'
fi

# More: {{{1
# termux doesnt have xclip or xsel

command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -aF -I .git -I __pycache__ -C {} | head -200' "

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

complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree
>>>>>>> master
