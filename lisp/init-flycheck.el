(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :init
  :hook (flycheck-mode . flycheck-set-indication-mode)
  :config)
