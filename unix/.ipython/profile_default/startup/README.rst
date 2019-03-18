.. _ipython_startup_readme:

=======================
IPython Startup Scripts
=======================

.. module:: IPython_README

:Author: Faris Chugthai
:Date: Feb 23, 2019


Configuration
-------------
Here's a rough outline of what's going on in this directory.

.. todo::

   Should this go in the dir above because we're gonna be focusing on
   IPython configurations heavily enough that it warrants it? Or better to simply
   put only those notes in that dir and only comment on the startup scripts in this
   directory?

As of today, the files present are as follows:

04_easy_import.py_

05_log.py_

20_aliases.py_

40_git_helpers.py_

41_dir3.py_

50_sysexception.py_


%rehash
-------
01_rehashx.py_

The IPython magic ``%rehash`` allows you to reload all of your startup files
and also adds system commands to the namespace!

Insofar, I haven't noticed any significant slowdown in startup time as a result
of this, and it hugely eases utilizing IPython as a system shell.


.. todo::

.. Development and Contributing
.. This would be a good idea though.

Convenience Functions
-----------------------
:ref:`IPython` provides the functions :func:`IPython.Application.initialized()`
and :func:`IPython.Application.instance()`. As a result, each script can easily
implement the following as a check to ensure that the global IPython instance
is running.

.. code-block:: python

   if __name__ == "__main__":
      from IPython import Application.initialized
      import sys

      if not Application.initialized():
         sys.exit()

.. double check that what I'm saying below is true

Unfortunately, ``from IPython import Application`` may be a feature of IPython7.3,
which at the time of writing was released 3 days ago. If you don't have this
version of the module, you can alternatively run


.. code-block:: python

   from IPython.core.application import Application
   Application.initialized()


.. ipython::

   In [114]: IPython.Application.initialized?
   Signature: IPython.Application.initialized()
   Docstring: Has an instance been created?
   File:      ~/miniconda3/lib/python3.7/site-packages/traitlets/config/configurable.py
   Type:      method


   In [115]: IPython.Application.instance?
   Signature: IPython.Application.instance(*args, **kwargs)
   Docstring:
   Returns a global instance of this class.

   This method create a new instance if none have previously been created
   and returns a previously created instance is one already exists.

   The arguments and keyword arguments passed to this method are passed
   on to the :meth:`__init__` method of the class upon instantiation.

   Examples
   --------

   Create a singleton class using instance, and retrieve it::

       >>> from traitlets.config.configurable import SingletonConfigurable
       >>> class Foo(SingletonConfigurable): pass
       >>> foo = Foo.instance()
       >>> foo == Foo.instance()
       True

   Create a subclass that is retrived using the base class instance::

       >>> class Bar(SingletonConfigurable): pass
       >>> class Bam(Bar): pass
       >>> bam = Bam.instance()
       >>> bam == Bar.instance()
       True
   File:      ~/miniconda3/lib/python3.7/site-packages/traitlets/config/configurable.py
   Type:      method


Original
---------
This is the IPython startup directory

.py and .ipy files in this directory will be run *prior* to any code or files specified
via the exec_lines or exec_files configurables whenever you load this profile.

Files will be run in lexicographical order, so you can control the execution order of files
with a prefix, e.g.::

    00-first.py
    50-middle.py
    99-last.ipy

.. _01_rehashx.py: ./01_rehashx.py
.. _04_easy_import.py: ./04_easy_import.py
.. _05_log.py: ./05_log.py
.. _10_keybindings.py:  ./10_keybindings.py
.. _20_aliases.py: ./20_aliases.py
.. _30_macros_lazydl.py: ./30_macros_lazydl.py
.. _40_git_helpers.py: ./40_git_helpers.py
.. _41_dir3.py: ./41_dir3.py
.. _50_sysexception.py: ./50_sysexception.py
