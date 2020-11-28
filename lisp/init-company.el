(use-package company
  :ensure t
  :bind (("C-M-i" . company-complete)
	 ("M-/" . company-complete))
  :init
  (setq company-idle-delay 0
	company-minimum-prefix-length 1
	company-require-match nil
	company-tooltip-align-annotations t
	company-tooltip-limit 12))

;; (use-package company-lsp
;;   :ensure t
;;   :after company lsp
;;   :config
;;   (push 'company-lsp company-backends))
