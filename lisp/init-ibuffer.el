(use-package ibuffer
  :commands ibuffer

  :bind
  (("C-x C-b" . ibuffer)
   :map ibuffer-mode-map
   ("/ u" . ibuffer-filter-by-unsaved)
   ("M-o" . other-window)
   ("j" . ibuffer-forward-line)
   ("k" . ibuffer-backward-line)
   ("J" . ibuffer-jump-to-buffer)
   ("K" . ibuffer-do-kill-lines)
   ("U" . ibuffer-unmark-all)
   ("M-<" . de/ibuffer-beginning-of-buffer)
   ("M->" . de/ibuffer-end-of-buffer))

  :config
  (defun de/ibuffer-beginning-of-buffer ()
    (interactive)
    (beginning-of-buffer)
    (ibuffer-forward-line 2))
  (defun de/ibuffer-end-of-buffer ()
    (interactive)
    (end-of-buffer)
    (ibuffer-backward-line))
  (defun de/setup-ibuffer-filters ()
    ;; add an "unsaved" filter
    (define-ibuffer-filter unsaved
	"Toggle current view to only buffers which are unsaved."
      (:description "unsaved")
      (with-current-buffer buf
	(and buffer-file-name (buffer-modified-p)))))
  (add-hook 'ibuffer-hook #'de/setup-ibuffer-filters))
