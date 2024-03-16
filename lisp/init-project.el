(use-package project
  :bind
  ("C-c ff" . project-find-file)
  :config
  (setq project-switch-commands
	'((project-find-file "Find file" "f")
	  (project-find-dir "Find directory" "d")
	  (project-compile "Compile" "c")
	  (magit-project-status "Magit" "g")
	  (project-shell "Shell" "s")
	  (project-eshell "Eshell" "e"))))
