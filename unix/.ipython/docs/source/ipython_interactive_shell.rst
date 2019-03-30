==========================
IPython_InteractiveShell
==========================
Created Saturday 03 March 2018

`https://github.com/ipython/ipython/blob/master/IPython/core/interactiveshell.py <https://github.com/ipython/ipython/blob/master/IPython/core/interactiveshell.py>`_
lines 436-451

Here's some interesting LOC from the source code.

.. code-block:: python

        # Subcomponents of InteractiveShell
        alias_manager = Instance('IPython.core.alias.AliasManager', allow_none=True)
        prefilter_manager = Instance('IPython.core.prefilter.PrefilterManager', allow_none=True)
        builtin_trap = Instance('IPython.core.builtin_trap.BuiltinTrap', allow_none=True)
        display_trap = Instance('IPython.core.display_trap.DisplayTrap', allow_none=True)
        extension_manager = Instance('IPython.core.extensions.ExtensionManager', allow_none=True)
        payload_manager = Instance('IPython.core.payload.PayloadManager', allow_none=True)
        history_manager = Instance('IPython.core.history.HistoryAccessorBase', allow_none=True)
        magics_manager = Instance('IPython.core.magic.MagicsManager', allow_none=True)
        profile_dir = Instance('IPython.core.application.ProfileDir', allow_none=True)

        @property
        def profile(self):
            if self.profile_dir is not None:
                name = os.path.basename(self.profile_dir.location)
            return name.replace('profile_','')


February 25, 2019

Gotta admit though, I don't know what that :class:`Instance()` is and I assume
it's a bit of the crux of the whole point.
