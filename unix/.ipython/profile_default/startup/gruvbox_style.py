#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    Gruvbox Colorscheme
    ~~~~~~~~~~~~~~~~~
    A retro groove color scheme for Vim.
    https://github.com/morhetz/gruvbox

    © 2012-2015 Pavel Pertsev
    Adapted for Pygments by Dave Yarwood

    Converted by Vim Colorscheme Converter
    https://github.com/honza/vim2pygments
"""
from pygments.style import Style
from pygments.token import (Token, Comment, Name, Keyword, Generic, Number,
                            Operator, String)


class GruvboxStyle(Style):
    """Retro groove color scheme for Vim by Github: @morhetz

    :URL: https://github.com/daveyarwood/gruvbox-pygments

    Installation instructions from
    `https://github.com/daveyarwood/gruvbox-pygments`_

    Installation
    -------------

    For those who do not want to directly add to the source directories of the
    project, clone this repo to a suitable
    place, for example, ~/.local/scripts/gruvbox-pygments, change directory to
    this location and run:

    .. code-block:: python

        sudo python setup.py develop

    This will hook in this style into pygments without editing the source
    directories of pygments iteself. Do not delete this directory as this where
    python will be looking for this style file.
    

    .. note::

        Background color modified to value for hard contrast.

    """

    background_color = '#1d2021'
    styles = {
        Comment.Preproc: 'noinherit #8ec07c',
        Comment: '#928374 italic',
        Generic.Deleted: 'noinherit #282828 bg:#fb4934',
        Generic.Emph: '#83a598 underline',
        Generic.Error: 'bg:#fb4934 bold',
        Generic.Heading: '#b8bb26 bold',
        Generic.Inserted: 'noinherit #282828 bg:#b8bb26',
        Generic.Output: 'noinherit #504945',
        Generic.Prompt: '#ebdbb2',
        Generic.Strong: '#ebdbb2',
        Generic.Subheading: '#b8bb26 bold',
        Generic.Traceback: 'bg:#fb4934 bold',
        Generic: '#ebdbb2',
        Keyword.Type: 'noinherit #fabd2f',
        Keyword: 'noinherit #fe8019',
        Name.Attribute: '#b8bb26 bold',
        Name.Builtin: '#fabd2f',
        Name.Constant: 'noinherit #d3869b',
        Name.Entity: 'noinherit #fabd2f',
        Name.Exception: 'noinherit #fb4934',
        Name.Function: '#fabd2f',
        Name.Label: 'noinherit #fb4934',
        Name.Tag: 'noinherit #fb4934',
        Name.Variable: 'noinherit #ebdbb2',
        Name: '#ebdbb2',
        Number.Float: 'noinherit #d3869b',
        Number: 'noinherit #d3869b',
        Operator: '#fe8019',
        String.Symbol: '#83a598',
        String: 'noinherit #b8bb26',
        Token: 'noinherit #ebdbb2 bg:#282828',
    }
