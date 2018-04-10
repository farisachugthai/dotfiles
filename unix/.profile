# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "`pip completion --bash`"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

PATH="/usr/local/go/bin:$PATH"

export PAGER="/bin/less"
export COLORTERM="colorterm"

# Add Conda to the path
if [ -d ~/miniconda3 ]; then
   . ~/miniconda3/etc/profile.d/conda.sh
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
