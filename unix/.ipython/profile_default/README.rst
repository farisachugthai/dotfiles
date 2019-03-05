README.rst
==========

01-17-19

Syntax Highlighting
-------------------

How would someone access the highlighting groups that are provided through
the IPython API?

`%config TerminalInteractiveShell.highlighting_style` appears to be a
func from :mod:`pygments`, specifically `pygments.style.Style.style()`.

This is implemented in IPython as follows.

.. ipython::

   [ins] In [6]: from IPython import get_ipython

   [ins] In [8]: ip = get_ipython()
   Out[8]: <IPython.terminal.interactiveshell.TerminalInteractiveShell at 0x70273dd6d8>

   [ins] In [9]: print(ip.style.get_style())
   <prompt_toolkit.styles.style._MergedStyle object at 0x70272d74e0>

   [ins] In [12]: ip.highlighting_style
   Out[12]: 'legacy'

   [ins] In [18]: ip.style.get_style().style_rules
   Out[18]:
   [('pygments.text.whitespace', '#bbbbbb'),
    ('pygments.comment', 'italic #408080'),
    ('pygments.comment.preproc', 'noitalic #BC7A00'),
    ('pygments.keyword', 'bold #008000'),
    ('pygments.keyword.pseudo', 'nobold'),
    ('pygments.keyword.type', 'nobold #B00040'),
    ('pygments.operator', '#666666'),
    ('pygments.operator.word', 'bold #AA22FF'),
    ('pygments.name.builtin', '#008000'),
    ('pygments.name.function', '#0000FF'),
    ('pygments.name.class', 'bold #0000FF'),
    ('pygments.name.namespace', 'bold #0000FF'),
    ('pygments.name.exception', 'bold #D2413A'),
    ('pygments.name.variable', '#19177C'),
    ('pygments.name.constant', '#880000'),
    ('pygments.name.label', '#A0A000'),
    ('pygments.name.entity', 'bold #999999'),
    ('pygments.name.attribute', '#7D9029'),
    ('pygments.name.tag', 'bold #008000'),
    ('pygments.name.decorator', '#AA22FF'),
    ('pygments.literal.string', '#BA2121'),
    ('pygments.literal.string.doc', 'italic'),
    ('pygments.literal.string.interpol', 'bold #BB6688'),
    ('pygments.literal.string.escape', 'bold #BB6622'),
    ('pygments.literal.string.regex', '#BB6688'),
    ('pygments.literal.string.symbol', '#19177C'),
    ('pygments.literal.string.other', '#008000'),
    ('pygments.literal.number', '#666666'),
    ('pygments.generic.heading', 'bold #000080'),
    ('pygments.generic.subheading', 'bold #800080'),
    ('pygments.generic.deleted', '#A00000'),
    ('pygments.generic.inserted', '#00A000'),
    ('pygments.generic.error', '#FF0000'),
    ('pygments.generic.emph', 'italic'),
    ('pygments.generic.strong', 'bold'),
    ('pygments.generic.prompt', 'bold #000080'),
    ('pygments.generic.output', '#888'),
    ('pygments.generic.traceback', '#04D'),
    ('pygments.error', 'border:#FF0000'),
    ...
    ...
   ('pygments.name.function', '#2080D0'),
   ('pygments.name.class', 'bold #2080D0'),
   ('pygments.name.namespace', 'bold #2080D0'),
   ('pygments.prompt', '#009900'),
   ('pygments.promptnum', '#ansibrightgreen bold'),
   ('pygments.outprompt', '#990000'),
   ('pygments.outpromptnum', '#ansibrightred bold'),
   ('pygments.comment', '#ffffff')]

   [ins] In [19]:

Takeaway
~~~~~~~~

To view all currently set colors in IPython, view
``ip.style.get_style().style_rules``
