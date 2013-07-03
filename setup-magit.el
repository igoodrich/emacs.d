;; magit status mode wants to be in emacs mode
;; but the lack of these keys was driving me crazy
(add-hook 'magit-status-mode-hook
          (function
           (lambda ()
             (define-key magit-status-mode-map (kbd "D") 'magit-discard-item)
             (define-key magit-status-mode-map (kbd "k") 'previous-line)
             (define-key magit-status-mode-map (kbd "j") 'next-line))))
