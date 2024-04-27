(use-package emacs-lisp-mode
  :bind ((:map emacs-lisp-mode-map
	       ("C-c C-j" . imenu)
	       ("C-c C-b" . eval-buffer)
	       ("C-c e b" . eval-buffer)))
  :hook ((emacs-lisp-mode . de/lisps-mode-hook)
	 (emacs-lisp-mode . turn-on-eldoc-mode)))

(use-package elisp-slime-nav
  :ensure t

  :bind (("C-c M-." . de/jump-to-elisp-definition))
  :hook ((emacs-lisp-mode . elisp-slime-nav-mode))
  :config
  (defun de/jump-to-elisp-definition ()
    "See the elisp definition of something.

This is a weird way to do this, but switching to a temp buffer
and trying to slime-nav with nothing at point always prompts for
a symbol."
    (interactive)
    (with-temp-buffer
      (call-interactively #'elisp-slime-nav-find-elisp-thing-at-point))))

(add-hook 'minibuffer-setup-hook
	  (defun de/minibuffer-setup-hook ()
	    (local-set-key (kbd "S-SPC") (lambda () (interactive) (insert "-")))
	    (if (eq this-command 'eval-expression)
		(progn  ;; Setup paredit for elisp
		  (paredit-mode 1)
		  (paredit-open-round)))))
