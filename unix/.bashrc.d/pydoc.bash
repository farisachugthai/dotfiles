# pydoc completion                                         -*- shell-script -*-

_pydoc()
{
    local cur prev words cword
    _init_completion || return

    case $prev in
        -k|-p)
            return
            ;;
        -w)
            _filedir
            return
            ;;
    esac

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $(compgen -W \
            '$("$1" | command sed -e "s/^pydoc3\{0,1\} //" | _parse_help -)' \
            -- "$cur") )
        return
    fi

    COMPREPLY=( $(compgen -W 'keywords topics modules' -- "$cur") )

    if [[ $cur != @(.|*/)* ]]; then
        local python=python; [[ ${1##*/} == *3* ]] && python=python3
        _xfunc python _python_modules $python
    fi

    # Note that we don't do "pydoc modules" as it is known to hang on
    # some systems; _python_modules tends to work better and faster.
    COMPREPLY+=( $(compgen -W \
        '$($1 keywords topics | command sed -e /^Here/d)' -- "$cur") )

    _filedir py
} &&
complete -F _pydoc pydoc pydoc3

# ex: filetype=sh
