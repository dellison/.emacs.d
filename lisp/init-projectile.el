(use-package projectile
  :ensure projectile
  :bind (:map projectile-mode-map
	 ("C-c P" . projectile-command-map))
  :init
  (setq projectile-use-git-grep t)
  :config
  (projectile-mode 1))

(use-package counsel-projectile
  :ensure t

  :config
  (global-set-key (kbd "C-c ff") #'counsel-projectile-find-file))
