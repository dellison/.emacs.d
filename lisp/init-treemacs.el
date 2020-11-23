(use-package treemacs
  :ensure t
  :bind (("C-c SPC" . treemacs)))

(use-package treemacs-evil
  :ensure t
  :after evil treemacs)

(use-package treemacs-magit
  :ensure t
  :after magit)

(use-package treemacs-projectile
  :ensure t
  :after projectile treemacs)
