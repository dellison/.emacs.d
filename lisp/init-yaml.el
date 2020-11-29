(use-package yaml-mode
  :ensure t
  :hook
  ((yaml-mode . lsp-deferred)
   (yaml-mode . flycheck-mode)
   (yaml-mode . company-mode))
  :init
  (setq lsp-log-io nil)
  :config
  (use-package lsp-yaml))
