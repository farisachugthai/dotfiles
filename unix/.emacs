;; init.el --- Emacs Initialization File
;;; Commentary:
;; Vim: set ft=lisp: set lisp:
;;
;; Author: Faris Chugthai
;; URL: https://github.com/farisachugthai
;;
;; This file is not part of GNU Emacs.

;;; Code:

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults material-theme))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package))) myPackages)


(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))



;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t)
;; hide the startup message

(load-theme 'gruvbox-dark-hard t)
;; load gruvbox

(global-linum-mode t)
;; enable line numbers globally 

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

;; (load-file (concat (file-name-directory load-file-name)
;;                     "core/core-load-paths.el"))

;; Don't close if i haven't saved customizations
(add-hook 'kill-emacs-query-functions
               'custom-prompt-customize-unsaved-options)

(require 'server)
(unless (server-running-p)
  (server-start))

(require 'goto-chg)

(global-set-key [(control ?.)] 'goto-last-change) (global-set-key [(control ?,)] 'goto-last-change-reverse)

(setq evil-shift-width 4)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(add-hook 'python-mode-hook 'jedi:setup)

(setq jedi:complete-on-dot t)                 ; optional

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

(add-to-list 'load-path "~/.emacs.d/elpa")

(add-to-list 'load-path "~/.emacs.d/viper")

(add-to-list 'load-path "~/.emacs.d/site-lisp")

(add-to-list 'load-path "~/.emacs.d/spacemacs")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruvbox))
 '(custom-safe-themes
   '("3da031b25828b115c6b50bb92a117f5c0bbd3d9d0e9ba5af3cd2cb9db80db1c2" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "a622aaf6377fe1cd14e4298497b7b2cae2efc9e0ce362dade3a58c16c89e089c" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" default))
 '(custom-theme-allow-multiple-selections t)
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-django elpy-module-autodoc elpy-module-sane-defaults))
 '(elpy-shell-display-buffer-after-send t)
 '(elpy-shell-echo-input-lines-head 30)
 '(elpy-shell-echo-input-lines-tail 30)
 '(font-use-system-font nil)
 '(inhibit-startup-screen t)
 '(ispell-check-comments nil)
 '(package-check-signature t)
 '(package-directory-list
   '("/usr/share/emacs/27.0.50/site-lisp/elpa" "/usr/share/emacs/site-lisp/elpa"))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(company ggtags with-editor magit pydoc rainbow-delimiters evil-magit org-evil lsp-python sphinx-doc elpy which-key gruvbox-theme ivy helm-pydoc kwin playerctl evil-org evil-surround evil-commentary better-defaults evil-python-movement evil-text-object-python visual-regexp-steroids conda helm-ag anaconda-mode tldr helm evil python yasnippet org))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#1d2021"))
 '(python-check-command "flake8")
 '(python-shell-completion-native-disabled-interpreters '("pypy"))
 '(pyvenv-virtualenvwrapper-python "~/miniconda/bin/python")
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 98 :width normal))))
 '(window-divider ((t (:foreground "DarkGoldenrod2")))))
