(use-package lsp-mode
  ;; :ensure t
  :load-path ("/Users/q1450162/work/lsp-mode/" "/Users/q1450162/work/lsp-mode/clients/")
  :commands lsp lsp-deferred
  :init
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  :config
  (require 'lsp-modeline)
  (setq lsp-log-io t)
  (add-to-list 'lsp-file-watch-ignored "[/\\\\]vendor\\'"))

(use-package lsp-ui
  ;;:ensure t
  :after lsp-mode
  :load-path "/Users/q1450162/work/lsp-ui"
  :init
  (setq lsp-ui-sideline-show-diagnostics t)
  :commands lsp-ui-mode)
