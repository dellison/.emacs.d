(use-package org
  :bind (("C-c c" . org-capture)
	 ("C-c l" . org-store-link)
	 ;; (:map org-agenda-mode
	 ;;  ("y" . org-agenda-todo-yesterday))
	 )
  :hook ((org-mode . yas-minor-mode-on)
	 (org-mode . de/org-mode-setup)
	 ;;(org-mode . yas-reload-all)
	 ;; (org-agenda-mode . hl-line-mode)
	 )
  :init
  (setq ;; org-agenda-files (list "~/org") ; (list "~/dorg")
	;; org-agenda-include-diary t
	org-format-latex-options '(:foreground "Black"
					       :background "White"
					       :scale 2.5
					       :matchers '("begin" "$1" "$" "$$" "\\(" "\\["))
	org-indent-indentation-per-level 1
	org-log-into-drawer t
	org-log-states-order-reversed nil
	;;org-log-done-with-time nil
	
	org-refile-targets (list
			    (cons 'org-agenda-files '(:maxlevel . 4)))
	org-refile-use-outline-path nil
	org-refile-path-complete-in-steps nil
	org-tags-column -80)
  :config
  (setq org-edit-src-content-indentation 0)

  (setq org-columns-summary-types nil)
  (add-to-list 'org-columns-summary-types
	       '("count" . de/org-count-summary-type-function))

  (add-to-list 'org-columns-summary-types
	       '("unique" . de/org-unique-summary-type-function))
  :autoload 'org-columns-summary-types)

(defun de/org-count-summary-type-function (vals format-str)
  (format (or format-str "\*Count: %s\*")
	  (length (seq-filter
		   (lambda (x)
		     (not (null x)))
		   vals))))

(defun de/org-unique-summary-type-function (vals format-str)
  (format (or format-str "*Unique: %s*")
	  (length
	   (seq-uniq
	    (seq-filter
	     (lambda (x) (not (null x)))
	     vals)))))

(defun de/org-mode-setup ()
  (setq fill-column 80))

(use-package ob ;; org-babel
  :after org
  :config
  (require 'ob-shell))

(use-package org-agenda
  :after org
  :bind (("C-c a" . org-agenda)
	 (:map org-agenda-mode-map
	  ("y" . org-agenda-todo-yesterday)))
  :config
  (setq org-agenda-files (list "~/org")
	org-agenda-include-diary t
	org-agenda-span 'day
	org-agenda-insert-diary-extract-time t
	org-agenda-remove-times-when-in-prefix nil
	org-agenda-timegrid-use-ampm t)
  :hook
  ((org-agenda-mode . hl-line-mode))
  )

(use-package org-habit
  :after org
  :config
  (setq org-habit-graph-column 80
	org-habit-show-habits-only-for-today nil)
  )

(use-package org-attach
  :after org
  :init
  (setq org-attach-id-dir "org-attachments"))

(use-package org-capture
  :after org)

(use-package org-journal
  :ensure t
  :defer t
  :after org-capture
  :bind ("C-c j j" . org-journal-new-entry)
  :init
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%A, %d %B %Y"
	org-journal-file-format "Journal-%Y.%m.%d.org"
	;; org-journal-file-header "#+STARTUP: indent"
	org-journal-file-type 'daily
	org-journal-enable-agenda-integration t))

(use-package org-protocol
    :after org-capture
    :config
    (add-to-list 'org-capture-templates
		 '("c" "Capture" entry (file "Capture.org")
		   "* %?\n\n%U"))
    (add-to-list 'org-capture-templates
		 '("p" "Protocol" entry (file "Capture.org")
		   "* %:description ([[%:link][link]])\n%U\n\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"))
    (add-to-list 'org-capture-templates
		 '("l" "Link" entry
		   (file "Capture.org")
		   "* %a\n%U\n%?"))
    (add-to-list 'org-capture-templates
		 '("S" "Movies from Scarecrow Video" "entry" (file "Scarecrow.org")
		   ("* Movies from Scarecrow [/]
DEADLINE: %^t
- [ ] %?")))
    )

(use-package org-roam
  :ensure t
  :defer t
  :bind (("C-c n c" . org-roam-capture)
	 ("C-c n d c" . org-roam-dailies-capture-today)
	 ("C-c n d ." . org-roam-dailies-goto-today)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n n" . org-roam-node-find)
	 ("C-c M-<" . org-roam-dailies-goto-previous-note)
	 ("C-c M->" . org-roam-dailies-goto-next-note)
	 )
  :commands org-roam-node-insert org-roam-node-find org-roam-capture
  :after org
  :init
  (setq org-roam-directory (file-truename "~/org-roam")
	org-roam-capture-templates
	'(("d" "default" plain "%?" :target
	   (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
")
	   :unnarrowed t)
	  ("t" "notes on a text" plain "%?\n* Main Argument\n* Supporting Arguments\n* Subjects and Sites\n* Sources\n* Methods\n* Scholarly Debate\n* Terms & Themes\n* Questions\n* Notes\n"
	   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
	   :unarrowed t)

	  ("n" "notes on a novel/short story" plain "%?\n* Setting* Plot Summary\n* Characters\n* Themes\n* Questions\n* Notes\n"
	   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
	   :unarrowed t)
	  
				      )

	org-roam-dailies-directory "daily/"
	org-roam-dailies-capture-templates
	'(("d" "default" entry
              "* %^{Title} %U\n%?"
              :target (file+head "%<%Y-%m-%d>.org"
                                 "#+title: %<%Y-%m-%d>\n"))))
  :config
  (org-roam-db-autosync-mode)
  ;;(add-to-list 'org-agenda-files org-roam-directory)
  )

(use-package org-noter
  :ensure t
  :after org
  :config
  (org-noter-enable-org-roam-integration))

(use-package org-super-agenda
  :ensure t
  :defer t
  :after org-agenda
  :init
  (org-super-agenda-mode 1)
  :config
  (setq org-super-agenda-groups '(
				  (:name "___Schedule___"
					 :time-grid t
					 :category "Diary")
				  (:name "🐈 Sylvia"
					 :tag "sylvia")

				  ;; SPL
				  (:name "!!! Overdue at the Library !!!"
					 :and (:tag "spl" :deadline past))
				  (:name "Due today at the library!"
					 :and (:tag "spl" :deadline today))

				  ;; Scarecrow
				  (:name "!!! Overdue at Scarecrow !!!"
					 :and (:tag "scarecrow" :deadline past))
				  (:name "Due today at Scarecrow!"
					 :and (:tag "spl" :deadline today))

				  (:name "Important!"
					 :tag ("bills" "sylvia")
					 :category "Finance")
				  
				  (:name "Socializing & Correspondence"
					 :category "Social")

				  ;; todo book section

				  ;; Yale "Theory of Literature" Course
				  (:name "'Theory of Literature' Course"
					 :tag "engl300")

				  (:name "Reading"
					 :todo "READ"
					 :category "Reading")

				  (:name "Film & Things to Watch"
					 :todo "WATCH"
					 :category ("Film" "Scarecrow"))

				  (:name "Listening"
					 :todo "LISTEN")

				  ;; (:name "Home"
				  ;; 	 :file-path "Home")

				  (:name "Emacs"
					 :category "Emacs"
					 :tag "emacs")

				  )
	org-super-agenda-unmatched-name "Other"
	org-super-agenda-hide-empty-groups t))

(defun de/org-refile-here (&optional arg default buffer rfloc msg)
  (interactive)
  (let ((org-refile-targets '((buffer-file-name :maxlevel . 4))))
    (org-refile arg default buffer rfloc msg)))

;; (use-package evil-org
;;   :after evil org
;;   ; :commands evil-org-mode evil-org-
;;   :ensure t
;;   :hook ((org-mode . evil-org-mode))
;;   :bind ((:map org-mode-map
;; 	  ("M-o" . nil)))
;;   :config
;;   (evil-define-key 'normal 'evil-org-mode
;;     (kbd "O") nil
;;     (kbd "M-o") nil)
;;   (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
;;   (require 'evil-org-agenda)
;;   (evil-org-agenda-set-keys))


(use-package reftex
  :init
  (setq reftex-default-bibliography '("~/org/ref/references.bib"
				      )
	reftex-plug-into-AUCTeX t))



(use-package org-ref
  :ensure t
  :init
  (setq reftex-default-bibliography  "~/org/ref/references.bib"
	org-ref-default-bibliography '("~/org/ref/references.bib")
	org-ref-pdf-directory "~/org/ref/pdf/")
  :config)

(use-package ivy-bibtex
  :ensure t
  :after org-ref
  :config
  (ivy-set-display-transformer
   'org-ref-ivy-insert-cite-link
   'ivy-bibtex-display-transformer))
