;; terraform!

;; can install tf language server from hashicorp with:
;; $ brew install hashicorp/tap/terraform-ls

(use-package terraform-mode
  :ensure t
  :mode (("\\.tf\\'" . terraform-mode))
  :hook ((terraform-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(terraform-mode "terraform-ls" "serve")))

(use-package terraform-doc
  :ensure t
  :after terraform-mode
  :bind (:map terraform-mode-map
	      ("C-c C-d" . terraform-doc)))

