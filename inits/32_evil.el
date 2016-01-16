
;; evil

;; 初期設定
(setq-default evil-want-C-u-scroll t
              evil-auto-indent t
              evil-shift-width 2
              evil-cross-lines nil
              evil-echo-state nil
              evil-want-C-i-jump t
              evil-want-fine-undo t
              evil-want-C-w-in-emacs-state t
              evil-search-module 'evil-search
              evil-ex-search-vim-style-regexp t)

(el-get-bundle evil
  ;; esc quits (http://wikemacs.org/wiki/Evil)
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  ;; normal state
  (define-key evil-normal-state-map (kbd "C-h") 'backward-char)
  (define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-normal-state-map (kbd "s-i") 'evil-indent-line)
  (define-key evil-normal-state-map (kbd "C-a") 'back-to-indentation)
  (define-key evil-normal-state-map (kbd "C-w DEL") 'windmove-left)
  (define-key evil-normal-state-map (kbd "C-w C-l") 'windmove-right)
  (define-key evil-normal-state-map (kbd "C-w C-j") 'windmove-down)
  (define-key evil-normal-state-map (kbd "C-w C-k") 'windmove-up)
  (define-key evil-normal-state-map (kbd "<C-return>") 'evil-ex-nohighlight)
  (defun find-tag-next ()
    (interactive)
    (find-tag last-tag t))
  (define-key evil-normal-state-map (kbd "C-}") 'find-tag-next)
  ;; for tab
  (define-key evil-normal-state-map (kbd "g n") 'elscreen-create)
  (define-key evil-normal-state-map (kbd "g h") 'elscreen-previous)
  (define-key evil-normal-state-map (kbd "g l") 'elscreen-next)
  (define-key evil-normal-state-map (kbd "s-w") 'elscreen-kill)
  (define-key evil-normal-state-map (kbd "g-o") 'elscreen-kill-others)
  (define-key evil-normal-state-map (kbd "g 0") 'elscreen-jump-0)
  (define-key evil-normal-state-map (kbd "g 1") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 2") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 3") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 4") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 5") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 6") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 7") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 8") 'elscreen-jump)
  (define-key evil-normal-state-map (kbd "g 4") 'elscreen-jump-9)
  ;; insert state
  (define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'delete-backward-char)
  (define-key evil-insert-state-map (kbd "C-p") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-n") 'next-line)
  (define-key evil-insert-state-map (kbd "C-a") 'back-to-indentation)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-d") 'delete-forward-char)
  (define-key evil-insert-state-map (kbd "C-k") 'kill-line)

  ;; via: http://d.hatena.ne.jp/tarao/20130304/evil_config
  (defun evil-swap-key (map key1 key2)
    ;; MAP中のKEY1とKEY2を入れ替え
    "Swap KEY1 and KEY2 in MAP."
    (let ((def1 (lookup-key map key1))
          (def2 (lookup-key map key2)))
      (define-key map key1 def2)
      (define-key map key2 def1)))
  (evil-swap-key evil-motion-state-map "j" "gj")
  (evil-swap-key evil-motion-state-map "k" "gk")

  ;; visual stateでの選択してもクリップボードには貼り付けない
  (fset 'evil-visual-update-x-selection 'ignore)

  ;; enable evil
  (evil-mode 1))

;; evil-escape (https://github.com/syl20bnr/evil-escape)
(el-get-bundle! evil-escape
  (evil-escape-mode 1))

;; evil-numbers (https://github.com/cofi/evil-numbers)
(el-get-bundle! evil-numbers
  (global-set-key (kbd "C-+") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C--") 'evil-numbers/dec-at-pt))

;; via: http://d.hatena.ne.jp/tarao/20130304/evil_config
;; (el-get-bundle tarao/elisp :features (mode-line-color))
;; (el-get-bundle tarao/evil-plugins :features (evil-mode-line))

;; evil-surround (https://github.com/timcharper/evil-surround)
(el-get-bundle! evil-surround
  (global-evil-surround-mode 1))

;; evil-snipe (https://github.com/hlissner/evil-snipe)
(el-get-bundle! evil-snipe
  (evil-snipe-override-mode 1))

;; evil-jumper (https://github.com/bling/evil-jumper)
(el-get-bundle! evil-jumper
  ;; (setq evil-jumper-auto-center t)
  (evil-jumper-mode  1))

;; キーバインドで困ってない
;; evil-tabs (https://github.com/krisajenkins/evil-tabs)
;; (el-get-bundle! evil-tabs
;;   (global-evil-tabs-mode t))

;; normal stateに移行するときにIMEをオフにする
;; via: http://ichiroc.hatenablog.com/entry/2013/09/06/075832
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")
(add-hook 'evil-normal-state-entry-hook
          '(lambda ()
             (mac-toggle-input-method nil)))
