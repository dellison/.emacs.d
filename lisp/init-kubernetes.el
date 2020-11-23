(use-package yaml-mode
  :ensure t
  :hook
  ((yaml-mode . lsp)
   (yaml-mode . flycheck-mode)
   (yaml-mode . company-mode))
  :config
  (require 'lsp-yaml)
  (setq lsp-yaml-schemas nil))

(use-package k8s-mode
  :ensure t)

(use-package kubernetes
  :ensure t)

(use-package kubel
  :ensure t
  :bind (("C-c K" . kubel)))
