(use-package treemacs
  :ensure t
  :bind (("C-c SPC" . treemacs)))

(use-package treemacs-evil
  :ensure t
  :after evil treemacs)

(use-package treemacs-magit
  :ensure t
  :after magit)
