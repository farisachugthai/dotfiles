.. ipython_readme:

=======================
IPython Startup Scripts
=======================

.. module:: IPython_README

:Author: Faris Chugthai
:Date: Feb 06, 2019


Configuration
~~~~~~~~~~~~~
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
~~~~~~~
The IPython magic ``%rehash`` allows you to reload all of your startup files
and also adds system commands to the namespace!

Insofar, I haven't noticed any significant slowdown in startup time as a result
of this, and it hugely eases utilizing IPython as a system shell.


other
~~~~~~

Sep 27, 2018:

Wrote a macro with :ref:`%macro lazydl _i`, used ``%store lazydl`` to save it,
then ran

.. ipython::

   %store lazydl >> 30_macros_lazydl.py

So that it persists for every :mod:`IPython` session. The char ``%`` is optional
as this configuration has ``automagic`` enabled.

It uses the :func:`input()`  to circumvent the fact that macros don't take
command line arguments.

.. todo:: Create an official docs section

.. Official Docs
.. --------------


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

.. _04_easy_import.py: ./04_easy_import.py
.. _05_log.py: ./05_log.py
.. _10_keybindings.py:  ./10_keybindings.py
.. _20_aliases.py: ./20_aliases.py
.. _30_macros_lazydl.py: ./30_macros_lazydl.py
.. _40_git_helpers.py: ./40_git_helpers.py
.. _41_dir3.py: ./41_dir3.py
.. _50_sysexception.py: ./50_sysexception.py
