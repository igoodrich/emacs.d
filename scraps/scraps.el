(defun vi-open-line-above ()
  "insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(define-key global-map [(meta return)] 'vi-open-line-below)
(define-key global-map [(meta shift return)] 'vi-open-line-above)
