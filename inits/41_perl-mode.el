
;; perlモードではなくcperl-modeを使う
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.psgi$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("cpanfile$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("^api.def$" . cperl-mode) auto-mode-alist))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq cperl-close-paren-offset -4)
             (setq cperl-continued-statement-offset 4)
             (setq cperl-indent-level 4)
             (setq cperl-indent-parens-as-block t)
             (setq cperl-tab-always-indent t)
             (setq cperl-indent-parens-as-block t)

             (define-key cperl-mode-map (kbd "s-T") 'run-perl-test)
             (define-key cperl-mode-map (kbd "s-t") 'run-perl-method-test)

             (local-set-key (kbd "C-c C-u") 'popup-editor-perl-use)

             (font-lock-add-keywords
              'cperl-mode
              '(
                ("!" . font-lock-warning-face)
                (":" . font-lock-warning-face)
                ("TODO" 0 'font-lock-warning-face)
                ("XXX" 0 'font-lock-warning-face)
                ("Hatean" 0 'font-lock-warning-face)
                ))

             (smartparens-mode)

             (setq flycheck-checker 'perl-project-libs)
             ))

(defun run-perl-test ()
  "test実行します"
  (interactive)
  (compile (format "cd %s; carton exec -- perl %s" (vc-git-root default-directory) (buffer-file-name (current-buffer)))))

(defun run-perl-method-test ()
  (interactive)
  (let (
        (command compile-command)
        (test-method nil))
    (save-excursion
      (when (or
             (re-search-backward "\\bsub\s+\\([_[:alpha:]]+\\)\s*:\s*Test" nil t)
             (re-search-forward "\\bsub\s+\\([_[:alpha:]]+\\)\s*:\s*Test" nil t))
        (setq test-method (match-string 1))))
    (if test-method
        (compile (format "cd  %s; TEST_METHOD=%s carton exec -- perl %s"
                         (vc-git-root default-directory)
                         (shell-quote-argument test-method)
                         (buffer-file-name (current-buffer))))
      (let ((a 1))
        (save-excursion
          (when (or
                 (re-search-backward "^subtest\s+['\"]?\\([^'\"\s]+\\)['\"]?\s*=>\s*sub" nil t)
                 (re-search-forward "^subtest\s+['\"]?\\([^'\"\s]+\\)['\"]?\s*=>\s*sub" nil t))
            (setq test-method (match-string 1))))
        (if test-method
            (compile (format "cd  %s; SUBTEST_FILTER=%s carton exec -- perl %s"
                             (vc-git-root default-directory)
                             (shell-quote-argument test-method)
                             (buffer-file-name (current-buffer)))))
        (message "not match")
        ))))

(defun popup-editor-perl-use ()
  (interactive)
  (let* ((module-name nil))
    (cond ((use-region-p)
           (setq module-name (buffer-substring (region-beginning) (region-end)))
           (keyboard-escape-quit))
          (t
           (setq module-name (thing-at-point 'symbol))))
    (kill-new (concat "use " module-name ";"))
    (popwin:popup-buffer (current-buffer) :height 0.4)
    (re-search-backward "^use " nil t)
    (forward-line)))

;; required: cpanm Test::UsedModules
;; TODO: qでquickrunのbufferを閉じたい
(defun check-perl-used-modules ()
  (interactive)
  (let* ((topdir (git-root-directory)))
    (quickrun :source `((:command . "perl")
                        (:default-directory . ,topdir)
                        (:exec . ("PERL5LIB=lib:local/lib/perl5:$PERL5LIB %c -MTest::UsedModules -MTest::More -e 'used_modules_ok(\"%s\");done_testing()'"))))))

;; plenv
(el-get-bundle plenv)
(require 'plenv)
(plenv-global "5.20.2")

;; flycheck
;; required: cpanm Project::Libs
(flycheck-define-checker perl-project-libs
  "A perl syntax checker."
  :command ("perl"
            "-MProject::Libs lib_dirs => [qw(local/lib/perl5), glob(qw(modules/*/lib)), glob(qw(t/*/lib))]"
            "-wc"
            source-inplace)
  :error-patterns ((error line-start
                          (minimal-match (message))
                          " at " (file-name) " line " line
                          (or "." (and ", " (zero-or-more not-newline)))
                          line-end))
  :modes (cperl-mode))
