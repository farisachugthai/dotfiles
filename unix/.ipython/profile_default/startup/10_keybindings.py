#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" Don't push yet but there's a section in the IPython docs where they
give an example of a keybinding manager!!!

Chapter 5.1
Configuring IPython
Release 6.4.0

page 393

For more information on filters and what you can do with the event object, see
the prompt_toolkit docs.
"""

from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode

ip = get_ipython()
insert_mode = ViInsertMode()


def insert_unexpected(event):
    buf = event.current_buffer
    buf.insert_text('The Spanish Inquisition')


# Register the shortcut if IPython is using prompt_toolkit
if getattr(ip, 'pt_cli'):
    registry = ip.pt_cli.application.key_bindings_registry
    registry.add_binding(Keys.ControlN,
                    filter=(HasFocus(DEFAULT_BUFFER)
                            & ~HasSelection()
                            & insert_mode))(insert_unexpected)
