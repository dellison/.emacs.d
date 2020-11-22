(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0
	company-minimum-prefix-length 1))

(use-package company-lsp
  :ensure t)
