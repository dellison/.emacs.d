(when (version< emacs-version "27")
  (load (concat user-emacs-directory "early-init.el")))

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")))

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; aeshetic things
(setq inhibit-startup-message t
      visible-bell t
      scroll-conservatively 1
      scroll-error-top-bottom t
      enable-recursive-minibuffers t
      echo-keystrokes 0.1
      backup-directory-alist '(("." . "~/backups"))
      ;gc-cons-threshold 20000000
      custom-file (concat user-emacs-directory "/.emacs-custom.el")
      disabled-command-function nil)
(setq-default indicate-unused-lines t)
(show-paren-mode 1)

(when (display-graphic-p)
  (blink-cursor-mode 0))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(load "init-org.el")
(load "init-dired.el")
(load "init-ibuffer.el")
(load "init-isearch.el")
(load "init-evil.el")
(load "init-keys.el")
(load "init-comint.el")
(load "init-eshell.el")
(load "init-pdf.el")

(load "init-appearence.el")
(load "init-mode-line.el")
(load "init-ivy.el")
(load "init-company.el")
(load "init-projectile.el")

(load "init-elisp.el")
(load "init-golang.el")
(load "init-python.el")

(load "init-docker.el")
(load "init-kubernetes.el")
(load "init-magit.el")
(load "init-terraform.el")
