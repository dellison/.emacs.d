(use-package eshell
  :hook ((eshell-mode . eldoc-mode))
  :config
  (setq eshell-where-to-jump 'begin
	eshell-review-quick-commands nil
	ehell-smart-space-goes-to-end t))
