;;; .spacemacs --- Spacemacs
;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;;; Commentary:
;;

;;; Code:

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
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
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.emacs.d/private/layers")
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ansible
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-idle-delay 0.2
                      auto-completion-private-snippets-directory nil
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t)
     autohotkey
     ;; doesn't do anything when (evil-mode 1) == t better-defaults
     dap
     emacs-lisp
     (git :variables
          git-magit-status-fullscreen t
          global-git-gutter+-mode t
          magit-repository-directories
          '(("~/projects" . 2)("~/src/" . 2)))

     (helm :variables
           helm-enable-auto-resize t)
     imenu-list  ;; tagbar
     lsp
     markdown
     neotree
     (org :variables
          org-enable-github-support t
          org-startup-indented t)
     ;; also check the var org-startup-options
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     (python :variables
             python-enable-yapf-format-on-save t
             python-sort-imports-on-save t
             python-backend 'lsp
             python-shell-interpreter "ipython3"
             python-shell-interpreter-args "-i --simple-prompt")
     restructuredtext
     spacemacs-completion
     spacemacs-editing
     spacemacs-editing-visual
     spacemacs-evil
     spacemacs-language
     spacemacs-layouts
     spacemacs-purpose
     spacemacs-org
     sphinx
     ;; spell-checking
     syntax-checking
     ;; version-control
     windows-scripts
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      gruvbox-theme evil-collection evil-tabs)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-but-keep-unused))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
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
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '(
                                (bookmarks . 10)
                                (projects . 10)
                                (todos . 7)
                                (agenda . 5)
                                (recents . 9))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(gruvbox-dark-hard)
                         fallback-theme '(spacemacs-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Fira Code"
                               :size 20
                               :weight normal
                               :width normal)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
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
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t
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
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
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
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
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
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
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
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'all
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; This is only needed once, near the top of the file
  (eval-when-compile
    (require 'use-package))

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

  (global-set-key "\C-cw"
                (lambda ()
                  (interactive)
                  (let ((woman-use-topic-at-point t))
                    (woman))))

  (defun your_spacemacs/evil-setup ()
    "Don't know what I'm doing in any capacity but this seemed like a better way
to organize the code I have already."
    ;; from the github page for evil-collection
    (use-package evil
      :defer t
      :ensure t
      :init
      (setq evil-want-keybinding nil)
      :config
      (evil-mode 1))

    (use-package evil-collection
      :defer t
      :after evil
      :ensure t
      :config
      (evil-collection-init))

  )

  ;; i'm gonna move the bindings out of this function as it seems like sylvan doesn't
  ;; bind keys in the same func in
  ;; ~/.emacs.d/layers/+spacemacs/spacemacs-evil/local/evil-unimpaired/evil-unimpaired.el

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


  (defun your_spacemacs/org_setup ()
    "https://orgmode.org/org.html#Code-Evaluation-Security
    Yeah that link has some good info like check this guy out.
    For example, here is how to execute ditaa code blocks without prompting:

    (defun my-org-confirm-babel-evaluate (lang body)
      (not (string= lang \"ditaa\")))  ;don't ask for ditaa
    (setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)"
    (setq-default
      org-confirm-babel-evaluate nil
      org-refile-use-cache t
      org-log-done 'time
      org-log-redeadline 'time
      org-log-refile 'time
      org-log-reschedule 'time
      org-log-reschedule 'time
      )

    ;; haven't tried yasnippet in org mode but let's try this in advance
    (add-hook 'org-mode-hook
                  (lambda ()
                    (setq-local yas/trigger-key [tab])
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


  )
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" default)))
 '(package-selected-packages
   (quote
    (elscreen evil-collection elfeed-goodies ace-jump-mode elfeed-org elfeed-web elfeed geeknote engine-mode spotify helm-spotify-plus multi twittering-mode wakatime-mode evil-cleverparens evil-commentary evil-snipe ranger diff-hl ansible ansible-doc company-ansible jinja2-mode edit-server gmail-message-mode ham-mode html-to-markdown flymd command-log-mode zeal-at-point counsel-dash helm-dash deft docker docker-tramp dockerfile-mode fasd flycheck-ledger ledger-mode osx-location rase sunshine theme-changer imenu-list nginx-mode pandoc-mode ox-pandoc prodigy puppet-mode rebox2 company-restclient know-your-http-well ob-http ob-restclient restclient-helm restclient salt-mode mmm-jinja2 yaml-mode esh-help eshell-prompt-extras eshell-z multi-term shell-pop xterm-color spray systemd terraform-mode hcl-mode vagrant vagrant-tramp company-ycmd flycheck-ycmd ycmd request-deferred color-identifiers-mode rainbow-identifiers rainbow-mode afternoon-theme alect-themes ample-theme ample-zen-theme apropospriate-theme anti-zenburn-theme badwolf-theme birds-of-paradise-plus-theme bubbleberry-theme busybee-theme cherry-blossom-theme clues-theme color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow cyberpunk-theme dakrone-theme darkburn-theme darkmine-theme darkokai-theme darktooth-theme django-theme dracula-theme espresso-theme exotica-theme farmhouse-theme flatland-theme flatui-theme gandalf-theme gotham-theme grandshell-theme gruber-darker-theme hc-zenburn-theme hemisu-theme heroku-theme inkpot-theme ir-black-theme jazz-theme jbeans-theme light-soap-theme lush-theme madhat2r-theme majapahit-theme material-theme minimal-theme moe-theme molokai-theme monokai-theme monochrome-theme mustang-theme naquadah-theme noctilux-theme obsidian-theme occidental-theme omtose-phellack-theme oldlace-theme organic-green-theme phoenix-dark-mono-theme phoenix-dark-pink-theme planet-theme professional-theme purple-haze-theme railscasts-theme rebecca-theme reverse-theme seti-theme smyx-theme soft-charcoal-theme soft-morning-theme soft-stone-theme solarized-theme soothe-theme spacegray-theme subatomic-theme subatomic256-theme sublime-themes sunny-day-theme tango-2-theme tango-plus-theme tangotango-theme tao-theme toxi-theme twilight-anti-bright-theme twilight-bright-theme twilight-theme ujelly-theme underwater-theme white-sand-theme zen-and-art-theme zenburn-theme helm-cscope xcscope ggtags helm-gtags bracketed-paste origami hl-anything evil-magit gitattributes-mode gitconfig-mode git-link git-messenger git-timemachine helm-gitignore gitignore-mode magit-gitflow magit-popup orgit smeargle gist github-browse-file github-clone github-search magit-gh-pulls magit gh marshal logito pcache transient p4 git-gutter-fringe git-gutter git-gutter-fringe+ fringe-helper git-gutter+ git-commit with-editor floobits company-nixos-options helm-nixos-options nix-mode nixos-options launchctl osx-dictionary osx-trash pbcopy reveal-in-osx-finder nlinum-relative nlinum adoc-mode markup-faces nasm-mode x86-lookup ahk-mode org-ref pdf-tools key-chord tablist helm-bibtex parsebib biblio biblio-core disaster clang-format cmake-mode company-c-headers srefactor stickyfunc-enhance cider-eval-sexp-fu clj-refactor edn cider paredit sesman queue parseedn parseclj a peg clojure-mode clojure-snippets common-lisp-snippets slime-company slime omnisharp csharp-mode csv-mode company-dcd d-mode flycheck-dmd-dub alchemist flycheck-mix elixir-mode flycheck-credo ob-elixir elm-mode reformatter flycheck-elm erlang ess-R-data-view ess-smart-equals ess arduino-mode julia-mode matlab-mode qml-mode scad-mode stan-mode thrift faust-mode fsharp-mode company-go flycheck-gometalinter go-eldoc go-guru go-mode graphviz-dot-mode cmm-mode company-cabal company-ghci company-ghc flycheck-haskell ghc haskell-snippets helm-hoogle hindent hlint-refactor intero haskell-mode company-web web-completion-data emmet-mode helm-css-scss pug-mode sass-mode haml-mode scss-mode slim-mode tagedit web-mode idris-mode prop-menu ein polymode company-emacs-eclim eclim coffee-mode company-tern js-doc js2-refactor multiple-cursors json-mode json-reformat json-snatcher tern web-beautify livid-mode skewer-mode js2-mode simple-httpd auctex-latexmk company-auctex auctex typo lua-mode company-emoji emoji-cheat-sheet-plus gh-md markdown-toc mmm-mode vmd-mode flycheck-nim nim-mode flycheck-nimsuggest commenter epc ctable concurrent deferred merlin ocp-indent tuareg caml utop drupal-mode php-auto-yasnippets php-mode phpcbf phpunit plantuml-mode psci purescript-mode psc-ide company-anaconda anaconda-mode cython-mode helm-pydoc hy-mode live-py-mode pip-requirements py-isort pyenv-mode pythonic pytest pyvenv yapfify company-quickhelp racket-mode faceup bundler chruby enh-ruby-mode minitest rbenv robe rspec-mode rubocop ruby-test-mode ruby-tools rvm cargo markdown-mode racer flycheck-rust rust-mode toml-mode ensime noflet scala-mode sbt-mode geiser glsl-mode company-glsl company-shell fish-mode insert-shebang ob-sml sml-mode sql-indent swift-mode tide typescript-mode vimrc-mode dactyl-mode pyim pyim-basedict chinese-wbim fcitx find-by-pinyin-dired ace-pinyin pinyinlib pangu-spacing youdao-dictionary names chinese-word-at-point 2048-game pacmacs dash-functional sudoku typit mmt selectric-mode xkcd pony-mode feature-mode projectile-rails rake inf-ruby inflections mu4e-alert mu4e-maildirs-extension mwim unfill ibuffer-projectile ox-twbs ox-gfm ox-reveal smex ac-ispell auto-complete company-statistics fuzzy helm-company company helm-c-yasnippet auto-yasnippet yasnippet counsel-projectile counsel swiper ivy-hydra wgrep auto-dictionary flyspell-correct-ivy ivy flyspell-correct-helm flyspell-correct-popup flyspell-correct flyspell-popup flycheck-pos-tip pos-tip flycheck erc-hl-nicks erc-image erc-social-graph erc-view-log erc-yt jabber srv fsm rcirc-color rcirc-notify slack emojify circe oauth2 websocket ht powershell org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download htmlize gnuplot ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra lv hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(provide '.spacemacs)

;;; .spacemacs.neon ends here
