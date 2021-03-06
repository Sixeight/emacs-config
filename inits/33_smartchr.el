
;; smartchr
(el-get-bundle! smartchr)

(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (define-key cperl-mode-map (kbd "=") (smartchr '("=" "=>" "==")))
               (define-key cperl-mode-map (kbd "F") (smartchr '("F" "$" "@$")))
               ;; (define-key cperl-mode-map (kbd "M") (smartchr '("M" "my $`!!' = ")))
               (define-key cperl-mode-map (kbd "D") (smartchr '("D" "use Data::Dumper; warn Dumper(`!!');")))
               ;; (define-key cperl-mode-map (kbd "S") (smartchr '("S" "my ($self) = @_;" "my ($self, $`!!') = @_;")))
               ;; (define-key cperl-mode-map (kbd "C") (smartchr '("C" "my ($class) = @_;" "my ($class, $`!!') = @_;")))
               (define-key cperl-mode-map (kbd ".") (smartchr '("." "->" "..")))
               ;; (define-key cperl-mode-map (kbd "|") (smartchr '(" || " "|")))
               ;; (define-key cperl-mode-map (kbd "&") (smartchr '(" && " "&")))
               ;; (define-key cperl-mode-map (kbd "{") (smartchr '("{" "sub { `!!' ")))
               )))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map (kbd "P") (smartchr '("P" "require pp; pp ")))
             (define-key ruby-mode-map (kbd "=") (smartchr '("=" "==" "=>")))
             ))

(add-hook 'js-mode-hook
          '(lambda ()
             (define-key js-mode-map (kbd "F") (smartchr '("F" "function() { `!!' }")))
             (define-key js-mode-map (kbd "L") (smartchr '("L" "console.log( `!!' )")))
             ))
