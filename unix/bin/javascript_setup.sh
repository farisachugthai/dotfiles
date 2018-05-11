#!/bin/bash
# Maintainer: Faris Chugthai

# Get some npm packages I like.

n="npm install -g"

$n neovim
$n prettier
$n proselint

unset n

exit 0
