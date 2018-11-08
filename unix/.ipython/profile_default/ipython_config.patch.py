diff --git a/unix/.ipython/profile_default/ipython_config.py b/unix/.ipython/profile_default/ipython_config.py
old mode 100755
new mode 100644
index 59edd63..d7ebc8d
--- a/unix/.ipython/profile_default/ipython_config.py
+++ b/unix/.ipython/profile_default/ipython_config.py
@@ -1,15 +1,15 @@
 #!/usr/bin/env python
 # -*- coding: utf-8 -*-
-"""Configuration file for ipython.
-
+""" Configuration file for ipython.
 Heavily drawn from documentation at
-.. URL::
+
 `<https://ipython.readthedocs.io/en/stable/config/intro.html#python-config-files>`
 
 and source code found on GitHub.
 """
-import os
 
+# actually if the import file i use works then we shouldn't need this right?
+# actually don't count on the order of execution being correct
 from pygments.token import Comment
 
 # c is a traitlets.config.Configurable object
@@ -18,13 +18,11 @@ from pygments.token import Comment
 # ipython on simple things like creating a new prompt after every command
 # increments it
 
-c = get_config()  # noqa
+c = get_config()            # noqa,pyls:
 
 # Alias: {{{
-
 c.AliasManager.user_aliases = [
-      ('ag', 'ag --hidden --color'),
-      ('chmod', 'chmod'),
+      ('ag', 'ag'),
       ('cp', 'cp -iv'),       # cp mv mkdir and rmdir are all overridden
       ('echo', 'echo -e'),
       ('fzf', 'fzf'),         # all we need to do is figure out keybindings
@@ -33,7 +31,6 @@ c.AliasManager.user_aliases = [
       ('gco', 'git commit'),
       ('gd', 'git diff'),
       ('gds', 'git diff --staged'),
-      ('gds2', 'git diff --staged --stat'),
       ('glo', 'git log'),
       ('gs', 'git status'),
       ('gst', 'git diff --stat'),
@@ -43,14 +40,13 @@ c.AliasManager.user_aliases = [
       ('ll', 'ls -AlF --color=always'),
       ('ls', 'ls -F --color=always'),
       ('lt', 'ls -Altcr --color=always'),
+      ('mk', 'mkdir -pv %l && cd %l'),      # check if this works. only mkdir
       ('mkdir', 'mkdir -pv'),
       ('mv', 'mv -iv'),
       ('nvim', 'nvim'),
       ('rm', 'rm -v'),
-      ('rmdir', 'rmdir -v'),
+      ('rmdir', 'rmdir -pv'),
       ('tail', 'tail -n 30'),
-      ('tree', 'tree'),
-      ('treea', 'tree -aI .git'),
       ('vi', 'vim'),
       ('vim', 'vim'),
   ]
@@ -159,11 +155,14 @@ c.InteractiveShellApp.reraise_ipython_extension_failures = True
 
 # IPython: an enhanced interactive Python shell.
 
+# Whether to create profile dir if it doesn't exist
+# c.BaseIPythonApplication.auto_create = False
+
 # Whether to install the default config files into the profile dir. If a new
 #  profile is being created, and IPython contains config files for that profile
 #  then they will be staged into the new directory.  Otherwise, default config
 #  files will be automatically generated.
-c.BaseIPythonApplication.copy_config_files = True
+# c.BaseIPythonApplication.copy_config_files = False
 
 # Path to an extra config file to load.
 #
@@ -174,11 +173,8 @@ c.BaseIPythonApplication.copy_config_files = True
 # configuration (through profiles), history storage, etc. The default is
 # $HOME/.ipython. This option can also be specified through the environment
 # variable IPYTHONDIR.
-if os.environ.get("$IPYTHONDIR"):
-    c.BaseIPythonApplication.ipython_dir = os.environ.get("$IPYTHONDIR")
-else:
-    # c.BaseIPythonApplication.ipython_dir = "~/.ipython"
-    pass
+# c.BaseIPythonApplication.ipython_dir = ''
+
 # Whether to overwrite existing config files when copying
 # c.BaseIPythonApplication.overwrite = False
 
@@ -187,7 +183,7 @@ c.BaseIPythonApplication.profile = 'default'
 
 # Create a massive crash report when IPython encounters what may be an internal
 #  error.  The default is to append a short message to the usual traceback
-# c.BaseIPythonApplication.verbose_crash = False
+c.BaseIPythonApplication.verbose_crash = False
 
 # ----------------------------------------------------------------------------
 # TerminalIPythonApp(BaseIPythonApplication,InteractiveShellApp) configuration
@@ -234,11 +230,7 @@ except Exception:
 # c.InteractiveShell.autocall = 0
 
 # Autoindent IPython code entered interactively.
-# Jupyter Console doesn't handle this correctly. Alledgedly ipy7.0 fixed that
-try:
-    c.InteractiveShell.autoindent = True
-except Exception:
-    pass
+c.InteractiveShell.autoindent = True
 
 # Enable magic commands to be called without the leading %.
 c.InteractiveShell.automagic = True
@@ -286,9 +278,8 @@ c.InteractiveShell.colors = 'Neutral'
 # c.InteractiveShell.disable_failing_post_execute = False
 
 # If True, anything that would be passed to the pager will be displayed as
-# regular output instead.
-# Manpager is set to nvim and it handles it SO much better than vim did.
-c.InteractiveShell.display_page = False
+#  regular output instead.
+c.InteractiveShell.display_page = True
 
 # (Provisional API) enables html representation in mime bundles sent to pagers.
 # c.InteractiveShell.enable_html_pager = False
@@ -334,16 +325,10 @@ c.InteractiveShell.quiet = False
 
 # Enables rich html representation of docstrings. (This requires the docrepr
 #  module).
-import importlib  # noqa E402
-try:
-    importlib.import_module("docrepr")  # noqa E402
-except ImportError:
-    c.InteractiveShell.sphinxify_docstring = False
-else:
-    # currently doesn't work
-    # c.InteractiveShell.sphinxify_docstring = True
-    pass
+# TODO: Do some kind of check to see whether we have docrepr in the env first
+# c.InteractiveShell.sphinxify_docstring = True
 
+#
 c.InteractiveShell.wildcards_case_sensitive = False
 
 # Switch modes for the IPython exception handlers.
@@ -356,12 +341,12 @@ c.InteractiveShell.wildcards_case_sensitive = False
 # Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
 #  Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
 #  direct exit without any confirmation.
-c.TerminalInteractiveShell.confirm_exit = False
+c.TerminalInteractiveShell.confirm_exit = True
 
 # Options for displaying tab completions, 'column', 'multicolumn', and
 #  'readlinelike'. These options are for `prompt_toolkit`, see `prompt_toolkit`
 #  documentation for more information.
-c.TerminalInteractiveShell.display_completions = 'multicolumn'
+c.TerminalInteractiveShell.display_completions = 'column'
 
 # Shortcut style to use at the prompt. 'vi' or 'emacs'.
 c.TerminalInteractiveShell.editing_mode = 'vi'
@@ -399,7 +384,7 @@ c.TerminalInteractiveShell.highlighting_style = 'legacy'
 c.TerminalInteractiveShell.highlighting_style_overrides = {Comment: '#ffffff'}
 
 # Enable mouse support in the prompt (Note: prevents selecting text with the
-# mouse)
+#  mouse)
 # c.TerminalInteractiveShell.mouse_support = False
 
 # Class used to generate Prompt token for prompt_toolkit
@@ -407,12 +392,12 @@ c.TerminalInteractiveShell.highlighting_style_overrides = {Comment: '#ffffff'}
 
 # Use `raw_input` for the REPL, without completion and prompt colors.
 #
-# Useful when controlling IPython as a subprocess, and piping STDIN/OUT/ERR.
-# Known usage are: IPython own testing machinery, and emacs inferior-shell
-# integration through elpy.
+#  Useful when controlling IPython as a subprocess, and piping STDIN/OUT/ERR.
+#  Known usage are: IPython own testing machinery, and emacs inferior-shell
+#  integration through elpy.
 #
-# This mode default to `True` if the `IPY_TEST_SIMPLE_PROMPT` environment
-# variable is set, or the current terminal is not a tty.
+#  This mode default to `True` if the `IPY_TEST_SIMPLE_PROMPT` environment
+#  variable is set, or the current terminal is not a tty.
 # c.TerminalInteractiveShell.simple_prompt = False
 
 # Number of line at the bottom of the screen to reserve for the completion menu
@@ -422,12 +407,12 @@ c.TerminalInteractiveShell.space_for_menu = 6
 c.TerminalInteractiveShell.term_title = True
 
 # Customize the terminal title format.  This is a python format string.
-# Available substitutions are: {cwd}.
+#  Available substitutions are: {cwd}.
 c.TerminalInteractiveShell.term_title_format = 'IPython: {cwd}'
 
 # Use 24bit colors instead of 256 colors in prompt highlighting. If your
-# terminal supports true color, the following command should print 'TRUECOLOR'
-# in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
+#  terminal supports true color, the following command should print 'TRUECOLOR'
+#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
 c.TerminalInteractiveShell.true_color = True
 
 # ----------------------------------------------------------------------------
@@ -435,9 +420,9 @@ c.TerminalInteractiveShell.true_color = True
 # ----------------------------------------------------------------------------
 
 # Access the history database without adding to it.
-
-# This is intended for use by standalone history tools. IPython shells use
-# HistoryManager, below, which is a subclass of this.
+#
+#  This is intended for use by standalone history tools. IPython shells use
+#  HistoryManager, below, which is a subclass of this.
 
 # *******
 # What this implies is that if you want to create your own tool for analyzing
@@ -445,20 +430,20 @@ c.TerminalInteractiveShell.true_color = True
 # *******
 
 # Options for configuring the SQLite connection
-
+#
 # These options are passed as keyword args to sqlite3.connect when establishing
 # database conenctions.
 # c.HistoryAccessor.connection_options = {}
 
 # enable the SQLite history
-
+#
 # set enabled=False to disable the SQLite history, in which case there will be
 # no stored history, no SQLite connection, and no background saving thread.
 # This may be necessary in some threaded environments where IPython is embedded
 # c.HistoryAccessor.enabled = True
 
 # Path to file to use for SQLite history database.
-
+#
 # By default, IPython will put the history database in the IPython profile
 # directory.  If you would rather share one history among profiles, you can set
 # this value in each, so that they are consistent.
@@ -660,8 +645,7 @@ c.Completer.use_jedi = True
 # c.ScriptMagics.script_magics = []
 
 # Dict mapping short 'ruby' names to full paths, such as '/opt/secret/bin/ruby'
-# AKA the gcloud libs and other 3rd party bins
-
+#
 # Only necessary for items in script_magics where the default path will not
 # find the right interpreter.
 # c.ScriptMagics.script_paths = {}
@@ -681,8 +665,8 @@ c.LoggingMagics.quiet = False
 
 # Lightweight persistence for python variables.
 #
-# Provides the %store magic.
+#  Provides the %store magic.
 
 # If True, any %store-d variables will be automatically restored when IPython
-# starts.
+#  starts.
 # c.StoreMagics.autorestore = False
