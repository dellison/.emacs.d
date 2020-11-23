(use-package smex
  :ensure t)

(use-package counsel
  :ensure t

  :bind (("M-x" . counsel-M-x)
	 ("C-c gg" . counsel-git-grep))

  :config
  (ivy-mode 1)
  (setq counsel-find-file-at-point t
	ivy-format-function #'de/ivy-format-function
	ivy-height 13
	ivy-initial-inputs-alist '()
	ivy-use-selectable-prompt t)

  ;; written in the style of (kinda copied from) ivy-format-function-arrow
  (defun de/ivy-format-fn (cands)
    "Format candidate pairs in the minibuffer.
Point to the current match with an arrow -> and highlight its line."
    (ivy--format-function-generic
     (lambda (str)
       (ivy--add-face (concat " --> " str "\n") 'ivy-current-match))
     (lambda (str)
       (concat "     " str "\n"))
     cands
     ""))
  (defalias 'ivy-format-function-default 'de/ivy-format-fn)
  (defalias 'ido-completing-read 'ivy-completing-read))

(use-package counsel-tramp
  :ensure t)
