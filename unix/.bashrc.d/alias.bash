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

alias lf='ls -AFgo --color=always | grep ^-'
# You can use this one to dereference the symlinks aka show the real file
# nah don't do that because there's a function with lk
# alias lk='ls -lhAgoF --dereference --color=always'
alias ll='ls -Fl --color=always'
alias lm='ls -AFhogl --color=always'
alias lr='ls -AlgFhtr --color=always'
alias ls='ls -hF --color=always'
alias lt='ls -Alght --color=always'

# This is broken
# alias lx='ls -Fo --color=always | grep ^-..x'
alias lx='ls -Fl --color=always | grep ^l.*'
# }}}

# Safer coreutils: {{{
# Let's not clobber other files as we go. Bash's namespace? Clobber everything
# Please don't turn the p flag for rmdir again.
# You're lucky parent dirs weren't empty
alias cp='cp -v'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'
# Less annoying than i but more safe
#   only   prompts   with   more   than   3   files    or    recursed    dirs.
alias rm='rm -Iv'

# Options i use every time i run these commands
# probably shouldn't clobber the namespace though, there are conflicting options
# for du so i'll change to du shallow
alias dus='du -d 1 -h --all'
alias dU='du  -d  1  -h  --apparent-size  --all  |  sort  -h  |  tail  -n  10'
alias df='df -ah --total'
complete -d -f -o plusdirs -F _fzf_dir_completion -F _longopt ldir mkdir rmdir dus dU
alias echo="echo -e"
complete -v -F _fzf_var_completion echo
alias head="head -n 30"
alias tail="tail -n 30"
complete -d -f -F _fzf_path_completion -F _longopt l la lb lf ll lm lr ls lt lx mv cp rm df head tail

# They even take the same options like goddamn guys
test "$(command -v colordiff)" && alias diff=colordiff
# }}}

# Git aliases. {{{

# for complicated git log calls funcs are better
alias g="git diff --stat --staged"
alias ga="git add -v"
alias gaa='git add --all'
alias gai='git add --interactive'
alias gap='git add --patch'
alias gar="git add --renormalize -v"
alias gau='git add --update'
complete -f -d -F _git_add ga gaa gai gap gar gau
alias gb='git branch --all --verbose'
alias gbl="git blame"
complete -F _git_blame gbl
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
complete -F _git_commit gci gcia gciad gcid
alias gcl='git clone --progress'
alias gcls='git clone --progress --depth 1'
complete -F _git_clone gcl gcls
alias gco='git checkout'
alias gcob='git checkout -b'
# yeah having files and dirs complete is real useful
complete -f -d -F _git_checkout gco gcob
alias gd='git diff'
alias gds='git diff --staged'
alias gds2='git diff --staged --stat'
complete -f -d -o nosort -F _git_diff g gd gds gds2 gst
alias gdt='git difftool'
complete -F _git_difftool gdt
alias gf='git fetch --all'
complete -F _git_fetch gf
alias gh="git help"
complete -F _git_help gh
alias gl="git log --graph --decorate --abbrev-commit --branches --pretty=lo"
alias glo="git log"
complete -f -d -F _git_log -o nospace gl glo
alias gls='git ls-tree'
complete -f -d -F _git_ls_tree gls
alias gm='git merge --no-ff'
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gmm='git merge master'
alias gmt='git mergetool'
complete -F _git_merge -o nospace gm gma gmc gmm git-merge-index git-merge-one-file git-merge-ours
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
alias gsb='git status -sb'
alias gss='git status -s'
complete -f -d -F _git_status gs gsb gss
alias gsh="git stash"
alias gsha='git stash apply'
alias gshc='git stash clear'
alias gshd='git stash drop'
alias gshl='git stash list'
alias gshp='git stash pop'
alias gshs='git stash show'
alias gshsp='git stash show -p'
complete -f -d -F _git_stash gsh gsha gshc gshd gshl gshp gshs gshsp
alias gst='git diff --stat'
alias gsw="git switch --progress"
alias gt='git tag --list'
complete -F _git_tag gt
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
alias tree="tree -I node_modules"
complete -F _fzf_dir_completion -o default -o bashdefault tree tre
# }}}
