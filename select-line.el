(defun select-line-and-get-ready-to-select-next-line ()
  "Emulate sublime text select line"
  (interactive)
  (unless mark-active
    (beginning-of-line)
    (push-mark (point)
               (setq mark-active t
                     transient-mark-mode t)))
  (forward-line 1))
(global-set-key (kbd "C-l") 'select-line-and-get-ready-to-select-next-line)
