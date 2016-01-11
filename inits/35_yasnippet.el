
(el-get-bundle! yasnippet
  (yas-global-mode 1)
  ;; use "M-o" to expand, not "TAB"
  (define-key yas-minor-mode-map (kbd "M-o") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "TAB") nil))

;; via: https://github.com/syohex/dot_files/blob/master/emacs/init/yasnippet.el
(defun my-yas/perl-package-name ()
  (let ((file-path (file-name-sans-extension (buffer-file-name))))
    (if (string-match "lib/\\(.+\\)\\'" file-path)
        (replace-regexp-in-string "/" "::" (match-string 1 file-path))
      (file-name-nondirectory file-path))))
