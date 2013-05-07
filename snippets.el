(require 'yasnippet)
;; yasnippet
;; Just include the rails snippets for ruby
;; NB: there are no rails snippets right now
(add-hook 'ruby-mode-hook '(lambda ()
                            (make-local-variable 'yas-extra-modes)
                            (add-to-list 'yas-extra-modes 'rails-mode)
                            (yas-minor-mode 1)))

;; (yas-global-mode 1)
;; (add-to-list 'load-path "~/.emacs.d/vendor/emacs-emamux")
