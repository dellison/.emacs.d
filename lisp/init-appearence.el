(use-package solarized-theme
  :ensure t
  :init
  (setq solarized-use-variable-pitch nil
	solarized-scale-org-headlines nil
	solarized-scale-outline-headlines nil)
  :config
  ;; (mapc (lambda (face)
  ;; 	  (set-face-attribute face nil :foreground 'unspecified))
  ;; 	'(whitespace-tab))
  (load-theme 'solarized-light t)
  (set-face-attribute 'org-block-begin-line nil :underline nil)
  (set-face-attribute 'org-block-end-line nil :overline nil)
  (set-face-attribute 'org-block nil :background "#eee8d5")
  (setq org-fontify-quote-and-verse-blocks t))

(use-package beacon
  :ensure t
  :config
  (setq beacon-color "#888888"
	beacon-blink-duration 0.2
	beacon-blink-when-focused t
	beacon-size 12)
  (beacon-mode 1))

(defun de/maximize-frame (&optional frame)
  (interactive)
  (set-frame-parameter frame 'fullscreen 'maximized))

(de/maximize-frame) ;; start up maximized
