.. _profile-default-readme:

==========
README.rst
==========

Configuring Prompt Toolkit in IPython
=====================================
Here's the original implementation for pt_app.  ``ip.init_**`` gives a ton of
different places, seemingly to muck around.

.. ipython::

   In [28]: ip.init_prompt_toolkit_cli??
   Signature: ip.init_prompt_toolkit_cli()
   Docstring: <no docstring>
   Source:
       def init_prompt_toolkit_cli(self):
           if self.simple_prompt:
               # Fall back to plain non-interactive output for tests.
               # This is very limited.
               def prompt():
                   prompt_text = "".join(x[1] for x in self.prompts.in_prompt_tokens())
                   lines = [input(prompt_text)]
                   prompt_continuation = "".join(x[1] for x in self.prompts.continuation_prompt_tokens())
                   while self.check_complete('\n'.join(lines))[0] == 'incomplete':
                       lines.append( input(prompt_continuation) )
                   return '\n'.join(lines)
               self.prompt_for_code = prompt
               return

           # Set up keyboard shortcuts
           key_bindings = create_ipython_shortcuts(self)

           # Pre-populate history from IPython's history database
           history = InMemoryHistory()
           last_cell = u""
           for __, ___, cell in self.history_manager.get_tail(self.history_load_length,
                                                           include_latest=True):
               # Ignore blank lines and consecutive duplicates
               cell = cell.rstrip()
               if cell and (cell != last_cell):
                   history.append_string(cell)
                   last_cell = cell

           self._style = self._make_style_from_name_or_cls(self.highlighting_style)
           self.style = DynamicStyle(lambda: self._style)

           editing_mode = getattr(EditingMode, self.editing_mode.upper())

           self.pt_app = PromptSession(
                               editing_mode=editing_mode,
                               key_bindings=key_bindings,
                               history=history,
                               completer=IPythonPTCompleter(shell=self),
                               enable_history_search = self.enable_history_search,
                               style=self.style,
                               include_default_pygments_style=False,
                               mouse_support=self.mouse_support,
                               enable_open_in_editor=self.extra_open_editor_shortcuts,
                               color_depth=(ColorDepth.TRUE_COLOR if self.true_color else None),
                               **self._extra_prompt_options())

The prompt toolkit tutorial does a fairly thorough job of explaining how most
everything here works.

Except DynamicStyle. No idea. So I went hunting.


▼+DynamicStyle : class
   +__init__(self, get_style) : member
   +get_attrs_for_style_str(self, style_str, default=DEFAULT_ATTRS) : member
   +invalidation_hash(self) : member
   +style_rules(self) : member

Found  in this dir.

.. code:: vim

   echo fnamemodify(expand('%'), ':p')

Outputted the following. Also just revelling in getting that correct on the first try.

/data/data/com.termux/files/home/virtualenvs/utilities/lib/python3.7/site-packages/prompt_toolkit/styles/base.py



01-17-19

Syntax Highlighting
-------------------
How would someone access the highlighting groups that are provided through
the IPython API?

`%config TerminalInteractiveShell.highlighting_style` appears to be a
func from :mod:`pygments`, specifically :func:`pygments.style.Style.style()`.

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
