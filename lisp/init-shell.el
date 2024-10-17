(use-package shell
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages '(shell . t)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
