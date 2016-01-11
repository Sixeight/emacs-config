
;; auto-complete (https://github.com/auto-complete/auto-complete)

;; (el-get-bundle! auto-complete
;;   (ac-config-default)
;;   (setq ac-dwim t)
;;   (setq ac-delay 0.05)
;;   (setq ac-auto-show-menu 0.2)
;;   (setq ac-use-menu-map t)
;;   (setq ac-use-fuzzy t)
;;   (setq ac-ignore-case 'smart))

;; company-mode (https://github.com/company-mode/company-mode)
(el-get-bundle company-mode/company-mode
  (require 'company)
  (setq company-idle-delay 0.05)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (global-company-mode 1))

(set-face-attribute 'company-tooltip nil
                    :foreground "black"
                    :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black"
                    :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white"
                    :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black"
                    :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil
                    :foreground "lightgrey"
                    :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-h") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "M-s") 'company-filter-candidates)
