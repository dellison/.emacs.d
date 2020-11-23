(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.01
	company-minimum-prefix-length 1
	company-tooltip-limit 20))

(use-package company-lsp
  :ensure t)
