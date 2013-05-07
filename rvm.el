(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
(add-hook 'ruby-mode-hook
       (lambda () (rvm-activate-corresponding-ruby)))
