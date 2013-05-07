(add-hook 'org-mode-hook
          (function
           (lambda ()
             (define-key org-mode-map [(tab)] 'org-cycle))))
