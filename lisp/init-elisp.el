(load-library "init-lisps")

(use-package elisp-slime-nav
  :ensure t

  :bind (("C-c M-." . de/jump-to-elisp-definition))
  :config
  (defun de/jump-to-elisp-definition ()
    "See the elisp definition of something.

This is a weird way to do this, but switching to a temp buffer
and trying to slime-nav with nothing at point always prompts for
a symbol."
    (interactive)
    (with-temp-buffer
      (call-interactively #'elisp-slime-nav-find-elisp-thing-at-point))))

(defun de/elisp-mode-hook ()
  "hook for emacs lisp mode"
  (paredit-mode 1) ;; use paredit
  (elisp-slime-nav-mode 1)
  (eldoc-mode 1)
  (paredit-mode 1)
  (define-key evil-insert-state-local-map (kbd "S-SPC")
    (lambda () (interactive) (insert "-")))
  (define-key evil-emacs-state-local-map (kbd "S-SPC")
    (lambda () (interactive) (insert "-")))
  (define-key evil-normal-state-local-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)
  (turn-on-elisp-slime-nav-mode)
  (local-set-key (kbd "C-c C-j") 'imenu)
  (local-set-key (kbd "C-c eb") #'eval-buffer)
  ;; (if (fboundp 'helm)
  ;;     (local-set-key (kbd "C-M-i") 'helm-lisp-completion-at-point))
  (local-set-key (kbd "C-RET") 'de/evil-paredit-open-below))

(add-hook 'emacs-lisp-mode-hook 'de/elisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'de/lisps-mode-hook)

(add-hook 'minibuffer-setup-hook
	  (defun de/minibuffer-setup-hook ()
	    (local-set-key (kbd "S-SPC") (lambda () (interactive) (insert "-")))
	    (if (eq this-command 'eval-expression)
		(progn  ;; Setup paredit for elisp
		  (paredit-mode 1)
		  (paredit-open-round)))))
