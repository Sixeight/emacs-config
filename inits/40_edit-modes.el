
;;; edit-modes

;; go-mode (https://github.com/dominikh/go-mode.el)
(el-get-bundle go-mode
  (require 'go-mode-autoloads))

;; typescript-mode
(el-get-bundle! typescript-mode
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode)))

;; tide for typescript-mode (https://github.com/ananthakumaran/tide)
(el-get-bundle ananthakumaran/tide
  (add-hook 'typescript-mode-hook
            (lambda ()
              (tide-setup)
              (flycheck-mode t)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode t)
              (company-mode-on))))

;; we-mode (https://github.com/fxbois/web-mode)
(el-get-bundle! 'web-mode
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (defcustom web-mode-engines-alist nil
    "engines"
    :type 'arrayp
    :group 'web-mode)
  (setq web-mode-engines-alist
        '(("template-toolkit" . "\\.html?\\'" )))

  (defun web-mode-element-close-and-indent ()
    (interactive)
    (web-mode-element-close)
    (indent-for-tab-command))

  (add-hook 'web-mode-hook
            '(lambda ()
               (setq web-mode-markup-indent-offset 2)
               (define-key web-mode-map (kbd "C-c /") 'web-mode-element-close-and-indent)
               (define-key web-mode-map (kbd "T") (smartchr '("T" "[%- `!!' %]" "[% `!!' %]"))))))


;; css/less/sass
(el-get-bundle css-mode)
(el-get-bundle less-css-mode)
(el-get-bundle scss-mode
  (add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode)))

;; js-mode
(el-get-bundle js2-mode
  (autoload 'js2-mode "js2-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.\\(js\\|json\\)$" . js2-mode)))

;; yaml-mode
(el-get-bundle yaml-mode
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; nginx-mode
(el-get-bundle nginx-mode
  (add-to-list 'auto-mode-alist '("\\.nginx.conf$" . nginx-mode)))

;; zsh
(add-to-list 'auto-mode-alist '("\\.zsh$" . sh-mode))

;; markdown
(el-get-bundle markdown-mode
  (autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))
