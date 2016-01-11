;; via: http://d.hatena.ne.jp/tarao/20150221/1424518030
(when load-file-name
    (setq user-emacs-directory
          (file-name-directory load-file-name)))

;; el-get (https://github.com/dimitri/el-get)
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(setq-default el-get-dir (locate-user-emacs-file "el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; https://github.com/tarao/with-eval-after-load-feature-el
;; (el-get-bundle tarao/with-eval-after-load-feature-el)

;; exec-path-from-shell (https://github.com/purcell/exec-path-from-shell)
(el-get-bundle! exec-path-from-shell
  (exec-path-from-shell-initialize))

;; init-loader (https://github.com/emacs-jp/init-loader)
(el-get-bundle! init-loader
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load (locate-user-emacs-file "inits")))
