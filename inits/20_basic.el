
;; Emacsサーバー
(require 'server)
(unless (server-running-p)
        (server-start))

;; default encodingをutf-8に変更
(set-default-coding-systems 'utf-8)

;; 日本語
(setq current-language-environment "Japanese")

;; テーマより先に読み込まないとエラー
;; elscreen (https://github.com/knu/elscreen)
(el-get-bundle! elscreen
  (setq elscreen-tab-display-kill-screen nil)
  (setq elscreen-tab-display-control nil)
  (set-face-background 'elscreen-tab-background-face "#222222")
  (set-face-background 'elscreen-tab-current-screen-face "#888888")
  (set-face-attribute 'elscreen-tab-other-screen-face nil
                      :background "#222222"
                      :foreground "#888888"
                      :underline nil)
  (elscreen-start))

;; テーマ
;; material (https://github.com/cpaulik/emacs-material-theme)
(el-get-bundle cpaulik/emacs-material-theme
  (require 'material-theme)
  (load-theme 'material t))

;; regionの色
(set-face-background 'region "tan4")

;; font
(set-face-attribute 'default nil
                    :family "Monaco"
                    :height 136)

;; 行間
(setq-default line-spacing 0.05)

;;windowの設定
(setq default-frame-alist
      (append (list
               '(width . 208)
               '(height . 52)
               '(top . 0)
               '(left . 0))
              default-frame-alist))

;; 背景を半透明にする
(if window-system
    (set-frame-parameter nil 'alpha 95))

;; 画面最大化 (nativeのフルスクリーン使わない)
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "<s-return>") 'toggle-frame-fullscreen)

;; 起動時に表示されるメッセージ, *scratch*バッファのメッセージ等を表示しない
(setq inhibit-startup-message t
      inhibit-startup-screen t
      initial-scratch-message nil)

;;;;;; キーバインド ;;;;;;

;; C-h を削除にあてる (evilの設定に書いてる)
;; (global-set-key (kbd "C-h") 'delete-backward-char)

;; コメント/コメント解除
(global-set-key (kbd "s-/") 'comment-dwim)

;; MinibufferでもC-hを有効にする
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; コントロールキーをシステムに取られないようにする
(when (eq system-type 'darwin)
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  (setq mac-pass-option-to-system nil))

;;;;;;;;;;

;;;GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; status-barにカーソルのcolumn表示(4,29とか)
(column-number-mode t)

;;; status-barに時間表示
(require 'time)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '(month "/" day " " 24-hours ":" minutes " "))
(display-time-mode 1)

;; ファイル名補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; ソースコードに色を付ける
(global-font-lock-mode t)

;; デフォルトタブ幅4, タブはスペースを挿入
(setq-default tab-width 4 indent-tabs-mode nil)

;; kill-lineで行末の改行文字も削除
(setq kill-whole-line t)

;; 対応する括弧を光らせる
(require 'paren)
(show-paren-mode 1)
(setq show-paren-delay 0.5)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background "#385056" :foreground nil
                    :underline nil :weight 'normal)
;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; 画面チカチカさせない
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;;; yes-noをy-nに置き換え
(fset 'yes-or-no-p 'y-or-n-p)

;; C-mで改行してインデント
(global-set-key (kbd "C-m") 'newline-and-indent)

;; 行末の変なスペース強調
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; コマンド履歴などを覚えておく
(el-get-bundle! session
  (add-hook 'after-init-hook 'session-initialize))

;; yank した文字列をハイライト表示
(when window-system
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
	(overlay-put ol 'face 'highlight)
	(sit-for 0.5)
	(delete-overlay ol)))))

;; kill-ringの保存件数を増やす
(setq kill-ring-max 1000)

;;ログの記録行数を増やす
(setq message-log-max 10000)

;; recentf
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 10000000)
(setq recentf-exclude
      (append recentf-exclude
              '("/.emacs.d/el-get/" "~$" "/.autosaves/"
                "/emacs.d/elpa/" "/emacs.d/url/"
                "/.emacs.d/.recentf"
                "/.emacs.d/company-statistics-cache.el")))

(setq recentf-auto-cleanup 'never)
;; 30秒毎に.recentfを保存する
;; (run-with-idle-timer 30 t 'recentf-save-list)
(el-get-bundle! recentf-ext)

;; kill-ring に同じ内容の文字列を複数入れない
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))

;; スクロールバーは表示しない
(scroll-bar-mode -1)

;; ツールバーを非表示にする
(tool-bar-mode -1)

;; メニューバーにファイルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 選択範囲を表示する
(setq transient-mark-mode t)

;; 範囲選択中にバックスペースで選択範囲を削除する
(delete-selection-mode t)

;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;; 行番号を(常に)表示する
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%4d ")
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; ファイルの末尾には必ず改行をいれる
(setq require-final-newline t)

;; 保存時に行末の空白を削除する
(add-hook 'before-save-hook
          'delete-trailing-whitespace)

;; Mac環境でのバックスラッシュ入力対策
(define-key global-map [?\¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;; 単語境界に_は含めない
(modify-syntax-entry ?_ "w" (standard-syntax-table))

;; 外部編集のあったファイルを読みなおす
(global-auto-revert-mode 1)

;; symlinkは必ず追いかける
(setq vc-follow-symlinks t)

;; 画面外の文字を折り返さない
(setq truncate-lines t)
(setq truncate-partial-width-windows t)

;; オートセーブファイルを作らない
(setq auto-save-default nil)

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; バックアップファイルを作らない
(setq make-backup-files nil)

;; wdired (dired上で直接編集できる)
(require 'dired)
(require 'wdired)
(define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)

;; 同名のファイルをうまく扱う
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-min-dir-content 1)

;;; スクロールを一行ずつにする
;; (setq scroll-step 1)
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; トラックパッドのスクロール量を調整
(defun scroll-down-with-lines () "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines () "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)

;; コンパイル前に全部保存
(setq compilation-ask-about-save nil)

;; git-gutter-fringe
(el-get-bundle! git-gutter-fringe
  (global-git-gutter-mode))

;; via: http://blog.shibayu36.org/entry/2013/12/30/190354

;; expand-region (https://github.com/magnars/expand-region.el)
(el-get-bundle! expand-region
  (global-set-key (kbd "C-,") 'er/expand-region)
  (global-set-key (kbd "C-M-,") 'er/contract-region))

;; multiple-cursors (https://github.com/magnars/multiple-cursors.el)
(el-get-bundle multiple-cursors
  (global-set-key (kbd "s-d") 'mc/mark-next-like-this)
  (global-set-key (kbd "s-D") 'mc/mark-previous-like-this))

;;; 選択範囲をisearch
(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))

;; highlight-symbol (https://github.com/nschum/highlight-symbol.el)
(el-get-bundle! highlight-symbol
  (setq highlight-symbol-idle-delay 0.5)
  (global-set-key (kbd "C-S-w") 'highlight-symbol)
  (global-set-key (kbd "<f3>") 'highlight-symbol-next)
  (global-set-key (kbd "S-<f3>") 'highlight-symbol-prev)
  (global-set-key (kbd "C-S-s-w") 'highlight-symbol-remove-all)
  ;; 全メジャーモードで自動ハイライト
  (add-hook 'after-change-major-mode-hook 'highlight-symbol-mode))

;; popwin (https://github.com/m2ym/popwin-el)
(el-get-bundle! popwin
  (push '("helm" :regexp t :height 0.5) popwin:special-display-config)
  (push '("*Backtrace*" :noselect t :height 0.5) popwin:special-display-config)
  (push '("*undo-tree*" :height 0.5) popwin:special-display-config)
  (push '("*Shell Command Output*" :noselect t :height 0.5) popwin:special-display-config)
  (push '("*perldoc*" :height 0.5) popwin:special-display-config)
  (push '("*Warnings*" :height 0.5) popwin:special-display-config)
  (push '("*Flycheck errors*" :height 0.5) popwin:special-display-config)
  (popwin-mode 1))

;; quickrun (https://github.com/syohex/emacs-quickrun)
(el-get-bundle! quickrun)

;; zlc (https://github.com/mooz/emacs-zlc/)
(el-get-bundle! zlc
  (zlc-mode 1))

;; all (絞り込んで置換)
(el-get-bundle! all)
(el-get-bundle! all-ext)

;; smartparens (https://github.com/Fuco1/smartparens)
(el-get-bundle! smartparens
  (require 'smartparens-config))

;; dash-at-point (https://github.com/stanaka/dash-at-point)
(el-get-bundle dash-at-point
  (global-set-key (kbd "C-c d") 'dash-at-point)
  (global-set-key (kbd "C-c e") 'dash-at-point-with-docset))

(el-get-bundle hiwin
  (hiwin-activate)
  ;; (set-face-background 'hiwin-face "#4F6169")
  )

;: あんまり使いみちなかった
;; ace-window (https://github.com/abo-abo/ace-window)
;; (el-get-bundle! ace-window
;;   (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;;   (global-set-key (kbd "M-p") 'ace-window))
