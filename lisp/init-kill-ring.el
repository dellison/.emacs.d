(use-package browse-kill-ring
  :ensure t
  :bind (("M-y" . browse-kill-ring)
	 :map browse-kill-ring-mode-map
	 ("j" . browse-kill-ring-forward)
	 ("k" . browse-kill-ring-previous)
	 ("n" . browse-kill-ring-forward)
	 ("p" . browse-kill-ring-previous)))
