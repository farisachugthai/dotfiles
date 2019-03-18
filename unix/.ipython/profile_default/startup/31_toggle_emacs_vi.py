#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Allow the user to toggle between Emacs and Vi mode using F4.

Also add a bottom toolbar.

Dude...

So I was getting errors from the linters before I ran anything. Import statements
don't cover EditingMode. Fuck the docs let's just go to the source.

..wth?

.. code-block:: python

    from __future__ import unicode_literals


    class EditingMode(object):
        # The set of key bindings that is active.
        VI = 'VI'
        EMACS = 'EMACS'


    #: Name of the search buffer.
    SEARCH_BUFFER = 'SEARCH_BUFFER'

    #: Name of the default buffer.
    DEFAULT_BUFFER = 'DEFAULT_BUFFER'

    #: Name of the system buffer.
    SYSTEM_BUFFER = 'SYSTEM_BUFFER'

I'm sorry I'm just gonna rewrite that. It definitely doesn't feel like it
was too hard to write...

:URL: https://python-prompt-toolkit.readthedocs.io/en/master/pages/asking_for_input.html#dynamically-switch-between-emacs-and-vi-mode # noqa

**But we still need to bind this to IPython!**

"""
from prompt_toolkit import prompt
from prompt_toolkit.application.current import get_app
from prompt_toolkit.key_binding import KeyBindings


class EditingMode():
    """Determine the mode that IPython is loaded in."""

    VI = 'VI'
    EMACS = 'EMACS'


def vim_prompt_run():
    """Create a set of key bindings."""
    bindings = KeyBindings()

    # Add an additional key binding for toggling this flag.
    @bindings.add('f4')
    def _(event):
        """Toggle between Emacs and Vi mode."""
        app = event.app

        if app.editing_mode == EditingMode.VI:
            app.editing_mode = EditingMode.EMACS
        else:
            app.editing_mode = EditingMode.VI

    # Add a toolbar at the bottom to display the current input mode.
    def bottom_toolbar():
        """Display the current input mode."""
        text = 'Vi' if get_app().editing_mode == EditingMode.VI else 'Emacs'
        return [('class:toolbar', ' [F4] %s ' % text)]

    prompt('> ', key_bindings=bindings, bottom_toolbar=bottom_toolbar)


if __name__ == "__main__":
    vim_prompt_run()
