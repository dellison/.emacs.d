(use-package eww
  :bind (("C-c W" . eww)))

(use-package restclient
  :ensure t
  :bind ((:map restclient-mode-map
	       (("C-c C-c" . restclient-http-send-current-stay-in-window))))
  :hook ((restclient-mode . yas-minor-mode-on)
	 ;;(restclient-mode . company-mode)
	 )
  :mode ("\\.http\\'" . restclient-mode)
  :config
  (add-to-list 'org-babel-load-languages '(restclient . t)))

;; (use-package company-restclient
;;   :ensure t
;;   :after company restclient
;;   :defines company-backends
;;   :config
;;   (add-to-list 'company-backends 'company-restclient))

(use-package ob-restclient
  :ensure t
  :after org restclient)

(use-package web-mode
  :ensure t)

(provide 'init-web)
