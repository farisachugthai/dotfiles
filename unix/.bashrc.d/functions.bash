# Bash functions
# Useful snippets and tricks to work in the shell more easily .

# Create a new directory and enter it
function mk(){
    mkdir -p "$@" && cd "$@"
}

# Handy Extract Program
function extract()
{
if [ -f $1 ]; then
case $1 in
    *.tar.bz2) tar xvjf $1 ;;
    *.tar.gz) tar xvzf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) unrar x $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xvf $1 ;;
    *.tbz2) tar xvjf $1 ;;
    *.tgz) tar xvzf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *.7z) 7z x $1 ;;
    *.tar.xz) tar xvf $1 ;;
# Alternatively you could run xz -d file.tar.xz; tar xvf file.tar
    *) echo "'$1' cannot be extracted via >extract<" ;;
 esac
 else
 echo "'$1' is not a valid file!"
 fi
}


# Run cd and ls at once
function cs ()
{
    cd "$@" && ls
}

# Decrypt the ssh priv key for the day
function ssh-day ()
{
    if [[ -z $SSH_AUTH_SOCK ]]; then
        eval `ssh-agent -s`
    fi
    ssh-add -t 86400
}

# Adds an alias to the current shell and to ~/.bashrc.d/alias
add-alias ()
{
   local name=$1 value="$2"
   echo alias $name=\'$value\' >> ~/.bashrc.d/alias
   eval alias $name=\'$value\'
   alias $name
}

# Update the python packages you care about most
update-pip ()
{
    local pu="pip install -Uq"
    $pu pip
    $pu ipython
    $pu virtualenv
    $pu jedi
    $pu flake8
    $pu dropbox
}

# I really don't like anything that smells like Emacs keybindings
infovi ()
{
    info $1 | less
}

# From byobu
byobu_prompt_status() { local e=$?; [ $e != 0 ] && echo -e "$e "; }

# Trying to get more out of fzf
# commits in a repo
fzf_commits() {
  git log --pretty=oneline --abbrev-commit | fzf --preview-window=right:50% --preview 'echo {} | cut -f 1 -d " " | xargs git show --color=always' | cut -f 1 -d " "
}

# for existing man pages
fzf_apropos() {
  apropos '' | fzf --preview-window=right:50% --preview 'echo {} | cut -f 1 -d " " | xargs man' | cut -f 1 -d " "
}

# view EVERYTHING set in your env
fzf_env() {
    set | tr = "\t" | fzf | cut -f 1
}

fzf_nvim() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}
