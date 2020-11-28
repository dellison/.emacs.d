
(setq gc-cons-threshold 16777216); 16mb

(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;;(set-frame-parameter nil 'fullscreen 'fullboth)

