" Markdown ftplugin
" Maintainer: Faris Chugthai
" TODO: Maybe come up with a maplocalleader or something and toggle syntax or
" something
" Fix the way that '_' is highlighted in md

if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1
let s:keepcpo= &cpoptions
set cpoptions&vim

" Enable spellchecking
setlocal spell

" Automatically wrap at 80 characters
setlocal textwidth=80

set colorcolumn=+1

" Fix tabs so that we can have ordered lists render properly
setlocal shiftwidth=2 softtabstop=2 tabstop=2
