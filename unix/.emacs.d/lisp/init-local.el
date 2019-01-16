;; Init Local
;;; Commentary:
;; Vim: set ft=lisp: set lisp:

;; Your personal configs

;;; Code:

;; BASIC CUSTOMIZATION
;; --------------------------------------

;; Don't close if i haven't saved customizations
(add-hook 'kill-emacs-query-functions
          'custom-prompt-customize-unsaved-options)

;; Run the Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Evil

(require 'goto-chg)

(setq evil-want-keybindina t)
(setq evil-want-minibuffer t)
(setq evil-ex-complete-emacs-commands t)
(require 'evil-collection)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(require 'evil-tabs)

(setq evil-magit-state 'motion)
(require 'evil-magit)

;; Python

(require 'anaconda-mode)

(setq python-shell-interpreter "ipython")
(setq python-shell-arguments "-i")


;; Org
;; -----

(require 'org-evil)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(setq org-indent-indentation-per-level 2)
(setq org-log-done t)
(setq 'org-startup-indented t)

(setq 'org-catch-invisible edits t)
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



(provide init-local)

;; init-local.el ends here
