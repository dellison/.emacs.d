(use-package python
  :init
  (setq python-shell-interpreter "python3"))

(use-package elpy
  :ensure t
  :defer t
  :init
  (setq elpy-rpc-python-command "python3")
  (advice-add 'python-mode :before 'elpy-enable)
  :hook ((python-mode . elpy-mode)
	 (elpy-mode . flycheck-mode)))

(use-package pyvenv
  :ensure t)

(use-package cython-mode
  :commands cython-mode
  :mode (("\\.pyx\\'" . cython-mode)))
