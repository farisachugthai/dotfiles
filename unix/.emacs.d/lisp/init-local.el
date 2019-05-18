;; init-local.el --- Emacs Initialization File
;;; Commentary:
;; Vim: set ft=lisp: set lisp:

;; Your personal configs

;;; Code:

;; BASIC CUSTOMIZATION
;; --------------------------------------

(defun yourspacemacs/setup ()


(add-to-list 'load-path "~/.emacs.d/elpa/26.2")

;; Don't close if i haven't saved customizations
(add-hook 'kill-emacs-query-functions
          'custom-prompt-customize-unsaved-options)

;; Run the Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; (setq 'suggest-key-bindings 10) ;; show equivalent keybindings for 10sec. default is 2 but i'm slow
;; apparently i'm doing something wrong. *shrugs*
)
;; Evil
;;------

(defun yourspacemacs/setup_python ()

;; PYTHON CONFIGURATION
;; --------------------------------------

;; Python

(require 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)

(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

(require 'flycheck-pyflakes)
(add-hook 'python-mode-hook 'flycheck-mode)
)

;; Org
;; -----

(require 'org-evil)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(setq org-indent-indentation-per-level 2)

                                        ; (setq 'org-startup-indented t)

;; (setq 'org-catch-invisible edits t)
;; Hint: This is the main list in lisp/init-git.el
                                        ; (when (maybe-require-package 'magit)
                                        ;   (setq-default magit-diff-refine-hunk t)

                                        ;   ;; Hint: customize `magit-repository-directories' so that you can use C-u M-F12 to
                                        ;   ;; quickly open magit on any one of your projects.
                                        ;   (global-set-key [(meta f12)] 'magit-status)
                                        ;   (global-set-key (kbd "C-x g") 'magit-status)
                                        ;   (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

                                        ;   (defun sanityinc/magit-or-vc-log-file (&optional prompt)
                                        ;     (interactive "P")
                                        ;     (if (and (buffer-file-name)
                                        ;              (eq 'Git (vc-backend (buffer-file-name))))
                                        ;         (if prompt
                                        ;             (magit-log-buffer-file-popup)
                                        ;           (magit-log-buffer-file t))
                                        ;       (vc-print-log)))

                                        ;   (after-load 'vc
                                        ;     (define-key vc-prefix-map (kbd "l") 'sanityinc/magit-or-vc-log-file)))

;; Viper
;; ------

(setq viper-inhibit-startup-message 't)
(setq viper-expert-level '1)


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

From the spacemacs FAQ."

  ;; first things first we should define use-package
  (eval-when-compile
    (require 'use-package))

  ;; The :ensure-system-package keyword allows you to ensure system binaries exist alongside your package declarations.

  ;; First, you will want to make sure exec-path is cognisant of all binary
  ;; package names that you would like to ensure are installed.
  ;; exec-path-from-shell is often a good way to do this.

  ;; To enable the extension after you've loaded use-package:
  (use-package use-package-ensure-system-package
    :ensure t)

  ;; made this up as an example
  ;; (use-package lsp
  ;;   :ensure-system-package python-language-server)

  ;; ooo here's a great example

;; The rest is general setup

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

  ;; The package is "python" but the mode is "python-mode":
  (use-package python
    :mode ("\\.py\\'" . python-mode)
    :interpreter ("python" . python-mode))

  (use-package auto-package-update
    :config
    (setq-default auto-package-update-delete-old-versions t)
    (setq-default auto-package-update-hide-results t)
    (auto-package-update-maybe))


  (progn
    (setq-default scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

  (setq-default tab-width 4 indent-tabs-mode nil)
  (define-key global-map (kbd "RET") 'newline-and-indent)

  ;; Save/restore command history etc across sessions.
  (with-eval-after-load 'savehist
    (require 'savehist)
    (progn
      (setq-default savehist-additional-variables '(extended-command-history global-mark-ring mark-ring search-ring regexp-search-ring))
      (setq-default savehist-file "~/.emacs.d/savehist")
      (setq-default history-length 10000)
      (savehist-mode 1)))

  ;; The following is from Section 3 in the Info page on 'woman'.
  ;; 3.1.2 Using the "Word at Point" as a Topic Suggestion
  ;; -----------------------------------------------------

  ;; By default, the ‘woman’ command uses the word nearest to point in the
  ;; current buffer as a suggestion for the topic to look up, if it exists as
  ;; a valid topic.  The topic can be confirmed or edited in the minibuffer.


  ;; Dude you can still access registers like Vim. "*p just worked I love you spacemacs
  ;; Btw yes I checked to see that this was still available
  (global-set-key "\C-cw"
                  (lambda ()
                    (interactive)
                    (let ((woman-use-topic-at-point t))
                      (woman))))

  (setq-default info-lookup-history)

  )

(defun your_spacemacs/evil-setup ()
  "Setup evil and related packages.

Also note that if you want, the info page on Viper: 3.1 Rudimentary Changes
goes through a list of all configurable options.

Plus it's a good read as it goes through a lot of `good to know` type things
with ample summaries of keybindings.

Damnit. This is gonna get complicated. IF you checkout spacemacs-bootstrap you'll
run into the function init-evil. evil's already required :/


Found the evil-surround repo.
Add surrounding

You can surround in visual-state with S<textobject> or gS<textobject>. Or in normal-state with ys<textobject> or yS<textobject>.
Change surrounding

You can change a surrounding with cs<old-textobject><new-textobject>.
Delete surrounding

You can delete a surrounding with ds<textobject>.
Add new surround pairs

To change the default evil-surround-pairs-alist you have to use \"setq-default\", for example to remove all default pairs:

(setq-default evil-surround-pairs-alist '())

or to add a pair that surrounds with two ` if you enter ~:

(setq-default evil-surround-pairs-alist
              (push '(?~ . ("``" . "``")) evil-surround-pairs-alist))
  "
  ;; from the github page for evil-collection
  (use-package evil
    :ensure t
    :init
    (setq-default evil-want-keybinding nil)
    :config
    (evil-shift-width 4)
    (setq-default evil-want-integration t)
    (setq-default evil-want-minibuffer t)
    (setq-default evil-ex-complete-emacs-commands t)
    (evil-mode 1))

    ;; After major mode has changed, reset evil-shift-width
    (add-hook 'after-change-major-mode-hook 'spacemacs//set-evil-shift-width 'append)
m
  (use-package evil-collection
    :after evil
    :ensure t
    :custom (evil-collection-setup-minibuffer t)
    :init (evil-collection-init))

  (use-package evil-matchit
    :ensure t
    :config
    (global-evil-matchit-mode t))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode t))

  (use-package evil-tabs
    :after evil
    :ensure t
    :config
    (global-evil-tabs-mode t))

  (with-eval-after-load evil
    (progn
      ((define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
       (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
       (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
       (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

       (define-key evil-motion-state-map "j" 'evil-next-visual-line)
       (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
       ;; Also in visual mode
       (define-key evil-visual-state-map "j" 'evil-next-visual-line)
       (define-key evil-visual-state-map "k" 'evil-previous-visual-line))))


;; Evil requires undo-tree. Don't know where i declare that.
(require 'undo-tree)
;; (setq undo-tree-auto-save-history)

(require 'evil-tabs)
(global-evil-tabs-mode t) ; tabs (requires evil-tabs)

setq (
      evil-emacs-state-cursor '("red" box)
      evil-normal-state-cursor '("green" box)
      evil-visual-state-cursor '("orange" box)
      evil-insert-state-cursor '("red" bar)
      evil-replace-state-cursor '("red" bar)
      evil-operator-state-cursor '("red" hollow))

;; (setq evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
(setq evil-motion-state-modes nil)

(evil-define-key 'normal 'dired-mode-map
                 "h" 'dired-up-directory
                 "j" 'dired-next-line
                 "k" 'dired-previous-line
                 "l" 'dired-find-alternate-file)

(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change) (global-set-key [(control ?,)] 'goto-last-change-reverse)

(require 'evil-collection)

(when (require 'evil-collection nil t)
  (evil-collection-init))

(setq evil-collection-setup-minibuffer t)  ; vim keybindings even in minibuffers

(setq evil-magit-state 'motion)
;; do i need an evil-magit init func call
(require 'evil-magit)

(global-evil-leader-mode t)
(global-evil-tabs-mode t)

(setq evil-shift-width 4)
)


(defun your_spacemacs/org_setup ()
   "Set up org mode.

   https://orgmode.org/org.html#Code-Evaluation-Security
   Yeah that link has some good info like check this guy out.
   For example, here is how to execute ditaa code blocks without prompting:

   (defun my-org-confirm-babel-evaluate (lang body)
     (not (string= lang \"ditaa\")))  ;don't ask for ditaa
   (setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)"

   (with-eval-after-load 'org
   (progn
     (
       (setq-default
         org-confirm-babel-evaluate nil
         org-refile-use-cache t
         org-log-done 'time
         org-log-redeadline 'time
         org-log-refile 'time
         org-log-reschedule 'time))))
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
)

(defun your-spacemacs-setup/comint_setup ()
  "From use-package info page."

  (use-package comint
    :custom
    (comint-buffer-maximum-size 20000 "Increase comint buffer size.")
    (comint-prompt-read-only t "Make the prompt read only."))
)

(defun yourspacemacs/git_setup ()
  "Setup git and magit."
  '(git-magit-status-fullscreen t)
  '(global-git-gutter+-mode t)
  (setq-default
   (quote(magit-repository-directories
           (
           ("~/projects/" . 2)
        ("~/src/" . 2)))))
 )



provide 'init-local)
;; init-local.el ends here
