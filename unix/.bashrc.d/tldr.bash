#!/bin/bash
# Mar 01, 2019:
# While this is a really short script it gives a nice skeleton for how to make
# a simple app that utilizes autocompletion in the shell!

function _tldr_autocomplete {
  sheets=$(tldr -l -1)
  COMPREPLY=()
  if [[ $COMP_CWORD = 1 ]]; then
    COMPREPLY=(`compgen -W "$sheets" -- $2`)
  fi
}

complete -F _tldr_autocomplete tldr
