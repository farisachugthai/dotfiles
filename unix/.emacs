; emacs configuration
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("3da031b25828b115c6b50bb92a117f5c0bbd3d9d0e9ba5af3cd2cb9db80db1c2" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "a622aaf6377fe1cd14e4298497b7b2cae2efc9e0ce362dade3a58c16c89e089c" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" default)))
 '(custom-theme-allow-multiple-selections t)
 '(font-use-system-font nil)
 '(ispell-check-comments nil)
 '(package-check-signature t)
 '(package-enable-at-startup t)
 '(package-selected-packages
   (quote
    (org-evil lsp-python sphinx-doc elpy which-key gruvbox-theme ivy helm-pydoc kwin playerctl evil-org evil-surround evil-commentary better-defaults evil-python-movement evil-text-object-python visual-regexp-steroids conda helm-ag anaconda-mode tldr helm evil python yasnippet org)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 98 :width normal))))
 '(window-divider ((t (:foreground "DarkGoldenrod2")))))

;; Personal
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(setq evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
(setq evil-motion-state-modes nil)

(evil-define-key 'normal dired-mode-map
  "h" 'dired-up-directory
  "j" 'dired-next-line
  "k" 'dired-previous-line
  "l" 'dired-find-alternate-file)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

(add-to-list 'load-path "~/.emacs.d/elpa")

(add-to-list 'load-path "~/.emacs.d/viper")

(add-to-list 'load-path "~/.emacs.d/site-lisp")

(add-to-list 'load-path "~/.emacs.d/spacemacs")
