(use-package go-mode
  :ensure t

  :hook ((go-mode . de/go-mode-hook)
	 (go-mode . lsp-deferred))

  :config
  (defun de/go-mode-hook ()
    (setq tab-width 4)
    (flycheck-mode t)
    (company-mode-on)
    (yas-minor-mode-on)
    (lsp-go-install-save-hooks))

  (setq gofmt-command "goimports"))

(use-package go-playground
  :ensure t)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package go-projectile
  :ensure t
  :config
  (setq go-projectile-tools-path (concat (expand-file-name user-emacs-directory) "/gotools")))
