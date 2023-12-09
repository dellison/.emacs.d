
(setq insert-directory-program "gls")

(use-package jinja2-mode
  :ensure t)


(use-package vterm
  :ensure t)

(use-package ekg
  :ensure t
  :bind (("C-c k k" . ekg-capture)
	 ("C-c k ." . ekg-show-notes-for-today)
	 ("C-c k u" . ekg-capture-url))
  :config
  (setq ekg-db-file "~/Dropbox/ekg-new/ekg.db")
  (require 'emacsql)
  (require 'emacsql-sqlite))

(defun de/ekg-capture-zulily ()
  (interactive)
  (ekg-capture))

(provide 'init-site)
