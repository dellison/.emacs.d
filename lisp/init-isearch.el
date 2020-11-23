(use-package isearch
  :bind (("C-s" . isearch-forward-regexp)
	 ("C-r" . isearch-backward-regexp)
	 ("C-c /" . de/isearch-forward-flexibly)
	 ("C-c ?" . de/isearch-backward-flexibly)
	 (:map occur-mode-map
	  ("j" . next-line)
	  ("k" . previous-line)))
  :config
  (setq isearch-lax-whitespace t
	isearch-regexp-lax-whitespace t
	search-whitespace-regexp "[ \t\r\n_-]+")

  (defun de/isearch-forward-flexibly ()
    "incrementally search the buffer, but let SPC match anything"
    (interactive)
    (let ((search-whitespace-regexp ".*?"))
      (isearch-forward-regexp)))

  (defun de/isearch-backward-flexibly ()
    "incrementally search the buffer, but let SPC match anything"
    (interactive)
    (let ((search-whitespace-regexp ".*?"))
      (isearch-backward-regexp))))
