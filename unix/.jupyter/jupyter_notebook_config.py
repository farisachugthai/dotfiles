#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Configuration file for jupyter-notebook.

================
Jupyter Notebook
================

"""
from traitlets.config import get_config

j = get_config()

# -----------------------------------------------------------------------------
# Application(SingletonConfigurable) configuration
# -----------------------------------------------------------------------------

# This is an application.

# The date format used by logging formatters for %(asctime)s
# j.Application.log_datefmt = '%Y-%m-%d %H:%M:%S'

# The Logging format template
# j.Application.log_format = '[%(name)s]%(highlevel)s %(message)s'

# Set the log level by value or name.
# j.Application.log_level = 30

# -----------------------------------------------------------------------------
# JupyterApp(Application) configuration
# -----------------------------------------------------------------------------

# Base class for Jupyter applications

# Answer yes to any prompts.
# j.JupyterApp.answer_yes = False

# Full path of a config file.
# j.JupyterApp.config_file = ''

# Specify a config file to load.
# j.JupyterApp.config_file_name = ''

# Generate default config file.
# j.JupyterApp.generate_config = False

# -----------------------------------------------------------------------------
# NotebookApp(JupyterApp) configuration
# -----------------------------------------------------------------------------

# Set the Access-Control-Allow-Credentials: true header
# j.NotebookApp.allow_credentials = False

# Set the Access-Control-Allow-Origin header

# Use '*' to allow any origin to access your server.

# Takes precedence over allow_origin_pat.
# j.NotebookApp.allow_origin = ''

# Use a regular expression for the Access-Control-Allow-Origin header

# Requests from an origin matching the expression will get replies with:

#     Access-Control-Allow-Origin: origin

# where `origin` is the origin of the request.

# Ignored if allow_origin is set.
# j.NotebookApp.allow_origin_pat = ''

# Allow password to be changed at login for the notebook server.

# While loggin in with a token, the notebook server UI will give the opportunity
# to the user to enter a new password at the same time that will replace the
# token login mechanism.

# This can be set to false to prevent changing password from the UI/API.
# j.NotebookApp.allow_password_change = True

# Allow requests where the Host header doesn't point to a local server

# By default, requests get a 403 forbidden response if the 'Host' header shows
# that the browser thinks it's on a non-local domain. Setting this option to
# True disables this check.

# This protects against 'DNS rebinding' attacks, where a remote web server
# serves you a page and then changes its DNS to send later requests to a local
# IP, bypassing same-origin checks.

# Local IP addresses (such as 127.0.0.1 and ::1) are allowed as local, along
# with hostnames configured in local_hostnames.
# j.NotebookApp.allow_remote_access = False

# Whether to allow the user to run the notebook as root.
# j.NotebookApp.allow_root = False

# DEPRECATED use base_url
# j.NotebookApp.base_project_url = '/'

# The base URL for the notebook server.

# Leading and trailing slashes can be omitted, and will automatically be added.
# j.NotebookApp.base_url = '/'

# Specify what command to use to invoke a web browser when opening the notebook.
# If not specified, the default browser will be determined by the `webbrowser`
# standard library module, which allows setting of the BROWSER environment
# variable to override it.
# j.NotebookApp.browser = ''

# The full path to an SSL/TLS certificate file.
# j.NotebookApp.certfile = ''

# The full path to a certificate authority certificate for SSL/TLS client
# authentication.
# j.NotebookApp.client_ca = ''

# The config manager class to use
# j.NotebookApp.config_manager_class = 'notebook.services.config.manager.ConfigManager'

# The notebook manager class to use.
# j.NotebookApp.contents_manager_class = 'notebook.services.contents.largefilemanager.LargeFileManager'

# Extra keyword arguments to pass to `set_secure_cookie`. See tornado's
# set_secure_cookie docs for details.
# j.NotebookApp.cookie_options = {}

# The random bytes used to secure cookies. By default this is a new random
# number every time you start the Notebook. Set it to a value in a config file
# to enable logins to persist across server sessions.

# Note: Cookie secrets should be kept private, do not share config files with
# cookie_secret stored in plaintext (you can read the value from a file).
# j.NotebookApp.cookie_secret = b''

# The file where the cookie secret is stored.
# j.NotebookApp.cookie_secret_file = ''

# Override URL shown to users.

# Replace actual URL, including protocol, address, port and base URL, with the
# given value when displaying URL to the users. Do not change the actual
# connection URL. If authentication token is enabled, the token is added to the
# custom URL automatically.

# This option is intended to be used when the URL to display to the user cannot
# be determined reliably by the Jupyter notebook server (proxified or
# containerized setups for example).
# j.NotebookApp.custom_display_url = ''

# The default URL to redirect to from `/`
# j.NotebookApp.default_url = '/tree'

# Disable cross-site-request-forgery protection

# Jupyter notebook 4.3.1 introduces protection from cross-site request
# forgeries, requiring API requests to either:

# - originate from pages served by this server (validated with XSRF cookie and
# token), or - authenticate with a token

# Some anonymous compute resources still desire the ability to run code,
# completely without authentication. These services can disable all
# authentication and security checks, with the full knowledge of what that
# implies.
# j.NotebookApp.disable_check_xsrf = False

# Whether to enable MathJax for typesetting math/TeX

# MathJax is the javascript library Jupyter uses to render math/LaTeX. It is
# very large, so you may want to disable it if you have a slow internet
# connection, or for offline use of the notebook.

# When disabled, equations etj. will appear as their untransformed TeX source.
# j.NotebookApp.enable_mathjax = True

# extra paths to look for Javascript notebook extensions
# j.NotebookApp.extra_nbextensions_path = []

# handlers that should be loaded at higher priority than the default services
# j.NotebookApp.extra_services = []

# Extra paths to search for serving static files.

# This allows adding javascript/css to be available from the notebook server
# machine, or overriding individual files in the IPython
# j.NotebookApp.extra_static_paths = []

# Extra paths to search for serving jinja templates.

# Can be used to override templates from notebook.templates.
# j.NotebookApp.extra_template_paths = []


# j.NotebookApp.file_to_run = ''

# Extra keyword arguments to pass to `get_secure_cookie`. See tornado's
# get_secure_cookie docs for details.
# j.NotebookApp.get_secure_cookie_kwargs = {}

# Deprecated: Use minified JS file or not, mainly use during dev to avoid JS
# recompilation
# j.NotebookApp.ignore_minified_js = False

# (bytes/sec) Maximum rate at which stream output can be sent on iopub before
# they are limited.
# j.NotebookApp.iopub_data_rate_limit = 1000000

# (msgs/sec) Maximum rate at which messages can be sent on iopub before they are
# limited.
# j.NotebookApp.iopub_msg_rate_limit = 1000

# The IP address the notebook server will listen on.
# j.NotebookApp.ip = 'localhost'

# Supply extra arguments that will be passed to Jinja environment.
# j.NotebookApp.jinja_environment_options = {}

# Extra variables to supply to jinja templates when rendering.
# j.NotebookApp.jinja_template_vars = {}

# The kernel manager class to use.
# j.NotebookApp.kernel_manager_class = 'notebook.services.kernels.kernelmanager.MappingKernelManager'

# The kernel spec manager class to use. Should be a subclass of
# `jupyter_client.kernelspej.KernelSpecManager`.

# The Api of KernelSpecManager is provisional and might change without warning
# between this version of Jupyter and the next stable one.
# j.NotebookApp.kernel_spec_manager_class = 'jupyter_client.kernelspec.KernelSpecManager'

# The full path to a private key file for usage with SSL/TLS.
# j.NotebookApp.keyfile = ''

# Hostnames to allow as local when allow_remote_access is False.

# Local IP addresses (such as 127.0.0.1 and ::1) are automatically accepted as
# local as well.
# j.NotebookApp.local_hostnames = ['localhost']

# The login handler class to use.
# j.NotebookApp.login_handler_class = 'notebook.auth.login.LoginHandler'

# The logout handler class to use.
# j.NotebookApp.logout_handler_class = 'notebook.auth.logout.LogoutHandler'

# The MathJax.js configuration file that is to be used.
# j.NotebookApp.mathjax_config = 'TeX-AMS-MML_HTMLorMML-full,Safe'

# A custom url for MathJax.js. Should be in the form of a case-sensitive url to
# MathJax, for example:  /static/components/MathJax/MathJax.js
# j.NotebookApp.mathjax_url = ''

# Sets the maximum allowed size of the client request body, specified in  the
# Content-Length request header field. If the size in a request  exceeds the
# configured value, a malformed HTTP message is returned to the client.

# Note: max_body_size is applied even in streaming mode.
# j.NotebookApp.max_body_size = 536870912

# Gets or sets the maximum amount of memory, in bytes, that is allocated  for
# use by the buffer manager.
# j.NotebookApp.max_buffer_size = 536870912

# Dict of Python modules to load as notebook server extensions.Entry values can
# be used to enable and disable the loading ofthe extensions. The extensions
# will be loaded in alphabetical order.
# j.NotebookApp.nbserver_extensions = {}

# The directory to use for notebooks and kernels.
# j.NotebookApp.notebook_dir = ''

# Whether to open in a browser after starting. The specific browser used is
# platform dependent and determined by the python standard library `webbrowser`
# module, unless it is overridden using the --browser (NotebookApp.browser)
# configuration option.
# j.NotebookApp.open_browser = True

# Hashed password to use for web authentication.

# To generate, type in a python/IPython shell:

#   from notebook.auth import passwd; passwd()

# The string should be of the form type:salt:hashed-password.
# j.NotebookApp.password = ''

# Forces users to use a password for the Notebook server. This is useful in a
# multi user environment, for instance when everybody in the LAN can access each
# other's machine through ssh.

# In such a case, server the notebook server on localhost is not secure since
# any user can connect to the notebook server via ssh.
# j.NotebookApp.password_required = False

# The port the notebook server will listen on.
# j.NotebookApp.port = 8888

# The number of additional ports to try if the specified port is not available.
# j.NotebookApp.port_retries = 50

# DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.
# j.NotebookApp.pylab = 'disabled'

# If True, display a button in the dashboard to quit (shutdown the notebook
# server).
# j.NotebookApp.quit_button = True

# (sec) Time window used to  check the message and data rate limits.
# j.NotebookApp.rate_limit_window = 3

# Reraise exceptions encountered loading server extensions?
j.NotebookApp.reraise_server_extension_failures = True

# The directory for user settings.
# c.LabApp.user_settings_dir = '/data/data/com.termux/files/home/.jupyter/lab/user-settings'

###############
#  fswatcher  #
###############

# Whether to serve the app in watch mode
# c.LabApp.watch = False

## The directory for workspaces
#c.LabApp.workspaces_dir = '/data/data/com.termux/files/home/.jupyter/lab/workspaces'

# Supply SSL options for the tornado HTTPServer. See the tornado docs for
# details.
# j.NotebookApp.ssl_options = {}

# Supply overrides for terminado. Currently only supports "shell_command".
# j.NotebookApp.terminado_settings = {}

# Set to False to disable terminals.

# This does *not* make the notebook server more secure by itself. Anything the
# user can in a terminal, they can also do in a notebook.

# Terminals may also be automatically disabled if the terminado package is not
# available.
# j.NotebookApp.terminals_enabled = True

# Token used for authenticating first-time connections to the server.

# When no password is enabled, the default is to generate a new, random token.

# Setting to an empty string disables authentication altogether, which is NOT
# RECOMMENDED.
# j.NotebookApp.token = '<generated>'

# Supply overrides for the tornado.web.Application that the Jupyter notebook
# uses.
# j.NotebookApp.tornado_settings = {}

# Whether to trust or not X-Scheme/X-Forwarded-Proto and X-Real-Ip/X-Forwarded-
# For headerssent by the upstream reverse proxy. Necessary if the proxy handles
# SSL
# j.NotebookApp.trust_xheaders = False

# DEPRECATED, use tornado_settings
# j.NotebookApp.webapp_settings = {}

# Specify Where to open the notebook on startup. This is the `new` argument
# passed to the standard library method `webbrowser.open`. The behaviour is not
# guaranteed, but depends on browser support. Valid values are:

#  - 2 opens a new tab,
#  - 1 opens a new window,
#  - 0 opens in an existing window.

# See the `webbrowser.open` documentation for details.
j.NotebookApp.webbrowser_open_new = 1

# Set the tornado compression options for websocket connections.

# This value will be returned from
# :meth:`WebSocketHandler.get_compression_options`. None (default) will disable
# compression. A dict (even an empty one) will enable compression.

# See the tornado docs for WebSocketHandler.get_compression_options for details.
# j.NotebookApp.websocket_compression_options = None

# The base URL for websockets, if it differs from the HTTP server (hint: it
# almost certainly doesn't).

# Should be in the form of an HTTP origin: ws[s]://hostname[:port]
# j.NotebookApp.websocket_url = ''

# -----------------------------------------------------------------------------
# NteractApp(NotebookApp) configuration
# -----------------------------------------------------------------------------

# Application for runing nteract on a jupyter notebook server.

# Whether to start the app in dev mode. Expects resources to be loaded from
# webpack's hot reloading server at http://localhost:8357/. Run `yarn workspace
# nteract-on-jupyter run hot --port 8357` To serve your assets. This is only
# useful if NteractApp is installed editably e.g., using `pip install -e .`.
# j.NteractApp.dev_mode = False

# -----------------------------------------------------------------------------
# ConnectionFileMixin(LoggingConfigurable) configuration
# -----------------------------------------------------------------------------

# Mixin for configurable classes that work with connection files

# JSON file in which to store connection info [default: kernel-<pid>.json]

# This file will contain the IP, ports, and authentication key needed to connect
# clients to this kernel. By default, this file will be created in the security
# dir of the current profile, but can be specified by absolute path.
# j.ConnectionFileMixin.connection_file = ''

## JSON file in which to store connection info [default: kernel-<pid>.json]
#
#  This file will contain the IP, ports, and authentication key needed to connect
#  clients to this kernel. By default, this file will be created in the security
#  dir of the current profile, but can be specified by absolute path.
#c.ConnectionFileMixin.connection_file = ''

# set the heartbeat port [default: random]
# j.ConnectionFileMixin.hb_port = 0

# set the iopub (PUB) port [default: random]
# j.ConnectionFileMixin.iopub_port = 0

# Set the kernel's IP address [default localhost]. If the IP address is
# something other than localhost, then Consoles on other machines will be able
# to connect to the Kernel, so be careful!
# j.ConnectionFileMixin.ip = ''

# set the shell (ROUTER) port [default: random]
# j.ConnectionFileMixin.shell_port = 0

# set the stdin (ROUTER) port [default: random]
# j.ConnectionFileMixin.stdin_port = 0


# j.ConnectionFileMixin.transport = 'tcp'

# -----------------------------------------------------------------------------
# KernelManager(ConnectionFileMixin) configuration
# -----------------------------------------------------------------------------

# Manages a single kernel in a subprocess on this host.

## Should we autorestart the kernel if it dies.
#c.KernelManager.autorestart = True

## DEPRECATED: Use kernel_name instead.
#
#  The Popen Command to launch the kernel. Override this if you have a custom
#  kernel. If kernel_cmd is specified in a configuration file, Jupyter does not
#  pass any arguments to the kernel, because it cannot make any assumptions about
#  the arguments that the kernel understands. In particular, this means that the
#  kernel does not receive the option --debug if it given on the Jupyter command
#  line.
#c.KernelManager.kernel_cmd = []

## Time to wait for a kernel to terminate before killing it, in seconds.
#c.KernelManager.shutdown_wait_time = 5.0

# The Popen Command to launch the kernel. Override this if you have a custom
# kernel. If kernel_cmd is specified in a configuration file, Jupyter does not
# pass any arguments to the kernel, because it cannot make any assumptions about
# the arguments that the kernel understands. In particular, this means that the
# kernel does not receive the option --debug if it given on the Jupyter command
# line.
# j.KernelManager.kernel_cmd = []

# Time to wait for a kernel to terminate before killing it, in seconds.
# j.KernelManager.shutdown_wait_time = 5.0

# -----------------------------------------------------------------------------
# Session(Configurable) configuration
# -----------------------------------------------------------------------------

## Object for handling serialization and sending of messages.
#
#  The Session object handles building messages and sending them with ZMQ sockets
#  or ZMQStream objects.  Objects can communicate with each other over the
#  network via Session objects, and only need to work with the dict-based IPython
#  message spec. The Session will handle serialization/deserialization, security,
#  and metadata.
#
#  Sessions support configurable serialization via packer/unpacker traits, and
#  signing with HMAC digests via the key/keyfile traits.
#
#  Parameters ----------
#
#  debug : bool
#      whether to trigger extra debugging statements
#  packer/unpacker : str : 'json', 'pickle' or import_string
#      importstrings for methods to serialize message parts.  If just
#      'json' or 'pickle', predefined JSON and pickle packers will be used.
#      Otherwise, the entire importstring must be used.
#
#      The functions must accept at least valid JSON input, and output *bytes*.
#
#      For example, to use msgpack:
#      packer = 'msgpack.packb', unpacker='msgpack.unpackb'
#  pack/unpack : callables
#      You can also set the pack/unpack callables for serialization directly.
#  session : bytes
#      the ID of this Session object.  The default is to generate a new UUID.
#  username : unicode
#      username added to message headers.  The default is to ask the OS.
#  key : bytes
#      The key used to initialize an HMAC signature.  If unset, messages
#      will not be signed or checked.
#  keyfile : filepath
#      The file containing a key.  If this is set, `key` will be initialized
#      to the contents of the file.

## Threshold (in bytes) beyond which an object's buffer should be extracted to
#  avoid pickling.
#c.Session.buffer_threshold = 1024

## Whether to check PID to protect against calls after fork.
#
#  This check can be disabled if fork-safety is handled elsewhere.
#c.Session.check_pid = True

## Threshold (in bytes) beyond which a buffer should be sent without copying.
#c.Session.copy_threshold = 65536

## Debug output in the Session
#c.Session.debug = False

## The maximum number of digests to remember.
#
#  The digest history will be culled when it exceeds this value.
#c.Session.digest_history_size = 65536

## The maximum number of items for a container to be introspected for custom
#  serialization. Containers larger than this are pickled outright.
#c.Session.item_threshold = 64

## execution key, for signing messages.
#c.Session.key = b''

## path to file containing execution key.
#c.Session.keyfile = ''

## Metadata dictionary, which serves as the default top-level metadata dict for
#  each message.
#c.Session.metadata = {}

## The name of the packer for serializing messages. Should be one of 'json',
#  'pickle', or an import name for a custom callable serializer.
#c.Session.packer = 'json'

## The UUID identifying this session.
#c.Session.session = ''

## The digest scheme used to construct the message signatures. Must have the form
#  'hmac-HASH'.
#c.Session.signature_scheme = 'hmac-sha256'

## The name of the unpacker for unserializing messages. Only used with custom
#  functions for `packer`.
#c.Session.unpacker = 'json'

# The Session object handles building messages and sending them with ZMQ sockets
# or ZMQStream objects.  Objects can communicate with each other over the
# network via Session objects, and only need to work with the dict-based IPython
# message spej. The Session will handle serialization/deserialization, security,
# and metadata.

# Sessions support configurable serialization via packer/unpacker traits, and
# signing with HMAC digests via the key/keyfile traits.

# Parameters ----------

# debug : bool
#     whether to trigger extra debugging statements
# packer/unpacker : str : 'json', 'pickle' or import_string
#     importstrings for methods to serialize message parts.  If just
#     'json' or 'pickle', predefined JSON and pickle packers will be used.
#     Otherwise, the entire importstring must be used.

#     The functions must accept at least valid JSON input, and output *bytes*.

#     For example, to use msgpack:
#     packer = 'msgpack.packb', unpacker='msgpack.unpackb'
# pack/unpack : callables
#     You can also set the pack/unpack callables for serialization directly.
# session : bytes
#     the ID of this Session object.  The default is to generate a new UUID.
# username : unicode
#     username added to message headers.  The default is to ask the OS.
# key : bytes
#     The key used to initialize an HMAC signature.  If unset, messages
#     will not be signed or checked.
# keyfile : filepath
#     The file containing a key.  If this is set, `key` will be initialized
#     to the contents of the file.

# Threshold (in bytes) beyond which an object's buffer should be extracted to
# avoid pickling.
# j.Session.buffer_threshold = 1024

# Whether to check PID to protect against calls after fork.

# This check can be disabled if fork-safety is handled elsewhere.
# j.Session.check_pid = True

# Threshold (in bytes) beyond which a buffer should be sent without copying.
# j.Session.copy_threshold = 65536

# Debug output in the Session
# j.Session.debug = False

# The maximum number of digests to remember.

# The digest history will be culled when it exceeds this value.
# j.Session.digest_history_size = 65536

# The maximum number of items for a container to be introspected for custom
# serialization. Containers larger than this are pickled outright.
# j.Session.item_threshold = 64

# execution key, for signing messages.
# j.Session.key = b''

# path to file containing execution key.
# j.Session.keyfile = ''

# Metadata dictionary, which serves as the default top-level metadata dict for
# each message.
# j.Session.metadata = {}

# The name of the packer for serializing messages. Should be one of 'json',
# 'pickle', or an import name for a custom callable serializer.
# j.Session.packer = 'json'

# The UUID identifying this session.
# j.Session.session = ''

# The digest scheme used to construct the message signatures. Must have the form
# 'hmac-HASH'.
# j.Session.signature_scheme = 'hmac-sha256'

# The name of the unpacker for unserializing messages. Only used with custom
# functions for `packer`.
# j.Session.unpacker = 'json'

# Username for the Session. Default is your system username.
# j.Session.username = 'username'

# -----------------------------------------------------------------------------
# MultiKernelManager(LoggingConfigurable) configuration
# -----------------------------------------------------------------------------

# A class for managing multiple kernels.

# The name of the default kernel to start
# j.MultiKernelManager.default_kernel_name = 'python3'

# The kernel manager class.  This is configurable to allow subclassing of the
# KernelManager for customized behavior.
# j.MultiKernelManager.kernel_manager_class = 'jupyter_client.ioloop.IOLoopKernelManager'

# -----------------------------------------------------------------------------
# MappingKernelManager(MultiKernelManager) configuration
# -----------------------------------------------------------------------------

# A KernelManager that handles notebook mapping and HTTP error handling

## Whether messages from kernels whose frontends have disconnected should be
#  buffered in-memory.
#
#  When True (default), messages are buffered and replayed on reconnect, avoiding
#  lost messages due to interrupted connectivity.
#
#  Disable if long-running kernels will produce too much output while no
#  frontends are connected.
#c.MappingKernelManager.buffer_offline_messages = True

## Whether to consider culling kernels which are busy. Only effective if
#  cull_idle_timeout > 0.
#c.MappingKernelManager.cull_busy = False

## Whether to consider culling kernels which have one or more connections. Only
#  effective if cull_idle_timeout > 0.
#c.MappingKernelManager.cull_connected = False

## Timeout (in seconds) after which a kernel is considered idle and ready to be
#  culled. Values of 0 or lower disable culling. Very short timeouts may result
#  in kernels being culled for users with poor network connections.
#c.MappingKernelManager.cull_idle_timeout = 0

## The interval (in seconds) on which to check for idle kernels exceeding the
#  cull timeout value.
#c.MappingKernelManager.cull_interval = 300

## Timeout for giving up on a kernel (in seconds).
#
#  On starting and restarting kernels, we check whether the kernel is running and
#  responsive by sending kernel_info_requests. This sets the timeout in seconds
#  for how long the kernel can take before being presumed dead.  This affects the
#  MappingKernelManager (which handles kernel restarts)  and the
#  ZMQChannelsHandler (which handles the startup).
#c.MappingKernelManager.kernel_info_timeout = 60

# When True (default), messages are buffered and replayed on reconnect, avoiding
# lost messages due to interrupted connectivity.

# Disable if long-running kernels will produce too much output while no
# frontends are connected.
# j.MappingKernelManager.buffer_offline_messages = True

# Whether to consider culling kernels which are busy. Only effective if
# cull_idle_timeout > 0.
# j.MappingKernelManager.cull_busy = False

# Whether to consider culling kernels which have one or more connections. Only
# effective if cull_idle_timeout > 0.
# j.MappingKernelManager.cull_connected = False

# Timeout (in seconds) after which a kernel is considered idle and ready to be
# culled. Values of 0 or lower disable culling. Very short timeouts may result
# in kernels being culled for users with poor network connections.
# j.MappingKernelManager.cull_idle_timeout = 0

# The interval (in seconds) on which to check for idle kernels exceeding the
# cull timeout value.
j.MappingKernelManager.cull_interval = 3000

# Timeout for giving up on a kernel (in seconds).

# On starting and restarting kernels, we check whether the kernel is running and
# responsive by sending kernel_info_requests. This sets the timeout in seconds
# for how long the kernel can take before being presumed dead.  This affects the
# MappingKernelManager (which handles kernel restarts)  and the
# ZMQChannelsHandler (which handles the startup).
# j.MappingKernelManager.kernel_info_timeout = 60

# j.MappingKernelManager.root_dir = ''

# -----------------------------------------------------------------------------
# ContentsManager(LoggingConfigurable) configuration
# -----------------------------------------------------------------------------

## Base class for serving files and directories.
#
#  This serves any text or binary file, as well as directories, with special
#  handling for JSON notebook documents.
#
#  Most APIs take a path argument, which is always an API-style unicode path, and
#  always refers to a directory.
#
#  - unicode, not url-escaped
#  - '/'-separated
#  - leading and trailing '/' will be stripped
#  - if unspecified, path defaults to '',
#    indicating the root path.

# This serves any text or binary file, as well as directories, with special
# handling for JSON notebook documents.

# Most APIs take a path argument, which is always an API-style unicode path, and
# always refers to a directory.

# Allow access to hidden files
j.ContentsManager.allow_hidden = True

# j.ContentsManager.checkpoints = None

# j.ContentsManager.checkpoints_class = 'notebook.services.contents.checkpoints.Checkpoints'

# j.ContentsManager.checkpoints_kwargs = {}

# handler class to use when serving raw file requests.

# Default is a fallback that talks to the ContentsManager API, which may be
# inefficient, especially for large files.

# Local files-based ContentsManagers can use a StaticFileHandler subclass, which
# will be much more efficient.

# Access to these files should be Authenticated.
# j.ContentsManager.files_handler_class = 'notebook.files.handlers.FilesHandler'

# Extra parameters to pass to files_handler_class.

# For example, StaticFileHandlers generally expect a `path` argument specifying
# the root directory from which to serve files.
# j.ContentsManager.files_handler_params = {}

# Glob patterns to hide in file and directory listings.
j.ContentsManager.hide_globs = ['__pycache__', '*.pyc', '*.pyo', '.DS_Store', '*.so', '*.dylib', '*~', '.git']

# Python callable or importstring thereof

# To be called on a contents model prior to save.

# This can be used to process the structure, such as removing notebook outputs
# or other side effects that should not be saved.

# It will be called as (all arguments passed by keyword)::

#     hook(path=path, model=model, contents_manager=self)

# - model: the model to be saved. Includes file contents.
#   Modifying this dict will affect the file that is stored.
# - path: the API path of the save destination
# - contents_manager: this ContentsManager instance
# j.ContentsManager.pre_save_hook = None


# j.ContentsManager.root_dir = '/'

# The base name used when creating untitled directories.
# j.ContentsManager.untitled_directory = 'Untitled Folder'

# The base name used when creating untitled files.
# j.ContentsManager.untitled_file = 'untitled'

# The base name used when creating untitled notebooks.
# j.ContentsManager.untitled_notebook = 'Untitled'

# -----------------------------------------------------------------------------
# FileManagerMixin(Configurable) configuration
# -----------------------------------------------------------------------------

# Mixin for ContentsAPI classes that interact with the filesystem.

# Provides facilities for reading, writing, and copying both notebooks and
# generic files.

# Shared by FileContentsManager and FileCheckpoints.

# Note ---- Classes using this mixin must provide the following attributes:

# root_dir : unicode
#     A directory against against which API-style paths are to be resolved.

# log : logging.Logger

# By default notebooks are saved on disk on a temporary file and then if
# succefully written, it replaces the old ones. This procedure, namely
# 'atomic_writing', causes some bugs on file system whitout operation order
# enforcement (like some networked fs). If set to False, the new notebook is
# written directly on the old one which could fail (eg: full filesystem or quota
# )
# j.FileManagerMixin.use_atomic_writing = True

# -----------------------------------------------------------------------------
# FileContentsManager(FileManagerMixin,ContentsManager) configuration
# -----------------------------------------------------------------------------

# If True (default), deleting files will send them to the platform's
# trash/recycle bin, where they can be recovered. If False, deleting files
# really deletes them.
# j.FileContentsManager.delete_to_trash = True

## Python callable or importstring thereof
#
#  to be called on the path of a file just saved.
#
#  This can be used to process the file on disk, such as converting the notebook
#  to a script or HTML via nbconvert.
#
#  It will be called as (all arguments passed by keyword)::
#
#      hook(os_path=os_path, model=model, contents_manager=instance)
#
#  - path: the filesystem path to the file just written - model: the model
#  representing the file - contents_manager: this ContentsManager instance
#c.FileContentsManager.post_save_hook = None

# to be called on the path of a file just saved.

# This can be used to process the file on disk, such as converting the notebook
# to a script or HTML via nbconvert.

# It will be called as (all arguments passed by keyword)::

#     hook(os_path=os_path, model=model, contents_manager=instance)

# - path: the filesystem path to the file just written - model: the model
# representing the file - contents_manager: this ContentsManager instance
# j.FileContentsManager.post_save_hook = None


# j.FileContentsManager.root_dir = ''

# -----------------------------------------------------------------------------
# NotebookNotary(LoggingConfigurable) configuration
# -----------------------------------------------------------------------------

# A class for computing and verifying notebook signatures.

# The hashing algorithm used to sign notebooks.
# j.NotebookNotary.algorithm = 'sha256'

# The sqlite file in which to store notebook signatures. By default, this will
# be in your Jupyter data directory. You can set it to ':memory:' to disable
# sqlite writing to the filesystem.
# j.NotebookNotary.db_file = ''

# The secret key with which notebooks are signed.
# j.NotebookNotary.secret = b''

# The file where the secret key is stored.
# j.NotebookNotary.secret_file = ''

# A callable returning the storage backend for notebook signatures. The default
# uses an SQLite database.
# j.NotebookNotary.store_factory = traitlets.Undefined

# -----------------------------------------------------------------------------
# KernelSpecManager(LoggingConfigurable) configuration
# -----------------------------------------------------------------------------

# If there is no Python kernelspec registered and the IPython kernel is
# available, ensure it is added to the spec list.
# j.KernelSpecManager.ensure_native_kernel = True

# The kernel spec class.  This is configurable to allow subclassing of the
# KernelSpecManager for customized behavior.
# j.KernelSpecManager.kernel_spec_class = 'jupyter_client.kernelspec.KernelSpec'

# Whitelist of allowed kernel names.

# By default, all installed kernels are allowed.
# j.KernelSpecManager.whitelist = set()

# -----------------------------------------------------------------------------
# NteractConfig(Configurable) configuration
# -----------------------------------------------------------------------------

# The nteract application configuration object

# Remote URL for loading assets
# j.NteractConfig.asset_url = ''

# Google Analytics tracking code
# j.NteractConfig.ga_code = ''
