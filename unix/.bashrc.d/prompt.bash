# Prompt.bash:

# The most absurd script for a prompt

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Prompt: {{{1

force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
    if [[ -x "/usr/bin/tput" ]] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# https://www.unix.com/shell-programming-and-scripting/207507-changing-ps1.html
# if [ "$color_prompt" = yes ]; then
# TMP_PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\") \
# [$(if [[ ${EUID} == 0 ]]; then
# echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h' \
# else
# echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h' \
# fi) \
# \[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\] " \
# else
#     TMP_PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
# fi

export ARROW='\342\224\224\342\224\200\342\224\200\342\225\274'

if [ "$color_prompt" = yes ]; then
TMP_PS1="\[\033[0;31m\]\342\224\214\342\224\200\
\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")\
[$(if [[ ${EUID} == 0 ]]; then
    echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'
else
    echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'
fi)\
\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]$ARROW $COLOR_OFF\$\[\e[01;33m\]\[\e[0m\] "
# well that's a little better i guess
else
    TMP_PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# just noticed this in the venv activate script. i like it!
# if [ -z "${VIRTUAL_ENV_DISABLE_PROMPT-}" ] ; then
#     _OLD_VIRTUAL_PS1="$PS1"
#     if [ "x" != x ] ; then
#         PS1="$PS1"
#     else
#         PS1="(`basename \"$VIRTUAL_ENV\"`) $PS1"
#     fi
#     export PS1
# fi

if [[ -f "$HOME/.bashrc.d/git-prompt.sh" ]]; then
    . "$HOME/.bashrc.d/git-prompt.sh";
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$YELLOW`basename $VIRTUAL_ENV`$COLOR_OFF]}" "$TMP_PS1" "[%s]"'
fi

unset color_prompt force_color_prompt
tput reset      # because otherwise I end up with a red cursor

# Refactoring Prompt: {{{2
# CUSTOM BASH COLOR PROMPT
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold
prompt() {
    local BLACK="\[\033[0;30m\]"
    local BLACKBOLD="\[\033[1;30m\]"
    local RED="\[\033[0;31m\]"
    local REDBOLD="\[\033[1;31m\]"
    local GREEN="\[\033[0;32m\]"
    local GREENBOLD="\[\033[1;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local YELLOWBOLD="\[\033[1;33m\]"
    local BLUE="\[\033[0;34m\]"
    local BLUEBOLD="\[\033[1;34m\]"
    local PURPLE="\[\033[0;35m\]"
    local PURPLEBOLD="\[\033[1;35m\]"
    local CYAN="\[\033[0;36m\]"
    local CYANBOLD="\[\033[1;36m\]"
    local WHITE="\[\033[0;37m\]"
    local WHITEBOLD="\[\033[1;37m\]"
    export PS1="\n$CYAN\T\n$GREENBOLD \u$YELLOWBOLD@$PURPLEBOLD\h\[\033[00m\]:$CYANBOLD[\w]\[\033[00m\] \\$ "
}

# Intentionally not calling this function
