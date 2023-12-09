(require 'request)

(defun zulily/es-doc-buffer (buf-name)
  (let ((buf (get-buffer-create (format "*ES document: %s*" buf-name))))
    (with-current-buffer buf
      (json-mode))
    buf))

(defun zulily/es-index-mappings-buffer (buf-name)
  (let ((buf (get-buffer-create (format "*ES index mappings: %s*" buf-name))))
    (with-current-buffer buf
      (json-mode))
    buf))

(defun zulily/es-index-settings-buffer (buf-name)
  (let ((buf (get-buffer-create (format "*ES index mappings: %s*" buf-name))))
    (with-current-buffer buf
      (json-mode))
    buf))

(defun zulily/ml-elasticsearch-get-doc (es-index es-doc-id)
  (interactive "Mindex: \nM_id: ")
  (de/elasticsearch-es-get-doc "http://search-es.ml.aws.z8s.io" 9200 es-index es-doc-id))

(defun zulily/ml-elasticsearch-get-index-mappings (es-index)
  (interactive "Mindex: ")
  (de/elasticsearch-es-get-index-mappings "http://search-es.ml.aws.z8s.io" 9200 es-index))

(defun de/elasticsearch-es-get-index-mappings (es-url es-port es-index)
  (interactive)
  (let* ((endpoint-url (format "%s:%d/%s/_mapping" es-url es-port es-index))
	 (buf (zulily/es-index-mappings-buffer endpoint-url)))
    (message "buf is %s" buf)
    (request endpoint-url
      :type "GET"
      :success
      (cl-function
       (lambda (&key data error-thrown symbol-status response &allow-other-keys)
	 (message "data is %s" data)
	 (message "current buffer is %s" (current-buffer))
	 (with-current-buffer (zulily/es-index-mappings-buffer (format "%s:%d/%s/_mapping" es-url es-port es-index))
	   (insert data)
	   (shell-command-on-region (point-min) (point-max) "jq" (current-buffer))))))))


(defun de/elasticsearch-es-get-doc (es-url es-port es-index es-doc-id)
  (interactive)
  (let ((endpoint-url (format "%s:%d/%s/_doc/%s" es-url es-port es-index es-doc-id)))
    (request endpoint-url
      :type "GET"
      :success
      (cl-function
       (lambda (&key data error-thrown symbol-status response &allow-other-keys)
	 (with-current-buffer (zulily/es-index-mappings-buffer endpoint-url)
	   (insert data)
	   (shell-command-on-region (point-min) (point-max) "jq" (current-buffer))))))))
