(use-package magit
  :ensure t
  :bind (("C-c G" . magit-status))
  :init
  (setq magit-bind-magit-project-status nil))

(use-package forge
  :ensure t
  :after magit)
