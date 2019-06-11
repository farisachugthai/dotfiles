;;; .spacemacs --- Spacemacs
;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;; Vim: set ft=lisp:commentstring=;\ %s
;; I'm incurable

;;; Commentary:
;; For a short time kept track of functions with a (defvar). Then found imenu-list
;; in spacemacs that's <SPC> b i btw

;;; Code:

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation nil
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.emacs.d/private/layers")

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-front-end 'company
                      auto-completion-idle-delay 0.2
                      auto-completion-private-snippets-directory "~/.emacs.d/private/snippets"
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      spacemacs-default-company-backends '(company-ispell company-files company-anaconda))
     autohotkey
     bm  ;; bookmarks!
     (colors :variables
             colors-colorize-identifiers 'all
             colors-enable-nyan-cat-progress-bar (display-graphic-p))
     common-lisp  ;; without this we don't get slime
     csv
     dap  ;; note this is a full GUI debugger dude. it's the Debug Adapter Protocol
     debug
     django
     emacs-lisp
     emoji
     evil-commentary
     (evil-snipe :variables evil-snipe-enable-alternate-f-and-t-behaviors t)
     (git :variables
          git-magit-status-fullscreen t
          global-git-commit-mode t
          global-git-gutter+-mode t
          magit-repository-directories
          '(("~/projects" . 2)("~/src/" . 2)))
     (helm :variables
           helm-enable-auto-resize t
           helm-elisp-show-doc-modeline t  ;; is this a default?
           helm-M-x-fuzzy-match t  ;; optional fuzzy matching for helm-M-x
           helm-buffers-fuzzy-matching t
           helm-recentf-fuzzy-match t)
     (html :variables web-fmt-tool 'prettier)
     hy  ;; this mode is so fucking cool
     (ibuffer :variables
              ibuffer-group-buffers-by "projects")
     imenu-list  ;; tagbar
     ipython-notebook
     javascript
     json
     lsp
     markdown
     neotree
     org  ;; go down to yourspacemacs/org_setup to see the vars
     (python :variables
             python-auto-set-local-pyenv-version nil
             python-auto-set-local-pyvenv-virtualenv nil
             python-backend 'anaconda
             python-enable-yapf-format-on-save t
             python-fill-column 120
             python-formatter 'yapf
             python-format-on-save t
             python-indent-offset 4
             python-sort-imports-on-save t
             python-shell-interpreter "ipython3"
             python-shell-interpreter-args "-i --simple-prompt"
             python-test-runner '(pytest nose unittest))
     (ranger :variables
             ranger-cleanup-on-disable t
             ranger-ignored-extensions '("mkv" "iso" "mp4")
             ranger-max-preview-size 2 ;; it's in MB so don't open big shit
             ranger-override-dired t
             ranger-show-preview t
             ranger-show-hidden t)
     restructuredtext
     (shell :variables
            shell-default-height 30
            shell-default-shell 'eshell
            shell-default-term-shell 'eshell
            shell-default-position 'bottom)
     spacemacs
     spacemacs-completion
     spacemacs-docker
     spacemacs-editing
     spacemacs-editing-visual
     spacemacs-evil
     spacemacs-language
     spacemacs-layouts
     spacemacs-misc
     spacemacs-modeline
     spacemacs-navigation
     spacemacs-org
     spacemacs-purpose
     spacemacs-visual
     (spell-checking :variables spell-checking-enable-by-default nil)
     sphinx
     spotify
     (syntax-checking :variables syntax-checking-enable-by-default nil
                      syntax-checking-enable-tooltips t)
     unicode-fonts
     (version-control :variables version-control-diff-tool 'diff-hl)
     vimscript
     vinegar
     windows-scripts
     yaml)

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(evil-tabs
                                      elpy
                                      evil-collection
                                      fzf
                                      realgud-ipdb
                                      use-package-ensure-system-package
                                      auto-package-update
                                      python-mode sphinx-mode)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(treemacs treemacs-lsp treemacs-projectile lsp-treemacs chinese-wbim chinese-conv)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 10)
                                (bookmarks . 10)
                                (projects . 10)
                                (agenda . 5)
                                (todos . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message "* Happy Hacking <3"

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(gruvbox-dark-hard)
   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Hack"
                               :size 15
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names t

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 5

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize t

   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil

   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom

   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)

   ;; don't set to true this is really annoying
   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose t

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 100

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 100

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers 'relative

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S - %m - %t "

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'all

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump.

This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here.

Here's some good advice that probably could apply to every package below.

Because of autoloading, calling to =org= functions will trigger the loading up
of the =org= shipped with Emacs which will induce conflicts. One way to avoid
conflict is to wrap your =org= config code in a =with-eval-after-load= block
like this:

#+BEGIN_SRC emacs-lisp
  (with-eval-after-load 'org
    ;; Org config goes here
    ;; ....
    )
#+END_SRC

From the Spacemacs FAQ."

  ;; This is only needed once, near the top of the file
  ;; (eval-when-compile
    ;; (require 'use-package))

  ;; The :ensure-system-package keyword allows you to ensure system binaries exist alongside your package declarations.

  ;; First, you will want to make sure exec-path is cognisant of all binary
  ;; package names that you would like to ensure are installed.
  ;; exec-path-from-shell is often a good way to do this.

  ;; To enable the extension after you've loaded use-package:
  ;; (use-package use-package-ensure-system-package
  ;;   :ensure t)

  ;; made this up as an example
  ;; (use-package lsp
  ;;   :ensure-system-package python-language-server)

  ;; ooo here's a great example
  ;; (use-package tern
  ;;   :ensure-system-package (tern . "npm i -g tern"))

  ;; The package is "python" but the mode is "python-mode": Can we put ipython for the interpreter?

  (use-package auto-package-update
    :config
    (setq-default auto-package-update-delete-old-versions t)
    (setq-default auto-package-update-hide-results t)
    (auto-package-update-maybe))


    (setq-default scroll-margin 5
                  scroll-conservatively 9999
                  scroll-step 1)

  (setq-default tab-width 4 indent-tabs-mode nil)
  (define-key global-map (kbd "RET") 'newline-and-indent)

  ;; The following is from Section 3 in the Info page on 'woman'.
  ;; 3.1.2 Using the "Word at Point" as a Topic Suggestion
  ;; -----------------------------------------------------

  ;; By default, the ‘woman’ command uses the word nearest to point in the
  ;; current buffer as a suggestion for the topic to look up, if it exists as
  ;; a valid topic.  The topic can be confirmed or edited in the minibuffer.


  ;; Dude you can still access registers like Vim. "*p just worked I love you spacemacs
  ;; Btw yes I checked to see that this was still available
  (global-set-key
    (kbd "C-c w")
      (lambda ()
        (interactive)
          (let ((woman-use-topic-at-point t)) (woman))))

  '(hl-todo-keyword-faces
    (quote
     (("TODO" . "#dc752f")
      ("NEXT" . "#dc752f")
      ("THEM" . "#2d9574")
      ("PROG" . "#4f97d7")
      ("OKAY" . "#4f97d7")
      ("DONT" . "#f2241f")
      ("FAIL" . "#f2241f")
      ("DONE" . "#86dc2f")
      ("NOTE" . "#b1951d")
      ("KLUDGE" . "#b1951d")
      ("HACK" . "#b1951d")
      ("TEMP" . "#b1951d")
      ("FIXME" . "#dc752f")
      ("XXX" . "#dc752f")
      ("XXXX" . "#dc752f")
      ("???" . "#dc752f"))))

  ;; Activate evil-smartparens when I'm in a common lisp filetype
  (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hook-common-lisp-mode)
  ;; And a racket file
  (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hook-racket-mode)

  (setq-default info-lookup-history)

  (spacemacs/toggle-tool-bar-on)

  ;; disable backup
  (setq-default backup-inhibited t)
  ;; disable auto save
  (setq-default auto-save-default nil)
  (put 'erase-buffer 'disabled nil)


  (global-flycheck-mode)
  (global-visual-fill-column-mode)

  (setq-default case-fold-search nil)

  (setq-default user-mail-address "farischugthai@gmail.com")

  ;; (set-language-environment "utf-8")
  (if (fboundp 'blink-cursor-mode)
      (blink-cursor-mode 0))

  (if (boundp 'coding-category-utf-8)
      (set-coding-system-priority '(code-category-utf-8)))

  (setq-default lexical-binding t)
  (setq load-prefer-newer t)


  ;; this'll be useful but we're defining it on ms win
  (when (equal system-type 'gnu/linux)
    (setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "xdg-open"))

  (show-paren-mode t)

  ;; how to run in a script? seems only interactive
  ;; (spacemacs/linum-relative-toggle)

  (setq speedbar-show-unknown-files t)
)


(defun your_spacemacs/evil_setup ()
  "Setup evil and related packages.

  Also note that if you want, the info page on Viper: 3.1 Rudimentary Changes
  goes through a list of all configurable options.

  Plus it's a good read as it goes through a lot of `good to know` type things
  with ample summaries of keybindings.

  Damnit. This is gonna get complicated. If you checkout
  the spacemacs-bootstrap layer you'll
  run into the function init-evil. Evil's already required :/

  Found the evil-surround repo.

** Add surrounding

You can surround in visual-state with S<textobject> or gS<textobject>.
Or in normal-state with ys<textobject> or yS<textobject>.
Change surrounding

You can change a surrounding with cs<old-textobject><new-textobject>.
Delete surrounding

You can delete a surrounding with ds<textobject>.
Add new surround pairs

To change the default evil-surround-pairs-alist you have to use
\"setq-default\", for example to remove all default pairs:

\(setq-default evil-surround-pairs-alist '\(\)\)

or to add a pair that surrounds with two ` if you enter ~:

\(setq-default evil-surround-pairs-alist
              \(push '\(?~ . \(\"``\" . \"``\"\)\) evil-surround-pairs-alist\)\)

I deleted a bunch because flycheck was being bitchy. Then it auto-escaped a
 bunch of things."
  ;; from the github page for evil-collection
  (use-package evil
    :ensure t
    :init
    (setq-default evil-want-keybinding nil)
    :config
    (evil-mode 1)
    (setq evil-shift-width 4))

  ;; After major mode has changed, reset evil-shift-width
  (add-hook 'after-change-major-mode-hook 'spacemacs//set-evil-shift-width 'append)

  (use-package evil-collection
    :after evil
    :ensure t
    ;; got this from the github. EVIL IN THE MINIBUFFER!
    :custom (evil-collection-setup-minibuffer t)
    :init (evil-collection-init))

  (use-package evil-matchit
    :ensure t
    :after evil
    :config
    (global-evil-matchit-mode t))

  (use-package evil-surround
    :after evil
    :config
    (global-evil-surround-mode t))

  (use-package evil-tabs
    :after evil
    :ensure t
    :config
    (global-evil-tabs-mode))

        (define-key evil-motion-state-map "j" 'evil-next-visual-line)
        (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
        ;; Also in visual mode
        (define-key evil-visual-state-map "j" 'evil-next-visual-line)
        (define-key evil-visual-state-map "k" 'evil-previous-visual-line)

        ;; Split navigation.
        (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
        (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
        (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
        (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

        (setq-default evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
        (setq-default evil-motion-state-modes nil)

        (define-key evil-motion-state-map "j" 'evil-next-visual-line)
        (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
        ;; Also in visual mode
        (define-key evil-visual-state-map "j" 'evil-next-visual-line)
        (define-key evil-visual-state-map "k" 'evil-previous-visual-line)


)

(with-eval-after-load 'org
(defun your_spacemacs/org_setup ()
    "Set up org configuration.

    https://orgmode.org/org.html#Code-Evaluation-Security
    Yeah that link has some good info like check this guy out.
    For example, here is how to execute ditaa code blocks without prompting:

    (defun my-org-confirm-babel-evaluate (lang body)
      (not (string= lang \"ditaa\")))  ;don't ask for ditaa
    (setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)"

    (with-eval-after load 'org
                     (
          org-bullets-bullet-list '("■" "◆" "▲" "▶")
          org-confirm-babel-evaluate nil
          org-log-done 'time
          org-log-redeadline 'time
          org-log-refile 'time
          org-log-reschedule 'time
          org-journal-dir "~/org/journal/"
          org-journal-file-format "%Y-%m-%d"
          org-journal-date-prefix "#+TITLE: "
          org-journal-date-format "%A, %B %d %Y"
          org-journal-time-prefix "* "
          org-journal-time-format ""
          spaceline-org-clock-p t))


                (spacemacs-space-doc-modificators
   (add-hook 'org-mode-hook
                 (lambda ()
                   (setq-default yas/trigger-key [tab])
                   (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

                (spacemacs-space-docs-modificators
                '(center-buffer-mode
                  org-indent-mode
                  view-mode
                  hide-line-numbers
                  alternative-emphasis
                  alternative-tags-look
                  link-protocol
                  org-block-line-face-remap
                  org-kbd-face-remap
                  resize-inline-images)))
    ;; haven't tried yasnippet in org mode but let's try this in advance
    (add-hook 'org-mode-hook
                  (lambda ()
                    (setq-default yas/trigger-key [tab])
                    (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))
    ;;; If this doesn't fix it
    ;; (defun yas/org-very-safe-expand ()
    ;;   (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

    ;; Then, tell Org mode to use that function:

    ;; (add-hook 'org-mode-hook
    ;;           (lambda ()
    ;;             (make-variable-buffer-local 'yas/trigger-key)
    ;;             (setq yas/trigger-key [tab])
    ;;             (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
    ;;             (define-key yas/keymap [tab] 'yas/next-field)))

    (with-eval-after-load 'org-agenda
      (require 'org-projectile)
      (mapcar '(lambda (file)
                 (when (file-exists-p file)
                   (push file org-agenda-files)))
              (org-projectile-todo-files)))


    (with-eval-after-load 'org
      (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
      (setq org-agenda-skip-scheduled-if-done t)
      (setq org-enable-org-journal-support t)
      (setq org-enable-github-support t)
      (setq org-startup-indented t)
      (setq org-refile-use-cache t)
      (setq org-want-todo-bindings t)
      (org-indent-mode))

    (setq helm-org-headings-fontify t)

))


(defun your-spacemacs/comint_setup ()
  "From use-package info page.

I'm gonna add some stuff for ielm here too because why not?"

  (use-package comint
    :custom
    (comint-buffer-maximum-size 20000 "Increase comint buffer size.")
    (comint-prompt-read-only t "Make the prompt read only."))

  (with-eval-after-load
      (progn
        (setq-default ielm-noise nil)
        (setq-default ielm-prompt-read-only nil)))
)


(defun your_spacemacs/add_pretty_symbols ()
  "From ergoemacs.org."
  (setq-default prettify-symbols-alist
        '(
          ("lambda" . 955)
          ("-->" . 8594)
          ("==>" . 8658)
          ("map" . 8614)
          ))
  (add-hook 'emacs-lisp-mode-hook 'yourspacemacs/add_pretty_symbols)
)


(defun your_spacemacs/eshell_setup()
"Initialize eshell.

+TODO: Add docstrings to these variables I guess"
  (with-eval-after-load 'eshell
    (progn
      (setq-default
       ;; so then it falls to HISTSIZE. how do we set env vars in emacs
       ;; eshell-history-size nil)
       eshell-hist-ignoredups t
       eshell-cd-shows-directory t
       eshell-ls-dired-initial-args "-hF --color always --dired")))
)

(defun your_spacemacs/term_setup()
  "Copied from jwiegley and the README of his `use-package.'
Shows a good example of using bind and map. Calling a package with use-package's *bind* keyword
means that that package will be autoloaded"
(use-package term
  :bind (("C-c t" . term)
         :map term-mode-map
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)
         :map term-raw-map
         ("M-o" . other-window)
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)))
)

(defun your_spacemacs/savehist_setup ()
  "Save/restore command history etc across sessions."
  (use-package savehist
    :ensure t
    :defer t)

  (with-eval-after-load 'savehist
    (progn
      (setq-default savehist-additional-variables '(extended-command-history global-mark-ring mark-ring search-ring regexp-search-ring))
      (setq-default savehist-file "~/.emacs.d/savehist")
      (setq-default history-length 10000)
      (savehist-mode 1)))

)


(defun your_spacemacs/yasnippet_setup ()
"Setup yasnippet. I don't know why it doesn't seem to be working.
Enabled it twice and I still am loading yasnippet manually. Hm."
(use-package yasnippet
  :config
  (yas-minor-mode on)
  (yas-load-directory "~/.emacs.d/private/snippets"))

(yas-global-mode)

)


(defun your_spacemacs/python_setup ()
  "Setup IPython on Emacs. Set up some rst thanks to Matplotlib!

Here are useful bindings for rst.

C-c TAB - rst-toc-insert

  Insert table of contents at point

C-c C-u - rst-toc-update

    Update the table of contents at point

C-c C-l rst-shift-region-left

    Shift region to the left

C-c C-r rst-shift-region-right

    Shift region to the right"
;; The package is "python" but the mode is "python-mode":

   (add-hook 'python-mode-hook
     (use-package python
       :mode ("\\.py\\'" . python-mode)
       :interpreter ("ipython3" . python-mode))
     (define-key evil-normal-state-map (kbd "[F5]") 'spacemacs/python-execute-file))

   (use-package rst-mode
     :defer t
     :config
     (setq auto-mode-alist
         (append '(("\\.txt$" . rst-mode)
                   ("\\.rst$" . rst-mode)
                   ("\\.rest$" . rst-mode)) auto-mode-alist)))

   (use-package python-mode-hook
     :ensure t)

   (use-package sphinx-mode
     :ensure t)

   (use-package python-x
     :config
     (python-x-setup))


 ;; (use-package 'company
 ;;   :config
 ;;   (add-hook 'after-init-hook 'global-company-mode))

 ;; (with-eval-after-load 'company
 ;;   (use-package 'company-quickhelp
 ;;     (:bind
 ;;     '(company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin)))
 (add-hook 'after-init-hook 'global-company-mode)

(eval-after-load 'company '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

(use-package company-jedi
  :commands (jedi:goto-definition jedi-mode company-jedi)
  :bind (:map python-mode-map
              ("M-." . jedi:goto-definition)
              ("M-," . jedi:goto-definition-pop-marker))
  :config
  (progn
    (setq jedi:complete-on-dot t)
    (setq jedi:imenu-create-index-function 'jedi:create-flat-imenu-index)))

)

(defun your_spacemacs/paradox_setup ()
  "Load paradox."
  (use-package paradox
    :commands (paradox-upgrade-packages paradox-list-packages)
    :config
    (progn
      (setq paradox-execute-asynchronously t)))
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/first_agenda.org")))
 '(package-selected-packages
   (quote
    (yasnippet-snippets yapfify yaml-mode xterm-color ws-butler writeroom-mode winum which-key web-mode web-beautify volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package-ensure-system-package unicode-fonts toc-org tagedit symon symbol-overlay string-inflection spotify sphinx-mode spaceline-all-the-icons smeargle slime-company slim-mode shell-pop scss-mode sass-mode restart-emacs realgud-ipdb ranger rainbow-mode rainbow-identifiers rainbow-delimiters python-mode pytest pyenv-mode py-isort pug-mode prettier-js powershell popwin pony-mode pippel pipenv pip-requirements persp-mode pcre2el password-generator paradox overseer orgit org-projectile org-present org-pomodoro org-mime org-download org-cliplink org-bullets org-brain open-junk-file ob-ipython ob-hy nodejs-repl neotree nameless multi-term move-text mmm-mode markdown-toc magit-svn magit-gitflow lsp-ui lsp-python-ms lorem-ipsum livid-mode live-py-mode link-hint json-navigator json-mode js2-refactor js-doc indent-guide importmagic impatient-mode ibuffer-projectile hy-mode hungry-delete hl-todo highlight-parentheses highlight-numbers helm-xref helm-themes helm-swoop helm-spotify-plus helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-mode-manager helm-make helm-lsp helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag gruvbox-theme google-translate golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fzf fuzzy font-lock+ flyspell-correct-helm flycheck-pos-tip flycheck-package flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-tabs evil-surround evil-snipe evil-org evil-numbers evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-commentary evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emojify emoji-cheat-sheet-plus emmet-mode elpy elisp-slime-nav ein editorconfig dumb-jump dotenv-mode doom-modeline diminish diff-hl devdocs define-word dap-mode dactyl-mode cython-mode csv-mode counsel-projectile company-web company-tern company-statistics company-quickhelp company-lsp company-emoji company-anaconda common-lisp-snippets column-enforce-mode color-identifiers-mode clean-aindent-mode centered-cursor-mode browse-at-remote bm blacken auto-yasnippet auto-package-update auto-highlight-symbol auto-dictionary auto-complete-rst auto-compile ahk-mode aggressive-indent ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
