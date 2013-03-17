(require 'prelude-c)
(require 'prelude-clojure)
(require 'prelude-coffee)
(require 'prelude-common-lisp)
(require 'prelude-css)
(require 'prelude-emacs-lisp)
(require 'prelude-erc)
;; (require 'prelude-erlang)
;; (require 'prelude-haskell)
(require 'prelude-js)
;; (require 'prelude-latex)
(require 'prelude-lisp)
(require 'prelude-markdown)
;; (require 'prelude-mediawiki)
(require 'prelude-org)
(require 'prelude-perl)
(require 'prelude-python)
(require 'prelude-ruby)
;; (require 'prelude-scala)
(require 'prelude-scheme)
(require 'prelude-scss)
(require 'prelude-xml)

;; These settings reduce the ass of prelude
(setq prelude-guru nil)
(disable-theme 'zenburn)
(setq prelude-whitespace nil)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta))

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(define-key global-map (kbd "A-/") 'hippie-expand)
(define-key global-map (kbd "M-/") 'comment-or-uncomment-region-or-line)

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

(defun select-line-and-get-ready-to-select-next-line ()
  "Emulate sublime text select line"
  (interactive)
  (unless mark-active 
    (beginning-of-line) 
    (push-mark (point)
    (setq mark-active t
          transient-mark-mode t)))
  (forward-line 1))
(global-set-key (kbd "M-l") 'select-line-and-get-ready-to-select-next-line)

( 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
