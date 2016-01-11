
;; flycheck (https://github.com/flycheck/flycheck)

(el-get-bundle! flycheck
  (setq flycheck-highlighting-mode 'lines)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; なんか変な位置に表示されてしまう…
;; flycheck-pos-tip (https://github.com/flycheck/flycheck-pos-tip)
;; (el-get-bundle! flycheck-pos-tip
;;   (eval-after-load 'flycheck
;;     '(custom-set-variables
;;       '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

;; キーバインド
(add-hook
 'flycheck-mode-hook
 '(lambda ()
    (local-set-key (kbd "s-e") 'flycheck-next-error)
    (local-set-key (kbd "s-E") 'flycheck-previous-error)
    ))

;; 設定にドキュメント書くのつらい
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; elispのチェックにload-pathを考慮する
(setq-default flycheck-emacs-lisp-load-path 'inherit)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; 全てのエラーを表示
(setq flycheck-checker-error-threshold nil)
