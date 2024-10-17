(use-package json
  :after treesit
  :mode ("\\.json\\'" . json-ts-mode)
  :config
  (defalias 'json-mode 'json-ts-mode)
  (add-to-list 'treesit-language-source-alist
	       '(json "https://github.com/tree-sitter/tree-sitter-json")))
