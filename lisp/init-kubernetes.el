(use-package k8s-mode
  :ensure t)

(use-package kubernetes
  :ensure t
  :bind (("C-c K" . kubernetes-overview)
	 (:map kubernetes-overview-mode-map
	  ("g" . de/kubernetes-refresh)))
  :config
  (setq kubernetes-poll-frequency 3600
	kubernetes-redraw-frequency 3600))

(defun de/kubernetes-refresh (&optional verbose)
  (interactive "p")
  (kubernetes-refresh verbose)
  (when verbose
    (message "Refreshed kubernetes.")))

;; (use-package kubel
;;   :ensure t
;;   :bind (("C-c K" . kubel))
;;   :config
;;   (setq kubel-use-namespace-list 'on)
;;   )
