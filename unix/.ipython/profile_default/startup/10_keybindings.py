#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Module for managing keybindings in IPython.

Keybindings in IPython
=======================

Double check that termux has the right version of prompt because I'm
seeing different modules to import. Or theres a bug because there were
literally no modules with docstrings according to IPython.

Currently using 1.0.15 - 2018-09-07

Oct 30, 2018:
    IPython 7.1.1 ships with pt2!

Run in shell
-----------------------

Here's a little function I found today that might help guide this along
in a more streamlined manner::

    import IPython
    IPython.terminal.interactiveshell.create_ipython_shortcuts()

So alternatively you can do::

    from IPython import get_ipython
    from IPython.terminal.interactiveshell import create_ipython_shortcuts
    ip = get_ipython()
    c = create_ipython_shortcuts(ip)

    # This will give you the following methods
    [ins] In [11]: dir(c)
    Out[11]:
    ['_KeyBindings__version',
    '__abstractmethods__',
    '__class__',
    '__delattr__',
    '__dict__',
    '__dir__',
    '__doc__',
    '__eq__',
    '__format__',
    '__ge__',
    '__getattribute__',
    '__gt__',
    '__hash__',
    '__init__',
    '__init_subclass__',
    '__le__',
    '__lt__',
    '__module__',
    '__ne__',
    '__new__',
    '__reduce__',
    '__reduce_ex__',
    '__repr__',
    '__setattr__',
    '__sizeof__',
    '__str__',
    '__subclasshook__',
    '__weakref__',
    '_abc_impl',
    '_clear_cache',
    '_get_bindings_for_keys_cache',
    '_get_bindings_starting_with_keys_cache'
    '_version',
    'add',
    'add_binding',
    'bindings',
    'get_bindings_for_keys',
    'get_bindings_starting_with_keys',
    'remove',
    'remove_binding']

c.bindings has some useful info.
No perceptible difference between add and add_binding.

Couldn't get 'get_bindings_for_keys' to work unfortunately.
Ran with one arg with a known key ('c-p') and got an empty response ([]).
Ran with ('c-p', filter=HasFocus(DEFAULTBUFFER))
and got an error.
Ran with 2 keys and got an err.

Help on function create_ipython_shortcuts in IPython.terminal.interactiveshell:

IPython.terminal.interactiveshell.create_ipython_shortcuts = create_ipython_shortcuts(shell)
    Set up the prompt_toolkit keyboard shortcuts for IPython


Original File Implementation
----------------------------

Found the file where the default keybindings are listed.

Go to the ipython root dir

ipython::

    %cd terminal
    %pycat shortcuts

Up at the top you have the keybindings IPython ships with listed for ya!

Sep 24, 2018:
    Commented everything out.

.. todo::

    Check whether were running in IPython or Jupyter console because these
    imports break jupyter.

Why the hell does Jupyter import everything IPython uses btw???
"""
# this right here is the mod we need to keep our eyes on.
# from prompt_toolkit.key_binding.registry import Registry
# from prompt_toolkit.key_binding.defaults import load_key_bindings

# from IPython import get_ipython
# from prompt_toolkit.enums import DEFAULT_BUFFER
# from prompt_toolkit.keys import Keys
# from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode

# ip = get_ipython()
# insert_mode = ViInsertMode()


#  def insert_unexpected(event):
#      """ From the IPython examples on keybinding configuration."""
#      buf = event.current_buffer
#      buf.insert_text('The Spanish Inquisition')


# hahahaha and boy was it unexpected! forgot to comment this guy out
# Register the shortcut if IPython is using prompt_toolkit
#  if getattr(ip, 'pt_cli'):
#      registry = ip.pt_cli.application.key_bindings_registry
#      registry.add_binding(Keys.ControlN,
#                   filter=(HasFocus(DEFAULT_BUFFER)
#                                  & ~HasSelection()
#                              & insert_mode))(insert_unexpected)
# and basically continue on in this fashion for as long as you need
# ipython barely comes with any keybindings
# i'm gonna drop 2 that i thought were intesting though

# Ctrl+I == Tab
# flake: noqa
# registry.add_binding(Keys.ControlI,
# filter=(HasFocus(DEFAULT_BUFFER)
# & ~HasSelection()
# & insert_mode
# & cursor_in_leading_ws))(indent_buffer)
# flake: qa

# also because i didn't know or remember these were keybindings
#          # Ctrl+J == Enter, seemingly
#          registry.add_binding(Keys.ControlJ,
#                               filter=(HasFocus(DEFAULT_BUFFER)
#                                       & ~HasSelection()
#                                       & insert_mode
#                              ))(return_handler)
#  def pure_pt_way():
#      """From the pt docs:

#      It is also possible to combine multiple registries. We do this in the default
#      key bindings. There are some registries that contain Emacs bindings, while
#      others contain the Vi bindings. They are merged together using a
#      `MergedRegistry`.

#      We also have a `ConditionalRegistry` object that can enable/disable a group of
#      key bindings at once.
#      """
#      pass


#  r = Registry()


#  @r.add_binding(Keys.ControlX, Keys.ControlC, filter=INSERT)
#  def handler(event):
#      """ A quick snippet to give you a flavor of the syntax.
#      Gotta figure out what's up with that filter param over there.
#      Luckily I think that keybindings actually don't need function bodies
#      The decorator's doing all the heavy lifting for ya! I think...
#      """
#      # Handle ControlX-ControlC key sequence.
#      pass


#  def check_defaults():
#      """ What are the default keybindings we have here?
#      Err I suppose I should say what does pt export by default because I'm
#      not 100% sure that ip imports everything or doesn't modify anything along
#      the way.
#      """
#      registry = load_key_bindings()
#      print(registry.key_bindings)


#  def actual_ipython_implementation():
#      """ wooo!
#      In [93]: pycat shortcuts.py
#      Module to define and register Terminal IPython shortcuts with
#      :mod:`prompt_toolkit`

#   Copyright (c) IPython Development Team.
#   Distributed under the terms of the Modified BSD License.
#      """

#      import warnings
#      import signal
#      import sys
#      from typing import Callable


#      from prompt_toolkit.enums import DEFAULT_BUFFER, SEARCH_BUFFER
#      from prompt_toolkit.filters import (HasFocus, HasSelection, Condition,
#          ViInsertMode, EmacsInsertMode, HasCompletions)
#      from prompt_toolkit.filters.cli import ViMode, ViNavigationMode
#      from prompt_toolkit.keys import Keys
#      from prompt_toolkit.key_binding.bindings.completion import display_completions_like_readline

#      from IPython.utils.decorators import undoc

#      @undoc
#      @Condition
#      def cursor_in_leading_ws(cli):
#          before = cli.application.buffer.document.current_line_before_cursor
#          return (not before) or before.isspace()

#      def register_ipython_shortcuts(registry, shell):
#          """Set up the prompt_toolkit keyboard shortcuts for IPython"""
#          insert_mode = ViInsertMode() | EmacsInsertMode()

#          if getattr(shell, 'handle_return', None):
#              return_handler = shell.handle_return(shell)
#          else:
#              return_handler = newline_or_execute_outer(shell)

#          # Ctrl+J == Enter, seemingly
#          registry.add_binding(Keys.ControlJ,
#                               filter=(HasFocus(DEFAULT_BUFFER)
#                                       & ~HasSelection()
#                                       & insert_mode
#                              ))(return_handler)

#          registry.add_binding(Keys.ControlBackslash)(force_exit)

#          registry.add_binding(Keys.ControlP,
#                               filter=(ViInsertMode() & HasFocus(DEFAULT_BUFFER)
#                              ))(previous_history_or_previous_completion)

#          registry.add_binding(Keys.ControlN,
#                               filter=(ViInsertMode() & HasFocus(DEFAULT_BUFFER)
#                              ))(next_history_or_next_completion)

#          registry.add_binding(Keys.ControlG,
#                               filter=(HasFocus(DEFAULT_BUFFER) & HasCompletions()
#                              ))(dismiss_completion)

#          registry.add_binding(Keys.ControlC, filter=HasFocus(DEFAULT_BUFFER)
#                              )(reset_buffer)

#          registry.add_binding(Keys.ControlC, filter=HasFocus(SEARCH_BUFFER)
#                              )(reset_search_buffer)

#          supports_suspend = Condition(lambda cli: hasattr(signal, 'SIGTSTP'))
#          registry.add_binding(Keys.ControlZ, filter=supports_suspend
#                              )(suspend_to_bg)

#          # Ctrl+I == Tab
#          registry.add_binding(Keys.ControlI,
#                               filter=(HasFocus(DEFAULT_BUFFER)
#                                       & ~HasSelection()
#                                       & insert_mode
#                                       & cursor_in_leading_ws
#                              ))(indent_buffer)

#          registry.add_binding(Keys.ControlO,
#                               filter=(HasFocus(DEFAULT_BUFFER)
#                                      & EmacsInsertMode()))(newline_autoindent_outer(shell.input_splitter))

#          registry.add_binding(Keys.F2,
#                               filter=HasFocus(DEFAULT_BUFFER)
#                              )(open_input_in_editor)

#          if shell.display_completions == 'readlinelike':
#              registry.add_binding(Keys.ControlI,
#                                   filter=(HasFocus(DEFAULT_BUFFER)
#                                           & ~HasSelection()
#                                           & insert_mode
#                                           & ~cursor_in_leading_ws
#                                  ))(display_completions_like_readline)

#          if sys.platform == 'win32':
#              registry.add_binding(Keys.ControlV,
#                                   filter=(
#                                   HasFocus(
#                                   DEFAULT_BUFFER) & ~ViMode()
#                                  ))(win_paste)
