(use-package zenburn-theme
  :ensure t
  :if (display-graphic-p)
  :config
  ;;(load-theme 'zenburn t)
  )

(use-package solarized-theme
  :ensure t
  :config
  (setq solarized-scale-org-headlines nil
	solarized-use-variable-pitch nil)
  (load-theme ;;'solarized-gruvbox-light
   ;; 'solarized-selenized-white
   'solarized-light
   ))

(use-package beacon
  :ensure t
  :config
  (setq beacon-color "#888888"
	beacon-blink-duration 0.2
	beacon-blink-when-focused t
	beacon-size 12)
  (beacon-mode 1))
