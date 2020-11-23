(use-package restclient
  :ensure t
  :bind ((:map restclient-mode-map
	       (("C-c C-c" . restclient-http-send-current-stay-in-window))))
  :hook (restclient-mode . yas-minor-mode-on)
  :mode ("\\.http\\'" . restclient-mode)
  )

(use-package ob-restclient
  :ensure t
  :after restclient)
