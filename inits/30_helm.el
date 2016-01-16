
;; helm (https://github.com/emacs-helm/helm)

(require 'filecache)
(file-cache-add-directory-list '("~/"
                                 "~/.oh-my-zsh/custom"
                                 "~/.emacs.d/"
                                 "~/.emacs./inits/"
                                 ))

(el-get-bundle! helm
  (require 'helm-config)
  (require 'helm-files)
  (helm-migemo-mode 1)
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char))

(el-get-bundle helm-git-grep)
(el-get-bundle! helm-ls-git)
(el-get-bundle helm-ag)
(el-get-bundle helm-open-github)
;; helm-swoop (https://github.com/ShingoFukuyama/helm-swoop)
(el-get-bundle! helm-swoop
  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows nil)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color nil)
  (setq helm-swoop-move-to-line-cycle t)
  (setq helm-swoop-use-line-number-face t)
  (define-key isearch-mode-map (kbd "C-o") 'helm-swoop-from-isearch)
  (define-key helm-swoop-map (kbd "C-o") 'helm-multi-swoop-all-from-helm-swoop))
;; helm-source-ghq を利用するのにrequireする
(el-get-bundle! helm-ghq)

;; helm-miniの表示内容を変更する
(custom-set-variables
 '(helm-mini-default-sources '(
                               helm-source-buffers-list
                               helm-source-recentf
                               helm-source-file-cache
                               helm-source-files-in-current-dir
                               )))

(global-set-key (kbd "C-:") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c r") 'helm-ghq)
(global-set-key (kbd "C-c l") 'helm-ls-git-ls)
(global-set-key (kbd "C-'") 'helm-ls-git-ls)
(global-set-key (kbd "C-c p") 'helm-show-kill-ring)
(global-set-key (kbd "C-c g") 'helm-git-grep)
(global-set-key (kbd "C-c G") 'helm-git-grep-at-point)
(global-set-key (kbd "C-c f") 'helm-find-files)
(global-set-key (kbd "C-c C-f") 'helm-find-files)
(global-set-key (kbd "C-c ]") 'helm-etags-select)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-c s") 'helm-swoop)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c C-c") 'helm-resume)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-c O") 'helm-occur-from-isearch)
(define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur)
(global-set-key (kbd "C-c a") 'helm-do-ag-project-root)
(global-set-key (kbd "C-c A") 'helm-do-ag)
