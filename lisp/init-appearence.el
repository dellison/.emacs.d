(use-package zenburn-theme
  :ensure t
  :if (display-graphic-p)
  :config
  (load-theme 'zenburn t)
  )

(use-package beacon
  :ensure t
  :config
  (setq beacon-color "#888888"
	beacon-blink-duration 0.2
	beacon-blink-when-focused t
	beacon-size 12)
  (beacon-mode 1))
