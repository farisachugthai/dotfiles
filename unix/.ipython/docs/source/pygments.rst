pygments
==========
Feb 21, 2019:

I just noticed a constant that actually clarifies a good amount about Pygments.
Or gives you a direction to go in at least.

A lot of this document is ``pygmentize -L`` output. Also truncated it heavily.

The last section is the output from ``tldr -m pygmentize``.

Pygments version 2.2.0, (c) 2006-2017 by Georg Brandl.

Pygments and CSS
----------------

.. ipython::

   In [31]: from pygments.style import STANDARD_TYPES

   In [32]: STANDARD_TYPES
   Out[32]:
   {Token: '',
   Token.Text: '',
   Token.Text.Whitespace: 'w',
   Token.Escape: 'esc',
   Token.Error: 'err',
   Token.Other: 'x',
   Token.Keyword: 'k',
   Token.Keyword.Constant: 'kc',
   Token.Keyword.Declaration: 'kd',
   Token.Keyword.Namespace: 'kn',
   Token.Keyword.Pseudo: 'kp',
   Token.Keyword.Reserved: 'kr',
   Token.Keyword.Type: 'kt',
   Token.Name: 'n',
   Token.Name.Attribute: 'na',
   Token.Name.Builtin: 'nb',
   Token.Name.Builtin.Pseudo: 'bp',
   Token.Name.Class: 'nc',
   Token.Name.Constant: 'no',
   Token.Name.Decorator: 'nd',
   Token.Name.Entity: 'ni',
   Token.Name.Exception: 'ne',
 
Now if you go and open up `~/.local/scripts/gruvbox-pygments/gruvbox.css`_
you'll notice that those letter abbreviations are abbreviations for CSS things!

Pygments is directly a mapping of color codes to CSS that applies based on lexers
for different programming languages. Sweet.

Formatters:
-----------

::

   + bbcode, bb:
       Format tokens with BBcodes. These formatting codes are used by many bulletin boards, so you can highlight your sourcecode with pygments before posting it there.
   + bmp, bitmap:
       Create a bitmap image from source code. This uses the Python Imaging Library to generate a pixmap from the source code. (filenames *.bmp)
   + gif:
       Create a GIF image from source code. This uses the Python Imaging Library to generate a pixmap from the source code. (filenames *.gif)
   + html:
       Format tokens as HTML 4 ``<span>`` tags within a ``<pre>`` tag, wrapped in a ``<div>`` tag. The ``<div>``'s CSS class can be set by the `cssclass` option. (filenames *.html, *.htm)
   + img, IMG, png:
       Create a PNG image from source code. This uses the Python Imaging Library to generate a pixmap from the source code. (filenames *.png)
   + irc, IRC:
       Format tokens with IRC color sequences
   + jpg, jpeg:
       Create a JPEG image from source code. This uses the Python Imaging Library to generate a pixmap from the source code. (filenames *.jpg)
   + latex, tex:
       Format tokens as LaTeX code. This needs the `fancyvrb` and `color` standard packages. (filenames *.tex)
   + raw, tokens:
       Format tokens as a raw representation for storing token streams. (filenames *.raw)
   + rtf:
       Format tokens as RTF markup. This formatter automatically outputs full RTF documents with color information and other useful stuff. Perfect for Copy and Paste into Microsoft(R) Word(R) documents. (filenames *.rtf)
   + svg:
       Format tokens as an SVG graphics file.  This formatter is still experimental. Each line of code is a ``<text>`` element with explicit ``x`` and ``y`` coordinates containing ``<tspan>`` elements with the individual token styles. (filenames *.svg)
   + terminal, console:
       Format tokens with ANSI color sequences, for output in a text console. Color sequences are terminated at newlines, so that paging the output works correctly.
   + terminal16m, console16m, 16m:
       Format tokens with ANSI color sequences, for output in a true-color terminal or console.  Like in `TerminalFormatter` color sequences are terminated at newlines, so that paging the output works correctly.
   + terminal256, console256, 256:
       Format tokens with ANSI color sequences, for output in a 256-color terminal or console.  Like in `TerminalFormatter` color sequences are terminated at newlines, so that paging the output works correctly.
   + testcase:
       Format tokens as appropriate for a new testcase.
   + text, null:
       Output the text unchanged without any formatting. (filenames *.txt)

Filters:
--------
* codetagify:
    Highlight special code tags in comments and docstrings.

* keywordcase:
    Convert keywords to lowercase or uppercase or capitalize them,
    which means first letter uppercase, rest lowercase.

* highlight:
    Highlight a normal Name (and Name.*) token with a different
    token type.

* raiseonerror:
    Raise an exception when the lexer generates an error token.

* whitespace:
    Convert tabs, newlines and/or spaces to visible characters.

* gobble:
    Gobbles source code lines (eats initial characters).

* tokenmerge:
    Merges consecutive tokens with the same token type in the output
    stream of a lexer.

Styles:
-------

* default:
    The default style (inspired by Emacs 22).
* emacs:
    The default style (inspired by Emacs 22).
* friendly:
    A modern style based on the VIM pyte theme.
* colorful:
    A colorful style, inspired by CodeRay.
* autumn:
    A colorful style, inspired by the terminal highlighting style.
* murphy:
    Murphy's style from CodeRay.
* manni:
    A colorful style, inspired by the terminal highlighting style.
* monokai:
    This style mimics the Monokai color scheme.
* perldoc:
    Style similar to the style used in the perldoc code blocks.
* pastie:
    Style similar to the pastie default style.
* borland:
    Style similar to the style used in the borland IDEs.
* trac:
    Port of the default trac highlighter design.
* native:
    Pygments version of the "native" vim theme.
* fruity:
    Pygments version of the "native" vim theme.
* bw:

* vim:
    Styles somewhat like vim 7.0
* vs:

* tango:
    The Crunchy default Style inspired from the color palette from the Tango Icon Theme Guidelines.
* rrt:
    Minimalistic "rrt" theme, based on Zap and Emacs defaults.
* xcode:
    Style similar to the Xcode default colouring theme.
* igor:
    Pygments version of the official colors for Igor Pro procedures.
* paraiso-light:

* paraiso-dark:

* lovelace:
    The style used in Lovelace interactive learning environment. Tries to avoid the "angry fruit salad" effect with desaturated and dim colours.
* algol:

* algol_nu:

* arduino:
    The Arduino® language style. This style is designed to highlight the Arduino source code, so exepect the best results with it.
* rainbow_dash:
    A bright and colorful syntax highlighting theme.
* abap:

tldr
----
> Python-based syntax highlighter.

- Highlight file syntax and print to standard output (language is inferred from the file extension):

`pygmentize {{file.py}}`

- Explicitly set the language for syntax highlighting:

`pygmentize -l {{javascript}} {{input_file}}`

- List available lexers (processors for input languages):

`pygmentize -L lexers`

- Save output to a file in HTML format:

`pygmentize -f html -o {{output_file.html}} {{input_file.py}}`

- List available output formats:

`pygmentize -L formatters`

- Output an HTML file, with additional formatter options (full page, with line numbers):

`pygmentize -f html -O "full,linenos=True" -o {{output_file.html}} {{input_file}}`


.. code-block:: python3

        print("The output of `_ip.style.style_rules` is:\n")



.. ipython::

    In [32]: _ip.style.style_rules
    Out[32]:
    [('pygments.comment.preproc', 'noinherit #8ec07c'),
     ('pygments.comment', '#928374 italic'),
     ('pygments.error', '#fb4934'),
     ('pygments.generic.deleted', 'noinherit #282828'),
     ('pygments.generic.emph', '#83a598 underline'),
     ('pygments.generic.heading', '#b8bb26 bold'),
     ('pygments.generic.inserted', 'noinherit #282828'),
     ('pygments.generic.output', 'noinherit #504945'),
     ('pygments.generic.prompt', '#83a598'),
     ('pygments.generic.strong', '#ebdbb2'),
     ('pygments.generic.subheading', '#b8bb26 bold'),
     ('pygments.generic', '#ebdbb2'),
     ('pygments.keyword.type', 'noinherit #fabd2f'),
     ('pygments.keyword', 'noinherit #fe8019'),
     ('pygments.keyword.constant', '#fe8019'),
     ('pygments.keyword.declaration', '#fe8019'),
     ('pygments.name.attribute', '#b8bb26 bold'),
     ('pygments.name.builtin', '#fabd2f'),
     ('pygments.name.constant', 'noinherit #d3869b'),
     ('pygments.name.entity', 'noinherit #fabd2f'),
     ('pygments.name.exception', 'noinherit #fb4934'),
     ('pygments.name.function', '#fabd2f'),
     ('pygments.name.label', 'noinherit #fb4934'),
     ('pygments.name.tag', 'noinherit #fb4934'),
     ('pygments.name.variable', 'noinherit #ebdbb2'),
     ('pygments.name', '#ebdbb2'),
     ('pygments.literal.number.float', 'noinherit #d3869b'),
     ('pygments.literal.number', 'noinherit #d3869b'),
     ('pygments.operator', '#fe8019'),
     ('pygments.punctuation', '#ebdbb2'),
     ('pygments.literal.string.symbol', '#83a598'),
     ('pygments.literal.string', 'noinherit #b8bb26'),
     ('pygments', 'noinherit #ebdbb2'),
     ('pygments.text.whitespace', 'underline #f8f8f8'),
     ('pygments.text', ''),
     ('pygments.escape', ''),
     ('pygments.other', ''),
     ('pygments.keyword.namespace', ''),
     ('pygments.keyword.pseudo', ''),
     ('pygments.keyword.reserved', ''),
     ('pygments.name.builtin.pseudo', ''),
     ('pygments.name.class', ''),
     ('pygments.name.decorator', ''),
     ('pygments.name.function.magic', ''),
     ('pygments.name.property', ''),
     ('pygments.name.namespace', ''),
     ('pygments.name.other', ''),
     ('pygments.name.variable.class', ''),
     ('pygments.name.variable.global', ''),
     ('pygments.name.variable.instance', ''),
     ('pygments.name.variable.magic', ''),
     ('pygments.literal', ''),
     ('pygments.literal.date', ''),
     ('pygments.literal.string.affix', ''),
     ('pygments.literal.string.backtick', ''),
     ('pygments.literal.string.char', ''),
     ('pygments.literal.string.delimiter', ''),
     ('pygments.literal.string.doc', ''),
     ('pygments.literal.string.double', ''),
     ('pygments.literal.string.escape', ''),
     ('pygments.literal.string.heredoc', ''),
     ('pygments.literal.string.interpol', ''),
     ('pygments.literal.string.other', ''),
     ('pygments.literal.string.regex', ''),
     ('pygments.literal.string.single', ''),
     ('pygments.literal.number.bin', ''),
     ('pygments.literal.number.hex', ''),
     ('pygments.literal.number.integer', ''),
     ('pygments.literal.number.integer.long', ''),
     ('pygments.literal.number.oct', ''),
     ('pygments.operator.word', ''),
     ('pygments.comment.hashbang', ''),
     ('pygments.comment.multiline', ''),
     ('pygments.comment.preprocfile', ''),
     ('pygments.comment.single', ''),
     ('pygments.comment.special', ''),
     ('pygments.generic.error', ''),
     ('pygments.generic.traceback', ''),
     ('pygments.prompt', '#009900'),
     ('pygments.promptnum', '#ansibrightgreen bold'),
     ('pygments.outprompt', '#990000'),
     ('pygments.outpromptnum', '#ansibrightred bold'),
     ('pygments.comment', '#ffffff')]


