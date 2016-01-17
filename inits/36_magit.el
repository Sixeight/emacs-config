
;; magit (https://github.com/magit/magit)
(el-get-bundle magit
  (global-set-key (kbd "C-x g") 'magit-status))

;; git-modes (https://github.com/magit/git-modes)
(el-get-bundle! magit/git-modes)
