(use-package org
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c l" . org-store-link))
  :init
  (setq org-agenda-files (list "~/dorg")
	org-format-latex-options '(:foreground "Black"
				   :background "White"
				   :scale 2.5
				   :matchers '("begin" "$1" "$" "$$" "\\(" "\\["))
	org-indent-indentation-per-level 1)
  :config
  (use-package org-attach)
  (use-package org-protocol))

(use-package evil-org
  :after evil org
  ; :commands evil-org-mode evil-org-
  :ensure t
  :hook ((org-mode-hook . evil-org-mode))
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

