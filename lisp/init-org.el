(use-package org
  :bind (("C-c c" . org-capture)
	 ("C-c l" . org-store-link)
	 ;; (:map org-agenda-mode
	 ;;  ("y" . org-agenda-todo-yesterday))
	 (:map org-mode-map
	  ("M-L" . org-shiftmetaright)
	  ("M-H" . org-shiftmetaleft))
	 )
  :hook ((org-mode . yas-minor-mode-on)
	 ;;(org-mode . yas-reload-all)
	 (org-mode . company-mode)
	 ;; (org-agenda-mode . hl-line-mode)
	 )
  :init
  (setq ;; org-agenda-files (list "~/org") ; (list "~/dorg")
        ;;   org-agenda-files (list "~/Dropbox/org")
	;; org-agenda-include-diary t
	org-format-latex-options '(:foreground "Black"
					       :background "White"
					       :scale 2.5
					       :matchers '("begin" "$1" "$" "$$" "\\(" "\\["))
	org-indent-indentation-per-level 1
	org-log-into-drawer t
	;;org-log-done-with-time nil
	
	org-refile-targets (list
			    (cons 'org-agenda-files '(:maxlevel . 4)))
	org-refile-use-outline-path nil
	org-refile-path-complete-in-steps nil)
  :config
  (setq org-edit-src-content-indentation 0))

;; (use-package org-babel
;;   :after org
;;   :config
;;   (setq ))

(use-package org-agenda
  :after org
  :bind (("C-c a" . org-agenda)
	 (:map org-agenda-mode-map
	  ("y" . org-agenda-todo-yesterday)
	  ("W" . org-agenda-open-link)))
  :init
  (setq org-agenda-files (list "~/Dropbox/org"))
  :config
  (setq ;;org-agenda-files (list "~/org")
	org-agenda-include-diary t
	org-agenda-span 'day)
  :hook
  ((org-agenda-mode . hl-line-mode))
  )

(use-package org-habit
  :after org
  :config
  (setq org-habit-graph-column 70)
  )

(use-package org-attach
  :after org)

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
	 ("C-c n d z" . de/org-roam-dailies-goto-zulily)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n I" . org-roam-node-insert-immediate)
	 ("C-c n n" . org-roam-node-find)
	 ("C-c n z" . de/org-roam-dailies-goto-zulily))
  :commands org-roam-node-insert org-roam-node-find org-roam-capture
  :after org
  :init
  (setq org-roam-directory (file-truename "~/Dropbox/org-roam")
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
                                 "#+title: %<%Y-%m-%d>\n"))
	  ("z" "zulily" entry
	   "* Standup/Status\n** Me\n** Nate\n** Supritha\n** Ramya\n** Jisun\n** Nischal\n* Meetings\n* Notes\n"
	   :target (file+head "Zulily_%<%Y%m%d>.org"
			      "#+title: Zulily Notes: %<%Y%m%d>\n#+filetags: zulily\n"
			      ))
	  ))
  :config
  (org-roam-db-autosync-mode)
  ;; (add-to-list 'org-agenda-files org-roam-directory)
  )

(defun de/org-roam-dailies-goto-zulily ()
  (interactive)
  (org-roam-dailies-goto-today "z"))

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

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

				  (:name "Work"
					 :category "Zulily")

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
					 :category "Reading"
					 :tag "spl")

				  (:name "Film & Things to Watch"
					 :todo "WATCH"
					 :category ("Film" "Scarecrow"))

				  (:name "Listening"
					 :todo "LISTEN")

				  (:name "Home"
					 :category "Home")

				  (:name "Emacs"
					 :category "Emacs"
					 :tag "emacs")

				  )
	org-super-agenda-unmatched-name "Other"
	org-super-agenda-hide-empty-groups t))

;;; (defun de/org-refile-here ())

(use-package evil-org
  :after evil org
  ; :commands evil-org-mode evil-org-
  :ensure t
  :hook ((org-mode-hook . evil-org-mode))
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))


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
