(global-set-key "\C-w" #'backward-kill-word)
(global-set-key (kbd "RET") #'newline-and-indent)
(global-set-key (kbd "C-x C-k") #'kill-region)
(global-set-key (kbd "C-c gr") #'igrep)
(global-set-key (kbd "C-c rg") (defun de/recursive-igrep ()
				 (interactive)
				 (let ((igrep-options "-R"))
				   (call-interactively #'igrep))))
(global-set-key (kbd "C-c sw") #'de/swap-windows)
(global-set-key (kbd "C-c dc") #'describe-char)
(global-set-key (kbd "C-c rr") #'replace-rectangle)
(global-set-key (kbd "C-c es") #'eshell)
(global-set-key (kbd "C-c tl") #'toggle-truncate-lines)
(global-set-key (kbd "C-c wc") #'count-words)
(global-set-key (kbd "C-c d RET") 'de/indent-to)
;; (global-set-key (kbd "C-c lw") 'toggle-truncate-lines)
;;    - "line wrap" mnemonic too
(global-set-key (kbd "C-c ws") #'whitespace-mode)
(global-set-key (kbd "C-c M-.") #'de/jump-to-elisp-definition)

(global-set-key (kbd "C-c q") #'quit-window)

(global-set-key "\C-ha" #'apropos) ; search for all symbols by default (instead of only commands)
(global-set-key (kbd "C-h c") #'apropos-command)  ; previously describe-key-briefly

(global-set-key (kbd "C-h C-f") #'describe-function)
(global-set-key (kbd "C-h C-v") #'apropos-variable)


(global-set-key (kbd "\C-x \C-b") #'ibuffer)
(global-set-key (kbd "\C-x\C-m") #'execute-extended-command) ;; per Steve Yegge's advice

(global-set-key (kbd "M-o") #'other-window)

(defalias 'qrr 'query-replace-regexp)
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'wc 'count-words)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun beginning-of-line-or-indentation ()
  "Moves the cursor to the beginning of the line if at or before the indentation.
Otherwise, moves to the beginning of the line."
  (interactive)
  (cond ((= (save-excursion (beginning-of-line) (point)) (point))
	 (back-to-indentation))
	((>= (save-excursion (back-to-indentation) (point)) (point))
	 (beginning-of-line))
	((< (save-excursion (back-to-indentation) (point)) (point))
	 (back-to-indentation))))
(global-set-key "\C-a" 'beginning-of-line-or-indentation)

(global-set-key (kbd "M-j") (defun de/join-line ()
			      (interactive)
			      (save-excursion (join-line -1))))

(defun fast-move-down ()
  (interactive)
  (next-line 5))

(defun fast-move-up ()
  (interactive)
  (previous-line 5))

(defun scroll-forward-1 ()
  (interactive)
  (scroll-up 1)
  (next-line 1))

(defun scroll-back-1 ()
  (interactive)
  (scroll-down 1)
  (previous-line 1))

;; (global-set-key (kbd "C-S-n") #'fast-move-down)
;; (global-set-key (kbd "C-S-p") #'fast-move-up)

(global-set-key (kbd "C-S-n") #'scroll-forward-1)
(global-set-key (kbd "C-S-p") #'scroll-back-1)

(define-key occur-mode-map (kbd "v") #'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") #'next-line)
(define-key occur-mode-map (kbd "p") #'previous-line)

(defun google-search (query)
  "Search for something on Google."
  (interactive "sSearch Google for: ")
  (browse-url (format "https://www.google.com/#q=%s"
		      (replace-regexp-in-string " +" "\+" query))))
(global-set-key (kbd "C-c go") 'google-search)

(global-set-key (kbd "C-c de") #'de/emacs-file)
(defun de/emacs-file ()
  (interactive)
  (project-switch-project user-emacs-directory))

(when (fboundp 'evil-mode)
  (defun de/save-buffer-and-normal-state ()
    "save buffer, normal state"
    (interactive)
    (save-buffer)
    (evil-normal-state 1))
  (global-set-key (kbd "C-x C-s") #'de/save-buffer-and-normal-state)
  (define-key evil-insert-state-map (kbd "C-x C-s") #'de/save-buffer-and-normal-state))

(defun de/toggle-window-split ()
  "Toggle between a horizontal and vertical arrangement of two windows.
Only works if there are exactly two windows active."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))
    (message "You must have two windows to toggle them!")))
(global-set-key (kbd "C-x |") 'de/toggle-window-split)
(global-set-key (kbd "C-c |") 'de/toggle-window-split)

(defun de/swap-windows ()
  "If you have 2 windows, it swaps them. (from Steve Yegge)"
  (interactive)
  (cond ((not (= (count-windows) 2))(message "You need exactly 2 windows to do this."))
	(t
	 (let* ((w1 (nth 0 (window-list)))
		(w2 (nth 1 (window-list)))
		(b1 (window-buffer w1))
		(b2 (window-buffer w2))
		(s1 (window-start w1))
		(s2 (window-start w2)))
	   (set-window-buffer w1 b2)
	   (set-window-buffer w2 b1)
	   (set-window-start w1 s2)
	   (set-window-start w2 s1)))))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))
