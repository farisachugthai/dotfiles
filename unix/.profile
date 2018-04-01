# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "`pip completion --bash`"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export PAGER="/bin/less"
export COLORTERM="colorterm"

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
