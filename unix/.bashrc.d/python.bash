# bash completion for python                               -*- shell-script -*-

_python_modules()
{
    COMPREPLY+=( $(compgen -W \
        "$(${1:-python} ${BASH_SOURCE[0]%/*}/../helpers/python $cur \
           2>/dev/null)" -- "$cur") )
}

_python_warning_actions()
{
    COMPREPLY+=( $(compgen -W "ignore default all module once error" \
                           ${prefix:+-P "$prefix"} -- "$cur") )
}

_python()
{
    local cur prev words cword prefix
    _init_completion || return

    case $cur in
        -[QWX]?*)
            prefix=${cur:0:2}
            prev=$prefix
            cur=${cur:2}
        ;;
    esac

    case $prev in
        --help|--version|-!(-*)[?hVcX])
            return
            ;;
        -!(-*)m)
            _python_modules "$1"
            return
            ;;
        -!(-*)Q)
            COMPREPLY=( $(compgen -W "old new warn warnall" -P "$prefix" \
                -- "$cur") )
            return
            ;;
        -!(-*)W)
            _python_warning_actions
            return
            ;;
        --jit)
            # TODO: quite a few others, parse from "--jit help" output?
            COMPREPLY=( $(compgen -W "help off" -- "$cur") )
            return
            ;;
        !(?(*/)python*([0-9.])|?(*/)pypy*([0-9.])|-?))
            [[ $cword -lt 2 || ${words[cword-2]} != -[QWX] ]] && _filedir
            ;;
    esac


    # if -c or -m is already given, complete all kind of files.
    if [[ "${words[*]::$cword}" == *\ -[cm]\ * ]]; then
        _filedir
    elif [[ "$cur" != -* ]]; then
        _filedir 'py?([cowz])'
    else
        COMPREPLY=( $(compgen -W '$(_parse_help "$1" -h)' -- "$cur") )
    fi
} &&
complete -F _python python python2 python3 pypy pypy3 micropython

# ex: filetype=sh
