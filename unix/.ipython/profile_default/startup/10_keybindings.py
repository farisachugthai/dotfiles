#!/usr/bin/env python
# -*- coding: utf-8 -*-
# pylint: disable invalid-name
""" Lets add some keybindings and really take off here.

The always lovely people at IPython provided you with an example.

`<https://ipython.readthedocs.io/en/stable/config/details.html#keyboard-shortcuts>`

It mentions to read up on events and filters.

https://python-prompt-toolkit.readthedocs.io/en/stable/pages/advanced_topics/key_bindings.html#move-about-key-bindings

There's no parallel docs for 1.0.15 so lets hope this outstandingly
long file isnt completely backwards incompatible.
"""

from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode

# Do this so you dont actually export insert_unexpected
#  __all__ = (
#      'configure',
#  )

# Global Variables

#  ip = get_ipython()

#  insert_mode = ViInsertMode()


#  def insert_unexpected(event):
#      buf = event.current_buffer
#      buf.insert_text('The Spanish Inquisition')
#      # Register the shortcut if IPython is using prompt_toolkit


#  if getattr(ip, 'pt_cli'):
#      registry = ip.pt_cli.application.key_bindings_registry
#      registry.add_binding(Keys.ControlN,
#                           filter=(HasFocus(DEFAULT_BUFFER)
#                                   & ~HasSelection()
#                                   & insert_mode))(insert_unexpected)

# now what do i have to do to bind FZF to C-r...
