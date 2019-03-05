IPython Magics
================

.. module:: ipython_magics
   :Synopsis: Summarizes IPython magics.

.. contents:: Table of Contentn
    :depth: 2
    :backlinks: entries
    :local: True

------------------------------------------

.. _questions:

Questions you had in the past:
--------------------------------

**Please review regularly! Let's see if we can figure these out.**

1. Why doesn't ``%matplotlib inline`` work on my laptop? The GUI has to be enabled?
But even when i run ``%GUI`` [which should disable that] it doesn't work.

2. Are you allowed to use 2 cell magics in one cell?
What if I wanted to do

.. ipython::

    %%timeit
    %%bash
    . ~/.bashrc

Is that legal?
What if I want to write the output to a file? Can I prepend the ``%%file`` to
the top? How deep can this rabbit hole go?

.. _defined_magics:
Which magics are defined here?

.. _line:

Line:
------

hist[ory], pycat (briefly), recall, ed[it], bookmark, run, store, save


.. _cell:

Cell:
-----

[write]file, timeit [also a line magic just not documented], macro


Which magics do you think deserve a special mention even if we haven't 
documented them here?

1.
``Alias`` probably should get some attention here now that i have an egregious
amount on it in .bashrc and the ipy config.

2.
``cpaste`` is neat because you can feed it lines that still have the >>> or 
[In] and [Out] prepended.

3.
``paste directly`` pulls from the clipboard without intervention AND it strips
a leading > so you can pull it from diff files!!

Special special mention.
``:py:function:exec()`` is not a magic but I actually thought it was!

In [18]: exec(In[6])

exec() is a fucking Python built-in that just takes strings, but it can operate on
history syntax. Idk how to traverse sessions yet and idk if it can.

exec ~2/4
successfully printed the 4th line from 2 sessions ago that I wanted,
but it wouldn't redir to exec() correctly. Maybe

.. ipython::

    var = %history ~2/4
    exec(var)

would work better?

And in the future PLEASE keep hist, file, and edit together and in that order!



.. useful_reminder:

The most useful reminder I have
--------------------------------

**07/16/18**

tldr; use the following to view previously run commands last session.

.. ipython::

    `hist ~1/`              # NOTE FROM FARIS: hist ~1 OUTPUTS NOTHING DONT FORGET THE /

use the following to to reload every command you ran last session into your
current cell.

.. ipython::

    `recall ~1/`

Super fucking useful stuff.
Pissed i lost my work tho i seriously made a lot of modifications to the whole
doc :/  Be weary using the `:Man` command in :mod:`pynvim` for a lil.

Nov 20, 2018:

Got the problem with man fixed up but like 2 nights ago nvim crashed on me again.

.. _magics:


IPython's Magics
==================

``timeit()``

So this isn't an amazing example but hey.
It's me optimizing and saving a tiny bit of time because I thought in advance.
I ran this is as a cell magic.

Idk if the 3 q's actually compound but originally the last line was
print(i) which was horrible.

-r 5 means repeat the whole cell block 5 times.
-o means create a variable that stays in the ipython namespace for further investigation.
[wait what variable were you saving wth?]

This shell makes EVERYTHING SO EASY MY GOD

.. code-block:: ipython

    In [20]: %%timeit -qqq -r 5 -o
    ...:
    ...: env_var = sorted(os.environ.keys())
    ...: for i in env_var:
    ...:     match = re.match('CONDA*', i)
    ...:     if match:
    ...:         i
    ...:
    ...:
    Out[20]: <TimeitResult : 185 µs ± 890 ns per loop (mean ± std. dev. of 5 runs, 10000 loops each)>

    In [21]: %%timeit -qqq -r 5 -o
    ...:
    ...: for i in os.environ.keys():
    ...:     match = re.match('CONDA*', i)
    ...:     if match:
    ...:         i
    ...:
    Out[21]: <TimeitResult : 207 µs ± 2.31 µs per loop (mean ± std. dev. of 5 runs, 1000 loops each)>

2018-09-07

Speaking of timeit I just gave this a whirl to try and see.

.. ipython::

    %%timeit
    !nvim random-python-file.py +qall

You could also add in the option `--startuptime anything.txt`.

Jan 31, 2019:

    Now we can choose between ``%nvim file.filetype`` and
    ``%edit file.filetype`` as well!

If the file exists nvim is smart enough to append. Once you get a really
solid command down, ya know proper level of verbosity, good directory location
that's easy to see and not forget about, proper file extension because idk if
that'd affect how we handle the file afterwards in terms of loaded plugins
if we wanna do anything programmatic with it,
then you could take that awesome command and make a macro for it!

With an easy to use macro, i think we'd have a simple way of profiling nvim.

tl;dr: Keep chipping away and we might have a macro or extension to profile
nvim startup time on our hands.

.. _macro:

macro
--------

I found a link on <https://gist.github.com> that shows you how to make jupyter
notebook cells wider. So I figured I'd do something like

.. ipython::

    %macro widen_jupyter_cells

Fuck where does it go when i exit the session?

2018-09-07

Also is that a macro or a magic?

.. _store:

store
------

``%store 'widen_jupyter_cells'``

As a heads up that's in your db. Figured I'd mention it as it was a
great use of the magic system man! I'm learning more and more and I'm still
not even done exploring IPython.

This interpreter is legitimately fucking unbelievable! love it. 
Might glance at some rust tonight for no reason.
Or some JS so i can hack the internet :P

Wow that's a helpful description of the command lol you dick.

Here's the official help. I think it'd be good because you could make a
really simple alias...to add more aliases. Erhm how about you read the help.

.. ipython::
    
    In[1]: store?
    Out[1]:
    * ``%store foo >a.txt``  - Store value of foo to new file a.txt
    * ``%store foo >>a.txt`` - Append value of foo to file a.txt

It should be noted that if you change the value of a variable, you
need to ``%store`` it again if you want to persist the new value.

Note also that the variables will need to be pickleable; however, most basic
python types can be safely %store'd.

Also aliases can be %store'd across sessions.

Cool. So we could make a file in `$IPYTHON/profile_default/startup/` for all of
our aliases right? should probably separate them out of the main config file as
i can foresee that list BLOWING up.

Then we'd have a command like

.. ipython::

    %store new_alias >> $IPYTHON/profile_default/startup/40_alias.py

then we'd make a persistent macro like so

.. ipython::

    %macro add_alias 'store...'

at least i think. the difference between macro and alias is that alias is for
shell commands and macro for ipython commands?

yeah that's a good summary of it.
but then fuck how do we make sure that the macro persists across sessions?
because by default it won't. don't worry man i got you.

.. _save:

save
-----

In [43]: save?
Docstring:
Save a set of lines or a macro to a given filename.

Usage:
%save [options] filename n1-n2 n3-n4 ... n5 .. n6 ...

Options:

-r: use 'raw' input.  By default, the 'processed' history is used,
so that magics are loaded in their transformed version to valid
Python.  If this option is given, the raw input as typed as the
command line is used instead.

-f: force overwrite.  If file exists, %save will prompt for overwrite
unless -f is given.

-a: append to the file instead of overwriting it.

This function uses the same syntax as %history for input ranges,
then saves the lines to the filename you specify.

It adds a '.py' extension to the file if you don't do so yourself, and
it asks for confirmation before overwriting existing files.

If `-r` option is used, the default extension is `.ipy`.
File:      ~/miniconda3/lib/python3.6/site-packages/IPython/core/magics/code.py

.. _hist:

hist
------

the syntax for accessing history is admittedly wonky

.. _recent_commands:

viewing recently run commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if you run _i or __i you see the last two commands inputs.
if you run _ or __ you get to see the last 2 commands outputs.
this works for only the last 3 commands though!

you can also give cell numbers so

_i10 gives the input for cell 10 as a string

exec _i
the exec command means run the above input again.

theres also a way to access things from previous sessions. which ill discuss
later.

.. _output:

output
~~~~~~~

Oddly harder than just input.
You can easily access relative previous input with `_i`,  `_ii` and `_iii_`

You can also call specific cell numbers with `_i[cell]`

But you can't call cell numbers for output. `_` , `__` and `___` access
previous output.

The only way I can find output by cell is `_oh`

That returns a dict with your entire output history. so you can go `_oh.keys()`

But the cell I wanted wasn't there and wasn't saved. Huh. Print statements
might not get saved in the history. Makes sense

GOT IT [Jake VDP as always]
"""""""""""""""""""""""""""

In IPython run:
print(Out[1])

and you have access to output now. easy.

07/08/18

I guess I needed to step away for a lil.

hist_list =[]
for i in range(35,49):
    hist_list.append(In[i])
    try:
        hist_list.append(Out[i])
    except KeyError:
        pass

Wrote that and got what I assume was the best I could. Then VolUp-W to pick
the previous line, Esc to go to Vim normal mode, and ('v') to load
the cell in an editor. Whoo that was awesome!

{Also termux now has arrows in the extra keys section of the keyboard so whoo}

.. _write_file:

writing a file
~~~~~~~~~~~~~~


{yes we are still in hist dude shits confusing!}

history isn't good to use directly for creating a file.

In [52]: writen = %history -n 31-33
    ...: %edit writen
    ...:
    ...:
  31: type(n)
  32: type(len(slm))
  33: type((len(slm))/n)
  /data/data/com.termux/files/usr/lib/python3.6/site-packages/IPython/core/magics/code.py:491: UserWarning: The file where `None` was defined cannot be read or found.
  'cannot be read or found.' % data)

The file where None was defined???

In [64]: type(writen)
Out[64]: NoneType

Sunovabitch history prints to the console and doesn't save anything.

file
-----

This is only a cell magic. Idk why but at some point I thought it could be both
a line and cell magic.

[and just as a heads up %%writefile is down at the bottom]
[i changed that because file is literally an alias for writefile they should be
in the same spot]

writefile
~~~~~~~~~~

.. ipython::

    %%writefile -a filename

needs both percentage signs even with automagic since it's a cell magic
the -a option is to append to a file
i actually don't know if it can create a blank file
{you cant!!}
but don't use quotes on the file or else it won't work. idk why not
but i kept getting `FileDoesntExistError` until i got rid of the quotes

%%file as a cell magic means write everything i'm about to do to a file.
so if you got some crazy history filtering in there i'm sure you could go do
something like

%%file
hist -n 5-10
{where -n means print output too}

2018-08-26

Came back to this section. That is not what it means. Let's try.

%%file idk
_i31-33

$ cat idk
# _i31-33

well shit.

so how tf do we save our history as a file?

lemme show you.

edit
-----

edit can take cell #'s as input like hist does, and creates a file to work with like %%file.

It always create temporary files unlike %%file so its REALLY important
to use :saveas /path/youll/remember in nvim!

Outside of that little gotcha it can take functions you definedin your ipython
interactive namespace and you can fuck with them, modify what you want
then exit and execute until you get a final product that deserves being
saved!!

And if you do this over and over youd end up saving like 10 files so its better
it defaults to saving in /tmp/

interesting behavior i just noticed
edit [file_that_doesnt_exist]
this command fails so apparently you HAVE to run it on an existing file.

probably happens because it doesn't take filenames as arguments.

to explain that let's look at the help pages.

### from edit?

This is an example of creating a simple function inside the editor and
then modifying it. First, start up the editor::

  In [1]: edit
  Editing... done. Executing edited code...
  Out[1]: 'def foo():\n    print "foo() was defined in an editing
  session"\n'

We can then call the function foo()::

  In [2]: foo()
  foo() was defined in an editing session

Now we edit foo.  IPython automatically loads the editor with the
(temporary) file where foo() was previously defined::

  In [3]: edit foo
  Editing... done. Executing edited code...

And if we call foo() again we get the modified version::

  In [4]: foo()
  foo() has now been changed!


tldr; input ipython objects as arguments. it also takes the same input for
cells as history does. but wait how does that work?

history call signature
~~~~~~~~~~~~~~~~~~~~~~


By default, all input history from the current session is displayed.
Ranges of history can be indicated using the syntax:

``4``
    Line 4, current session
``4-6``
    Lines 4-6, current session
``243/1-5``
    Lines 1-5, session 243
``~2/7``
    Line 7, session 2 before current
``~8/1-~6/5``
    From the first line of 8 sessions ago, to the fifth line of 6
    sessions ago.

Also note multiple ranges can be specified by separating with spaces.

Okay man I think we finally got this!

fun fact about edit:
~~~~~~~~~~~~~~~~~~~~


if you run edit -x in the jupyter console it doesn't do anything! fun fact.
because it launched a GUI app you don't have bi-directional communication

## run

-t
  print timing information at the end of the run.  IPython will give
  you an estimated CPU time consumption for your script, which under
  Unix uses the resource module to avoid the wraparound problems of
  time.clock().  Under Unix, an estimate of time spent on system tasks
  is also given (for Windows platforms this is reported as 0.0).

If -t is given, an additional ``-N<N>`` option can be given, where <N>
must be an integer indicating how many times you want the script to
run.  The final timing report will include total and per run results.

For example (testing the script uniq_stable.py)::

    In [1]: run -t uniq_stable

    IPython CPU timings (estimated):
      User  :    0.19597 s.
      System:        0.0 s.

    In [2]: run -t -N5 uniq_stable

    IPython CPU timings (estimated):
    Total runs performed: 5
      Times :      Total       Per run
      User  :   0.910862 s,  0.1821724 s.
      System:        0.0 s,        0.0 s.

-d
  run your program under the control of pdb, the Python debugger.
This allows you to execute your program step by step, watch variables,
  etc.  Internally, what IPython does is similar to calling::

      pdb.run('execfile("YOURFILENAME")')

  with a breakpoint set on line 1 of your file.  You can change the line
  number for this automatic breakpoint to be <N> by using the -bN option
  (where N must be an integer). For example::

      %run -d -b40 myscript

  will set the first breakpoint at line 40 in myscript.py.  Note that
  the first breakpoint must be set on a line which actually does
  something (not a comment or docstring) for it to stop execution.

  Or you can specify a breakpoint in a different file::

      %run -d -b myotherfile.py:20 myscript

  When the pdb debugger starts, you will see a (Pdb) prompt.  You must
  first enter 'c' (without quotes) to start execution up to the first
  breakpoint.

  Entering 'help' gives information about the use of the debugger.  You
  can easily see pdb's full documentation with "import pdb;pdb.help()"
  at a prompt.

-p
  run program under the control of the Python profiler module (which
  prints a detailed report of execution times, function calls, etc).

You can pass other options after -p which affect the behavior of the
  profiler itself. See the docs for %prun for details.

  In this mode, the program's variables do NOT propagate back to the
  IPython interactive namespace (because they remain in the namespace
  where the profiler executes them).

  Internally this triggers a call to %prun, see its documentation for
  details on the options available specifically for profiling.

There is one special usage for which the text above doesn't apply:
if the filename ends with .ipy[nb], the file is run as ipython script,
just as if the commands were written on IPython prompt.

-m
  specify module name to load instead of script path. Similar to
  the -m option for the python interpreter. Use this option last if you
  want to combine with other %run options. Unlike the python interpreter
  only source modules are allowed no .pyc or .pyo files.
  For example::

      %run -m example

  will run the example module.

-G
  disable shell-like glob expansion of arguments.


Quick Notes
------------

pycat [filename]
~~~~~~~~~~~~~~~~~~

# works like cat but assumes a python source-code file
# runs it through a color syntax highlighting pager

Bookmark
~~~~~~~~~~

In [13]: bookmark?
Docstring:
Manage IPython's bookmark system.

%bookmark <name>       - set bookmark to current dir
%bookmark <name> <dir> - set bookmark to <dir>
%bookmark -l           - list all bookmarks
%bookmark -d <name>    - remove bookmark
%bookmark -r           - remove all bookmarks

You can later on access a bookmarked folder with::

  %cd -b <name>

or simply '%cd <name>' if there is no directory called <name> AND
there is such a bookmark defined.

Your bookmarks persist through IPython sessions, but they are
associated with each profile.
