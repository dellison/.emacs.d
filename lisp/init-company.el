(use-package company
  :ensure t
  :bind (("M-/" . hippie-expand)
	 ("C-M-i" . company-complete))
  :init
  (setq company-idle-delay 0.5
	company-minimum-prefix-length 1
	company-require-match nil
	company-tooltip-align-annotations t
	company-tooltip-limit 12))

;; (use-package company-lsp
;;   :ensure t)
