(use-package terraform-mode
  :ensure t
  :mode (("\\.tf\\'" . terraform-mode)))

(use-package company-terraform
  :ensure t
  :hook ((terraform-mode . company-terraform-init)
	 (terraform-mode . company-mode)))

(use-package terraform-doc
  :ensure t
  :after terraform-mode
  :bind (:map terraform-mode-map
	      ("C-c C-d" . terraform-doc)))

