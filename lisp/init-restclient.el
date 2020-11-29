(use-package restclient
  :ensure t
  :bind ((:map restclient-mode-map
	       (("C-c C-c" . restclient-http-send-current-stay-in-window))))
  :hook ((restclient-mode . yas-minor-mode-on)
	 (restclient-mode . company-mode))
  :mode ("\\.http\\'" . restclient-mode))

(use-package company-restclient
  :ensure t
  :after company restclient
  :defines company-backends
  :config
  (add-to-list 'company-backends 'company-restclient))

(use-package ob-restclient
  :ensure t
  :after restclient)
