(use-package python
  :mode ("\\.py\\'" . python-ts-mode)
  :hook ((python-ts-mode . eglot-ensure))
  :init
  (setq python-shell-interpreter "python3")
  :config
  (add-to-list 'treesit-language-source-alist
  	       '(python "https://github.com/tree-sitter/tree-sitter-python"))
  )

(use-package poetry
  :ensure t
  :after python)

(use-package pyvenv
  :ensure t
  :after python)

(use-package auto-virtualenv
  :ensure t
  :after pyvenv
  :hook ((python-mode . auto-virtualenv-set-virtualenv)
	 (projectile-after-switch-project auto-virtualenv-set-virtualenv)))
