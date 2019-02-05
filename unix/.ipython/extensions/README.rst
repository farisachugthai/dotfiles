README
=======


Creating IPython Extensions
-------------------------------

*Summarized from "Learning IPython for Interactive Computing and Data Visualization 1st ed.pdf""*

..

To create an extension, we need to create a Python module in a
directory, which is in the Python path. A possibility is to put it in
the current directory, or in your `IPython dir <IPYTHONDIR/extensions>`

An extension implements a :function:`load_ipython_extension(ipython)`, which
takes the current ``InteractiveShell`` instance as an argument (and possibly
:function:`unload_ipython_extension(ipython)`, which is called when
the extension is unloaded). This instance can be used to register new
magic commands, access the user namespace, execute code, and so on.
This loading function is called whenthe extension is loaded, which
happens when the

.. ipython::

   %load_ext  # or
   %reload_ext magic

command is executed. To automatically load a module when IPython starts,
we need to add the module name to the ``c.TerminalIPythonApp.extensions``
list in the IPython configuration file.
The ``InteractiveShell`` instance represents the active
IPython interpreter. Useful methods and attributes include
:function:`register_magics()`, to create new magic commands,
and ``user_ns``, to access the user namespace. You can
explore all the instance's attributes interactively from
:mod:`IPython` with tab completion. For that, you need to execute
the following command to get the current instance

.. code-block:: python

    ip = get_ipython()
