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
(setq prelude-guru nil)

(defun prelude-tip-of-the-day ()
  "redefined as a noop"
  (interactive))

(disable-theme 'zenburn)
(setq prelude-flyspell nil)
(setq whitespace-line-column 140)

(define-key prelude-mode-map (kbd "C-c t") 'eshell)