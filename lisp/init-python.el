(use-package python

  :mode ("\\.py\\'" . python-ts-mode)
  :hook ((python-ts-mode . eglot-ensure))
  :init
  (setq python-shell-interpreter "python3")
  :config
  (add-to-list 'treesit-language-source-alist
  	       '(python "https://github.com/tree-sitter/tree-sitter-python")))

(use-package poetry
  :ensure t
  :after python)

(use-package pet
  :ensure t
  :hook (python-base-mode . de/pet-setup)
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10)
  :autoload pet-eglot-setup)

(defun de/pet-setup ()
  (pet-eglot-setup))
