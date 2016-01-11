
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren-style nil)
             (setq ruby-deep-indent-paren nil)
             (setq ruby-insert-encoding-magic-comment nil)))

;; ruby-block
(el-get-bundle! ruby-block
  (setq ruby-block-highlight-toggle t))

(el-get-bundle! rbenv
  (setq rbenv-show-active-ruby-in-modeline nil)
  (global-rbenv-mode))

;; flycheck and smartparens
(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'smartparens-mode)
(add-hook 'ruby-mode-hook 'ruby-block-mode)
