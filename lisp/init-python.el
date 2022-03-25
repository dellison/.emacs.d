(use-package python
  :bind ((:map python-mode-map
	       ("S-SPC" . de/python-underscore)))
  :init
  (setq python-shell-interpreter "python3")
  :config
  (defun de/python-underscore ()
    (interactive)
    (insert "_")))

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
