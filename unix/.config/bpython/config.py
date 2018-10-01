#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Bpython config.

This is a standard python config file
Valid values can be True, False, integer numbers, strings
By default bpython will look for $XDG_CONFIG_HOME/bpython/config
($XDG_CONFIG_HOME defaults to ~/.config) or you can specify a file with the
--config option on the command line

URL::
    http://docs.bpython-interpreter.org/configuration.html

Refer to the link above for all configurable options
"""
from os.path import expanduser, join as pjoin
# import time

# dont touch this until you're ready to handwrite a logger
# LOG_TIMESTAMP=time.ctime()

home = expanduser('~')

[general]  # noqa

# Display the autocomplete list as you type (default: True).
# When this is off, you can hit tab to see the suggestions.
auto_display_list = True

# Syntax highlighting as you type (default: True).
syntax = True

# Display the arg spec (list of arguments) for callables,
# when possible (default: True).
arg_spec = True

# History file (default: ~/.pythonhist):
# TODO: Add in a datetime object that creates a new file for everyday
try:
    hist_file = pjoin(home, '.local', 'share', 'bpython.log')
except Exception as e:
    print(e)
    hist_file = pjoin(home, '.pythonhist')

# Number of lines to store in history (set to 0 to disable) (default: 100):
hist_length = 10000

# Soft tab size (default: 4, see pep-8):
tab_length = 4

# Color schemes should be put in $XDG_CONFIG_HOME/bpython/
# to use the theme $XDG_CONFIG_HOME/bpython/foo.theme,
# set color_scheme = foo.
# color_scheme = default

# External editor to use for editing the current line, block, or full history
# Default is to try $EDITOR and $VISUAL, then vi - but if you uncomment
# the line below that will take precedence
# actually is this supposed to be a string? Im using my value for both env
# vars anyway
# editor = nvim

# Whether to append .py to the filename while saving session to a file.
# (default: False)
save_append_py = True

# The name of a helper executable that should perform pastebin upload on
# bpython's behalf. If unset, bpython uploads pastes to bpaste.net. (default: )
# pastebin_helper = gist.py

# How long an undo must be expected to take before prompting for how
# many lines should be undone. Set to -1 to never prompt, or 0 to
# always prompt.
# single_undo_time = 1.0

# Enable autoreload feature by default (default: False).
# default_autoreload = False

[keyboard]  # noqa

# All key bindings are shown commented out with their default binding

# pastebin = F8
# last_output = F9
# reimport = F6
# help = F1
# toggle_file_watch = F5
# save = C-s
# undo = C-r
# up_one_line = C-p
# down_one_line = C-n
# cut_to_buffer = C-k
# search = C-o
# yank_from_buffer = C-y
# backspace = C-h
# clear_word = C-w
# clear_line = C-u
# clear_screen = C-l
# show_source = F2
# exit = C-d
# external_editor = F7

# should duplicate in ipython
# edit_config = F3
# reverse_incremental_search = M-r
# incremental_search = M-s

# Also wth is curtsies?
[curtsies]  # noqa

# Allow the the completion and docstring box above the current line
# (default: False)
# list_above = False

# How did he enable this functionality? I would love to have this in ipython
# Enables two fish (the shell) style features:
# Previous line key will search for the current line (like reverse incremental
# search) and right arrow will complete the current line with the first match
# from history. (default: True)
right_arrow_completion = True
