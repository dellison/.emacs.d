(use-package restclient
  :ensure t
  :mode ("\\.http\\'" . restclient-mode)
  :bind ((:map restclient-mode-map
	       (("C-c C-c" . restclient-http-send-current-stay-in-window)))))

(use-package ob-restclient
  :ensure t
  :after restclient)
