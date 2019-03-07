======
README
======

.. module:: extensions-readme
   :synopsis: Summary of all IPython extensions.

Creating IPython Extensions
-------------------------------
*Summarized from "Learning IPython for Interactive Computing and Data
Visualization 1st ed.pdf"*:

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

   .. code-block:: python3

       _ip = get_ipython()


Here are 2 useful functuons for registering a magic with the global IPython
instance.

.. ipython::

   In [37]: _ip.register_magic_function?
   Signature: _ip.register_magic_function(func, magic_kind='line', magic_name=None)
   Docstring:
   Expose a standalone function as magic function for IPython.

   This will create an IPython magic (line, cell or both) from a
   standalone function.  The functions should have the following
   signatures:

   + For line magics: `def f(line)`
   + For cell magics: `def f(line, cell)`
   + For a function that does both: `def f(line, cell=None)`

   In the latter case, the function will be called with `cell==None` when
   invoked as `%f`, and with cell as a string when invoked as `%%f`.

   Parameters
   ----------
   func : callable
     Function to be registered as a magic.

   magic_kind : str
     Kind of magic, one of 'line', 'cell' or 'line_cell'

   magic_name : optional str
     If given, the name the magic will have in the IPython namespace.  By
     default, the name of the function itself is used.
   File:      ~/virtualenvs/scistack/lib/python3.7/site-packages/IPython/core/magic.py
   Type:      method


   In [38]: _ip.register_magics?
   Signature: _ip.register_magics(*magic_objects)
   Docstring:
   Register one or more instances of Magics.

   Take one or more classes or instances of classes that subclass the main
   `core.Magic` class, and register them with IPython to use the magic
   functions they provide.  The registration process will then ensure that
   any methods that have decorated to provide line and/or cell magics will
   be recognized with the `%x`/`%%x` syntax as a line/cell magic
   respectively.

   If classes are given, they will be instantiated with the default
   constructor.  If your classes need a custom constructor, you should
   instanitate them first and pass the instance.

   The provided arguments can be an arbitrary mix of classes and instances.

   Parameters
   ----------
   magic_objects : one or more classes or instances
   File:      ~/virtualenvs/scistack/lib/python3.7/site-packages/IPython/core/magic.py
   Type:      method

Example usage exists on the official website as well.
