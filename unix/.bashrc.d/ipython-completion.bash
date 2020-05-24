# load with: . ipython-completion.bash

if [[ -n ${ZSH_VERSION-} ]]; then
    autoload -Uz bashcompinit && bashcompinit
fi

# bash completion for python                               -*- shell-script -*-

_python_modules()
{
    COMPREPLY+=( $(compgen -W \
        "$(${1:-python} ${BASH_SOURCE[0]%/*}/../helpers/python $cur \
           2>/dev/null)" -- "$cur") )
}

_ipython_get_flags()
{
    local url=$1
    local var=$2
    local dash=$3
    if [[ "$url $var" == $__ipython_complete_last ]]; then
        opts=$__ipython_complete_last_res
        return
    fi
    # matplotlib and profile don't need the = and the
    # version without simplifies the special cased completion
    opts=$(ipython ${url} --help-all | grep -E "^-{1,2}[^-]" | sed -e "s/<.*//" -e "s/[^=]$/& /" -e "s/^--matplotlib=$//" -e "s/^--profile=$/--profile /"  -e "$ s/^/\n-h\n--help\n--help-all\n/")
    __ipython_complete_last="$url $var"
    __ipython_complete_last_res="$opts"
}

_ipython()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD - 1]}
    local subcommands="kernel profile locate history"
    local opts="help"
    if [ -z "$__ipython_complete_baseopts" ]; then
        _ipython_get_flags baseopts
        __ipython_complete_baseopts="${opts}"
    fi
    local baseopts="$__ipython_complete_baseopts"
    local mode=""
    for i in "${COMP_WORDS[@]}"; do
        [ "$cur" = "$i" ] && break
        if [[ ${subcommands} == *${i}* ]]; then
            mode="$i"
            break
        elif [[ ${i} == "--"* ]]; then
            mode="nosubcommand"
            break
        fi
    done


    if [[ ${cur} == -* ]]; then
        case $mode in
             "kernel")
                _ipython_get_flags $mode
                opts=$"${opts} ${baseopts}"
                ;;
            "locate" | "profile")
                _ipython_get_flags $mode
                ;;
            "history")
                if [[ $COMP_CWORD -ge 3 ]]; then
                    # 'history trim' and 'history clear' covered by next line
                    _ipython_get_flags $mode\ "${COMP_WORDS[2]}"
                else
                    _ipython_get_flags $mode

                fi
                opts=$"${opts}"
                ;;
            *)
                opts=$baseopts
        esac
        # don't drop the trailing space
        local IFS=$'\t\n'
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    elif [[ $mode == "profile" ]]; then
        opts="list 	create 	locate "
        local IFS=$'\t\n'
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    elif [[ $mode == "history" ]]; then
        if [[ $COMP_CWORD -ge 3 ]]; then
            # drop into flags
            opts="--"
        else
            opts="trim 	clear "
        fi
        local IFS=$'\t\n'
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    elif [[ $mode == "locate" ]]; then
        if [[ $COMP_CWORD -ge 3 ]]; then
            # drop into flags
            opts="--"
        else
            opts="profile "
        fi
        local IFS=$'\t\n'
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    elif [[ ${prev} == "--matplotlib"* ]] || [[ ${prev} == "--gui"* ]]; then
        if [ -z "$__ipython_complete_matplotlib" ]; then
            __ipython_complete_matplotlib=`cat <<EOF | python -
try:
    import IPython.core.shellapp as mod;
    for k in mod.InteractiveShellApp.matplotlib.values:
        print "%s " % k
except:
    pass
EOF
        `
        fi
        local IFS=$'\t\n'
        COMPREPLY=( $(compgen -W "${__ipython_complete_matplotlib}" -- ${cur}) )
    elif [[ ${prev} == "--profile"* ]]; then
        if [ -z  "$__ipython_complete_profiles" ]; then
        __ipython_complete_profiles=`cat <<EOF | python -
try:
    import IPython.core.profileapp
    for k in IPython.core.profileapp.list_bundled_profiles():
        print "%s " % k
    p = IPython.core.profileapp.ProfileList()
    for k in IPython.core.profileapp.list_profiles_in(p.ipython_dir):
        print "%s " % k
except:
    pass
EOF
        `
        fi
        local IFS=$'\t\n'
        COMPREPLY=( $(compgen -W "${__ipython_complete_profiles}" -- ${cur}) )
    else
        if [ "$COMP_CWORD" == 1 ]; then
            local IFS=$'\t\n'
            local sub=$(echo $subcommands | sed -e "s/ / \t/g")
            COMPREPLY=( $(compgen -W "${sub}" -- ${cur}) )
        else
            COMPREPLY=( $(compgen -f -- ${cur}) )
        fi
    fi

}

__ipython() {
    # local cur prev words cword split
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  # over 150+ default options 
  # opts="
    _init_completion -s || return

    if [[ ${cur} == -* ]]; then

    case $prev in
        --help|--version|-[?hVc])
            return 0
            ;;
        -m)
            _python_modules "$1"
            return 0
            ;;
      "profile")
        COMPREPLY=( $(compgen -W "list create locate" -- "$cur") )
        return 0
        ;;
      "history")
        COMPREPLY=( $(compgen -W "trim clear" -- "$cur") )
        return 0
        ;;
      "locate")
        COMPREPLY=( $(compgen -W "profile" -- "$cur") )
        return 0
        ;;
    esac
    fi

    # if [[ $cur == -* ]]; then
        # COMPREPLY=( $(compgen -W '$(_parse_help "$1")' -- "$cur") )
        # [[ $COMPREPLY == *= ]] && compopt -o nospace
        # return
    # fi

    # _filedir py
} && complete -o bashdefault -o default -o nosort -F __ipython -F _longopt ipython ipython3
# HOLY HELL THIS IS SO MUCH FASTER THAN THE ORIGINAL (probably because we circumvent the python portion mostly)

# ipython should do this
# complete -o bashdefault -o default -F _longopt -o filenames
# actually bashdefaults probably unnecessary
complete -f -F _longopt iptest iptest3
