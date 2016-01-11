
;; powerline (https://github.com/milkypostman/powerline)

;; 境界が綺麗に出ない問題の対処…
(setq ns-use-srgb-colorspace nil)

(el-get-bundle! powerline
  (setq powerline-default-separator 'arrow))

;; via: https://github.com/raugturi/powerline-evil
(defun powerline-evil-tag ()
  "Get customized tag value for current evil state."
  (let* ((visual-block (and (evil-visual-state-p)
                            (eq evil-visual-selection 'block)))
         (visual-line (and (evil-visual-state-p)
                           (eq evil-visual-selection 'line))))
    (upcase (concat (symbol-name evil-state)
                    (cond (visual-block " BLOCK")
                          (visual-line " LINE"))))))

(defun my-powerline-center-evil-theme ()
  "Setup a mode-line with major, evil, and minor modes centered."
  (interactive)
  (setq-default mode-line-format
		'("%e"
		  (:eval
		   (let* ((active (powerline-selected-window-active))
			  (mode-line (if active 'mode-line 'mode-line-inactive))
			  (face1 (if active 'powerline-active1 'powerline-inactive1))
			  (face2 (if active 'powerline-active2 'powerline-inactive2))
			  (separator-left (intern (format "powerline-%s-%s"
							  (powerline-current-separator)
							  (car powerline-default-separator-dir))))
			  (separator-right (intern (format "powerline-%s-%s"
							   (powerline-current-separator)
							   (cdr powerline-default-separator-dir))))
			  (lhs (list (powerline-raw "%*" nil 'l)
				     (powerline-buffer-size nil 'l)
				     (powerline-buffer-id nil 'l)
				     (powerline-raw " ")
				     (funcall separator-left mode-line face1)
				     (powerline-narrow face1 'l)
				     (powerline-vc face1)))
			  (rhs (list (powerline-raw global-mode-string face1 'r)
				     (powerline-raw "%4l" face1 'r)
				     (powerline-raw ":" face1)
				     (powerline-raw "%3c" face1 'r)
				     (funcall separator-right face1 mode-line)
				     (powerline-raw " ")
				     (powerline-raw "%6p" nil 'r)
				     (powerline-hud face2 face1)))
			  (center (append (list (powerline-raw " " face1)
						(funcall separator-left face1 face2)
						(when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
						  (powerline-raw erc-modified-channels-object face2 'l))
						(powerline-major-mode face2 'l)
						(powerline-process face2)
						(powerline-raw " " face2))
					  (if (split-string (format-mode-line minor-mode-alist))
					      (append (if evil-mode
							  (list (funcall separator-right face2 face1)
								(powerline-raw (powerline-evil-tag) face1 'l)
								(powerline-raw " " face1)
								(funcall separator-left face1 face2)))
						      (list (powerline-minor-modes face2 'l)
							    (powerline-raw " " face2)
							    (funcall separator-right face2 face1)))
					    (list (powerline-raw (powerline-evil-tag) face2)
						  (funcall separator-right face2 face1))))))
		     (concat (powerline-render lhs)
			     (powerline-fill-center face1 (/ (powerline-width center) 2.0))
			     (powerline-render center)
			     (powerline-fill face1 (powerline-width rhs))
			     (powerline-render rhs)))))))

(my-powerline-center-evil-theme)
