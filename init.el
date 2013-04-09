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

(menu-bar-mode -1)

(setq scroll-margin 20)
;; These settings reduce the ass of prelude
(setq prelude-guru nil)
(disable-theme 'zenburn)
(setq prelude-whitespace nil)
(setq prelude-flyspell nil)

;; (when (eq system-type 'darwin) ;; mac specific settings
;;   (setq mac-option-modifier 'alt)
;;   (setq mac-command-modifier 'meta))

;; (setq visible-bell nil)
(defun my-bell ()
  (message "bell"))

(setq ring-bell-function 'ignore)

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(define-key global-map (kbd "A-/") 'hippie-expand)
(define-key global-map (kbd "M-\\") 'comment-or-uncomment-region-or-line)

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
(define-key global-map [(meta shift down)] 'select-line-and-get-ready-to-select-next-line)

(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook
       (lambda () (rvm-activate-corresponding-ruby)))

(add-hook 'ruby-mode-hook
        (lambda () ((define-key ruby-mode-map [(ctrl meta u)] 'er/ruby-backward-up)
                    (define-key ruby-mode-map [(ctrl meta d)] 'er/ruby-backward-down))))

(global-set-key (kbd "M-x") 'smex)

(global-set-key (kbd "M-C-=") 'mc/mark-next-like-this)
(global-set-key (kbd "C-0") 'ace-jump-mode)

(require 'thingatpt)
(require 'imenu)


(defun mine-goto-symbol-at-point ()
  "Will navigate to the symbol at the current point of the cursor"
  (interactive)
  (ido-goto-symbol (thing-at-point 'symbol)))

(defun ido-goto-symbol (&optional a-symbol)
  "Will update the imenu index and then use ido to select a symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol
            (if (null a-symbol)
                (ido-completing-read "Symbol? " symbol-names)
              a-symbol))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position))))))

(global-set-key (kbd "C-x C-i") 'ido-goto-symbol)
(global-set-key (kbd "C-x C-p") 'mine-goto-symbol-at-point)

(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
(global-set-key (kbd "C-c C-r") 'mc/mark-sgml-tag-pair)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(setq set-mark-command-repeat-pop t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/rhtml-minor-mode"))
(require 'rhtml-mode)

;; while key-chord is useful on its own, it's totally necessary for evil
(require 'key-chord)

;;
;; EVIL
;;

(setq evil-shift-width 2)

(add-to-list 'load-path "~/.emacs.d/vendor/evil")
(require 'evil)
(evil-mode 1)
(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
    "," 'evil-buffer)

(require 'evil-rails)

;; expand-region
(add-to-list 'load-path "~/.emacs.d/vendor/expand-region")
(require 'expand-region)
;; (global-set-key (kbd "C-=") 'er/expand-region)

;; Rinari
(add-to-list 'load-path "~/.emacs.d/vendor/rinari")
(require 'rinari)

;; git-gutter
(global-git-gutter-mode t)

;;Exit insert mode by pressing j and then k quickly
(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-normal-state-map "ss" 'save-buffer)
(key-chord-define evil-normal-state-map "]q" 'next-error)
(key-chord-define evil-normal-state-map "[q" 'previous-error)
(key-chord-define evil-normal-state-map "]c" 'git-gutter:next-hunk)
(key-chord-define evil-normal-state-map "[c" 'git-gutter:previous-hunk)
;; (key-chord-define evil-normal-state-map ";;" 'er/expand-region)
(key-chord-mode 1)

(evil-leader/set-key "gs" 'magit-status)
(evil-leader/set-key "gm" 'rinari-find-model)
(evil-leader/set-key "gc" 'rinari-find-controller)
(evil-leader/set-key "gv" 'rinari-find-view)
(evil-leader/set-key "gj" 'rinari-find-javascript)
(evil-leader/set-key "gt" 'rinari-find-test)
(evil-leader/set-key "t" 'projectile-find-file)
(evil-leader/set-key "b" 'ido-switch-buffer)
(evil-leader/set-key "r" 'prelude-recentf-ido-find-file)
(evil-leader/set-key "e" 'er/expand-region)

;; (add-to-list 'load-path "~/.emacs.d/vendor/emacs-emamux")
;; (require 'emamux)

;; (add-to-list 'load-path "~/.emacs.d/vendor/emamux-ruby-test")
;; (require 'emamux-ruby-test)

;; This removes unsightly ^M characters that would otherwise
;; appear in the output of java applications.
;; (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
;; (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;; (require 'multi-term)
;; (setq multi-term-program "/bin/zsh")

;; Use Emacs terminfo, not system terminfo
;; Seems to let me use my zsh crazy prompt without mucking with it
(setq system-uses-terminfo nil)


(setq ag-highlight-search t)


;; TODO: this doesn't work
(setq ruby-compilation-executable "zeus testrb")

;; (add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/vendor/yasnippet/snippets" "~/.emacs.d/plugins/vendor/yasnippet/extras/imported"))
(yas-global-mode 1)
;; When entering rinari-minor-mode, consider also the snippets in the
;; snippet table "rails-mode"
;; TODO: fixme - this doesn't seem to work
(add-hook 'rinari-minor-mode-hook
          #'(lambda ()
              (setq yas/mode-symbol 'rails-mode)))


