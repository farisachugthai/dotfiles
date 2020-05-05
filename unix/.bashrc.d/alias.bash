#!/bin/bash
# Maintainer: Faris Chugthai

# ls aliases: {{{

#  some  more  ls  aliases.  pulled  a  few  from  ipython  so  not  all  were
#  written  by  me.  as  a  result  let   me   quick   go   over   the   flags

# -A all except implied . and ..
# -c sort by ctime.
#  -F  classifies.   indicators   for   symlinks   and   dirs   are   provided
# -o is similar to -l but don't print group. So wait  that's  the  same  thing
# as -lg...? Why.
# -p means append / indicator to directoreis
alias l='ls -hF --color=always'
alias la='ls -AF --color=always'
alias ldir='ls -po --color=always | grep /$'

complete -d -f -o bashdefault -o default -F _fzf_path_completion -F _longopt l
complete -d -f -o bashdefault -o default -F _fzf_path_completion -F _longopt la
complete -d -f -o bashdefault -o default -o plusdirs -F _fzf_dir_completion -F _longopt ldir


# Broken
# alias lf='ls -Fo --color=always | grep ^-'
# Oh it might be because of wsl's fucky permissions.
alias lf='ls -AFgo --color=always | grep *$'
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt lf
# You can use this one to dereference the symlinks aka show the real file
# nah don't do that because there's a function with lk
# alias lk='ls -lhAgoF --dereference --color=always'
alias ll='ls -AFhogl --color=always'
alias lr='ls -AlgFhtr --color=always'
alias ls='ls -hF --color=always'
alias lt='ls -Alght --color=always'
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt ll
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt lr
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt ls
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt lt

# This is broken
# alias lx='ls -Fo --color=always | grep ^-..x'
alias lx='ls -Fl --color=always | grep ^l.*'
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt lx
# }}}

# Safer coreutils: {{{

# Let's not clobber other files as we go. Bash's namespace? Clobber everything
# Please don't turn the p flag for rmdir again.
# You're lucky parent dirs weren't empty
alias cp='cp -v'
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt cp
alias mv='mv -v'
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt mv
alias mkdir='mkdir -pv'
complete -o bashdefault -o default -o dirnames -o plusdirs -F _fzf_dir_completion -F _longopt mkdir
alias rmdir='rmdir -v'
complete -d -o plusdirs -F _fzf_dir_completion -F _longopt rmdir
# Less annoying than i but more safe
#   only   prompts   with   more   than   3   files    or    recursed    dirs.
alias rm='rm -Iv'
complete -o bashdefault -o default -o dirnames -o filenames -o plusdirs -F _fzf_path_completion -F _longopt rm

# Options i use every time i run these commands
# probably shouldn't clobber the namespace though, there are conflicting options
# for du so i'll change to du shallow
alias dus='du -d 1 -h --all'
complete -o bashdefault -o default -o dirnames -F _longopt -F _fzf_dir_completion dus
alias dU='du  -d  1  -h  --apparent-size  --all  |  sort  -h  |  tail  -n  10'
complete -o bashdefault -o default -o dirnames -F _longopt -F _fzf_dir_completion dU
alias df='df -ah --total'
alias free='free -mt'
alias echo='echo -e'
# complete filenames, options and vars. `-v` is the same as -A variable
complete -A setopt -o bashdefault -o default -o filenames -F _fzf_var_completion -v echo
alias head="head -n 30 $*"
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt -f -o plusdirs head
alias tail="tail -n 30 $*"
complete -o bashdefault -o default -o dirnames -o filenames -F _fzf_path_completion -F _longopt -f -o plusdirs tail
# }}}

# Termux alias: {{{1

if [[ -n "$ANDROID_ROOT" ]]; then

    #   Termux   command   with    odd    default    of    view    not    send
    alias termux-share="termux-share -a send"

    # But let's make it easier to use
    alias share="termux-share -a send"

    # termux-open gets an option for a default file handler! Dropbox integration
    alias termux-open="termux-open --send"

    # I still want to type less
    alias opn="termux-open --send"

    # Copy and paste for when I don't feel like firing up tmux
    alias copy="termux-clipboard-get"
    # Paste is a coreutil though
    alias pste="termux-clipboard-set"

fi  # }}}

# Git aliases. {{{

# for complicated git log calls funcs are better
alias g="git diff --stat --staged"
alias ga="git add -v"
alias gaa='git add --all'
alias gai='git add --interactive'
alias gap='git add --patch'
alias gar="git add --renormalize -v"
alias gau='git add --update'
complete -F _git_add ga gaa gai gap gar gau
alias gb='git branch --all --verbose'
alias gbl="git blame"
alias gbr="git branch"
alias gbrd="git branch -d"
alias gbrD="git branch -D"
alias gbrrd="git branch -rd"
alias gbrrD="git branch -rD"
alias gbru="git branch --set-upstream-to --verbose origin"
complete -F _git_branch gb gbr gbrd gbrD gbrrd gbrrD gbru
alias gci='git commit'
alias gcia='git commit --amend'
alias gciad="git commit --amend --date="
alias gcid="git commit --date="
alias gcl='git clone --progress'
alias gcls='git clone --progress --depth 1'
alias gco='git checkout'
alias gcob='git checkout -b'
complete -F _git_checkout gco gcob
alias gd='git diff'
alias gds='git diff --staged'
alias gds2='git diff --staged --stat'
complete -o nospace -o nosort -F _git_diff g gd gds gds2 gst
alias gdt='git difftool'
complete -F _git_difftool gdt
alias gf='git fetch --all'
alias gl="git log --graph --decorate --abbrev-commit --branches --pretty=lo"
alias glo="git log"
complete -F _git_log -o nospace gl glo
alias gls='git ls-tree'
alias gm='git merge --no-ff'
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gmm='git merge master'
alias gmt='git mergetool'
complete -F _git_merge -o nospace gm gma gmc gmm
alias gp='git pull --all'
alias gpo='git pull origin'
alias gpom='git pull origin master'
complete -F _git_pull gp gpo gpom
alias gpu='git push'
complete -F _git_push gpu
alias gr='git remote -v'
alias grb='git rebase '
alias grba='git rebase --abort '
alias grbc='git rebase --continue '
alias grbi='git rebase --interactive '
complete -F _git_rebase grb grba grbc grbi
alias gre='git remote'
complete -F _git_remote gr gre
alias gs='git status'
alias gsh="git stash"
alias gsha='git stash apply'
alias gshc='git stash clear'
alias gshd='git stash drop'
alias gshl='git stash list'
alias gshp='git stash pop'
alias gshs='git stash show'
alias gshsp='git stash show -p'
complete -F _git_stash gsh gsha gshc gshd gshl gshp gshs gshsp
alias gst='git diff --stat'
alias gsw="git switch --progress"
alias gt='git tag --list'
# }}}

# Other: {{{1

#   enable   color   support   of   ls   and   also    add    handy    aliases
if [[ -x "$PREFIX/dircolors" ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls -F --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias redo='fc -s'
alias r='fc -s'

if [[ -n "$(command -v emacs)" ]]; then
    alias spacemacs='emacs -l ~/.spacemacs'
fi

if [[ -n "$(command -v bat)" ]]; then
    alias cat=bat
fi

alias tre="tree -FACa -I .git $*"
complete -F _fzf_dir_completion -o default -o bashdefault tree tre
alias tree="tree -AC -I node_modules"
alias tmux="tmux -u"
# }}}
