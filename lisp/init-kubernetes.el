(use-package k8s-mode
  :ensure t)

(use-package kubernetes
  :ensure t
  :bind (("C-c K" . kubernetes-overview)))

;; (use-package kubel
;;   :ensure t
;;   :bind (("C-c K" . kubel)))
