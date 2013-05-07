(setq scroll-margin 20)

(add-hook 'term-mode-hook
          (function
           (lambda ()
                         (setq-local scroll-margin 0))))

(add-hook 'eshell-mode-hook
          (function
           (lambda ()
             (setq-local scroll-margin 0))))
