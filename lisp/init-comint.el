(use-package comint
  :bind ((:map comint-mode-map
	       ("C-c M-o" . de/clear-comint-buffer)))
  :config
  (defun de/clear-comint-buffer ()
    (interactive)
    (let ((comint-buffer-maximum-size 0))
      (comint-truncate-buffer))))
