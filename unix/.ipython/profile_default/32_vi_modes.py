#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Add a keybinding to IPython.

Effectively adds :kbd:`j` :kbd:`k` to the <Esc> sequence that takes Vim from
insert mode to normal mode.

Also displays how to integrate prompt_toolkit and IPython together well.

:URL: https://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts

"""
from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, ViInsertMode
from prompt_toolkit.key_binding.vi_state import InputMode


def switch_to_navigation_mode(event):
    """Switches IPython from Vim insert mode to Vim normal mode.

    The function we can work with in the future if we want to change the
    keybinding for insert to navigation mode.
    """
    vi_state = event.cli.vi_state
    vi_state.input_mode = InputMode.NAVIGATION


if __name__ == "__main__":
    _ip = get_ipython()

    if getattr(_ip, 'pt_app', None):
        registry = _ip.pt_app.key_bindings
        registry.add_binding(
            u'j', u'k', filter=(HasFocus(DEFAULT_BUFFER)
                                & ViInsertMode()))(switch_to_navigation_mode)
