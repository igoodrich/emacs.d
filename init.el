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
(scroll-bar-mode -1)
(setq electric-pair-mode nil)

(setq scroll-margin 20)

;; These settings reduce the ass of prelude
(setq prelude-guru nil)

(defun prelude-tip-of-the-day ()
  "redefined as a noop"
  (interactive))

(disable-theme 'zenburn)
;; (setq prelude-whitespace nil)
(setq prelude-flyspell nil)
(setq whitespace-line-column 140)
;; (when (eq system-type 'darwin) ;; mac specific settings
;;   (setq mac-option-modifier 'alt)
;;   (setq mac-command-modifier 'meta)
;;   (setq ns-function-modifier 'hyper))

;; (setq mac-option-modifier 'alt)

;; (setq visible-bell nil)
(defun my-bell ()
  (message "bell"))

(setq ring-bell-function 'ignore)

(setq c-basic-offset 2)
(setq js-indent-level 2)
(setq js2-basic-offset 2)

(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

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
(global-set-key (kbd "A-l") 'select-line-and-get-ready-to-select-next-line)
(define-key global-map [(meta shift down)] 'select-line-and-get-ready-to-select-next-line)

(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook
       (lambda () (rvm-activate-corresponding-ruby)))

;; (add-hook 'ruby-mode-hook
;;         (lambda () ((define-key ruby-mode-map [(ctrl meta u)] 'er/ruby-backward-up)
;;                     (define-key ruby-mode-map [(ctrl meta d)] 'er/ruby-backward-down))))

;; Better M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

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
;; (evil-leader/set-key
;;     "," 'evil-buffer)

;; simple emacs editing commands in evil insert mode
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-f" 'evil-forward-char)
(define-key evil-insert-state-map "\C-b" 'evil-backward-char)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)
(define-key evil-insert-state-map "\C-n" 'evil-next-line)
(define-key evil-insert-state-map "\C-p" 'evil-previous-line)
(define-key evil-insert-state-map "\C-w" 'evil-delete)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-k" 'kill-line)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-word-mode)

(define-key evil-motion-state-map (kbd "C-;") 'evil-repeat-find-char-reverse)

;; yasnippet
;; Just include the rails snippets for ruby
;; NB: there are no rails snippets right now
(add-hook 'ruby-mode-hook '(lambda ()
                            (make-local-variable 'yas-extra-modes)
                            (add-to-list 'yas-extra-modes 'rails-mode)
                            (yas-minor-mode 1)))

;; (yas-global-mode 1)
(require 'evil-rails)

;; expand-region
(add-to-list 'load-path "~/.emacs.d/vendor/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-,") 'er/expand-region)

;; multiple-cursors
(add-to-list 'load-path "~/.emacs.s/vendor/mutliple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-next-like-this)

;; Rinari
(add-to-list 'load-path "~/.emacs.d/vendor/rinari")
(require 'rinari)

;; git-gutter
(global-git-gutter-mode t)
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x C-r") 'git-gutter:revert-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;;Exit insert mode by pressing j and then k quickly
(setq key-chord-two-keys-delay 0.2)

;; These keys are in the global map since they are them most common
;; way of getting out of non-evil-y buffers (like magit-status) etc.
;; It might make sense to more key bindings here at some point.
(key-chord-define global-map ",t" 'projectile-find-file)
(key-chord-define global-map ",b" 'ido-switch-buffer)
(key-chord-define global-map ",r" 'prelude-recentf-ido-find-file)
(key-chord-define global-map ",," 'evil-buffer)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;; (key-chord-define evil-normal-state-map "ss" 'save-buffer)
(key-chord-define evil-normal-state-map "ss" 'save-buffer)
(key-chord-define evil-normal-state-map "ww" 'save-buffer)
(key-chord-define evil-normal-state-map "]q" 'next-error)
(key-chord-define evil-normal-state-map "[q" 'previous-error)
(key-chord-define evil-normal-state-map "]c" 'git-gutter:next-hunk)
(key-chord-define evil-normal-state-map "[c" 'git-gutter:previous-hunk)
;; (key-chord-define evil-normal-state-map ";;" 'er/expand-region)
(key-chord-mode 1)

(evil-leader/set-key "gs" 'magit-status)
(evil-leader/set-key "gm" 'current-project-find-rails-model)
(evil-leader/set-key "gc" 'current-project-find-rails-controller)
(evil-leader/set-key "gv" 'current-project-find-rails-view)
(evil-leader/set-key "gj" 'current-project-find-rails-javascript)
(evil-leader/set-key "gt" 'current-project-find-rails-test)
(evil-leader/set-key "e" 'er/expand-region)
;; (evil-leader/set-key "t" 'projectile-find-file)
;; (evil-leader/set-key "b" 'ido-switch-buffer)
;; (evil-leader/set-key "r" 'prelude-recentf-ido-find-file)

(define-key evil-insert-state-map (kbd "C-c C-k") 'yas-expand)
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
;; (setq system-uses-terminfo nil)


(setq ag-highlight-search t)

;; font
;; (if window-system (set-face-attribute 'default nil :font "Droid Sans Mono-14"))
(if window-system (set-face-attribute 'default nil :font "Liberation Mono-14"))
;; (if window-system (set-face-attribute 'default nil :font "Droid Sans Mono-16"))
;; (if window-system (set-face-attribute 'default nil :font "Source Code Pro-12"))
;; (if window-system (set-face-attribute 'default nil :font "Monaco-16"))
;; (if window-system (set-face-attribute 'default nil :font "Consolas-16"))
;; (if window-system (set-face-attribute 'default nil :font "Terminus-14"))
;; (if window-system (set-face-attribute 'default nil :font "Source Code Pro-14"))

; evil plugins
(add-to-list 'load-path "~/.emacs.d/vendor/evil-plugins")

;; I don't think these are adding anything
;; (require 'evil-little-word)
;; (require 'evil-textobj-between)

;; default key binding overrides 'C' in vim
;; (setq evil-operator-comment-key (kbd "\\"))
;; (require 'evil-operator-comment)
;; (global-evil-operator-comment-mode 1)

(require 'surround)
(global-surround-mode 1)

(require 'mode-line-color)
(require 'evil-mode-line)

;; Light background modeline
;; (setq evil-mode-line-color
;;   `((normal   . "LightGrey")
;;     (insert   . "DeepSkyBlue1")
;;     (replace  . "yellow1")
;;     (operator . "yellow1")
;;     (visual   . "gold")
;;     (emacs    . "green1")))

;; get rid of the prelude version
(define-key prelude-mode-map (kbd "C-c o") nil)
(global-set-key (kbd "C-c o") 'occur)

(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))


;; ;; (require 'smart-tab)
;; ;; (global-smart-tab-mode 1)
;; (add-to-list 'load-path "~/.emacs.d/vendor/magnars")
;; (require 'setup-hippie)
;; ;; Completion that uses many different methods to find options.
;; ;; These require new bindings for evil
;; (global-set-key (kbd "C-.") 'hippie-expand-no-case-fold)
;; (global-set-key (kbd "C-:") 'hippie-expand-lines)
;; curious how much auto-complete mode slows things down
(require 'auto-complete)
(global-auto-complete-mode)

(defun zeus-testrb ()
  "Compiles the current ruby file with zeus from the project root"
  (interactive)
  (let ((curdir default-directory))
    (message curdir)
    (cd (projectile-project-root))
    (compile (concat "zeus testrb " (buffer-file-name)))
    (cd curdir)))

(add-to-list 'load-path "~/.emacs.d/vendor/emacs-emamux")
(require 'emamux)

;; Load Perspective
;; (require 'perspective)
;; Toggle the perspective mode
;; (persp-mode t)

;; (add-to-list 'load-path "~/.emacs.d/vendor/workgroups.el")
;; (require 'workgroups)
;; (setq wg-prefix-key (kbd "C-c w"))
;; (workgroups-mode 1)
;; (setq wg-morph-on nil)

(desktop-save-mode 1)

(add-hook 'term-mode-hook
          (function
           (lambda ()
                         (setq-local scroll-margin 0))))

(add-hook 'eshell-mode-hook
          (function
           (lambda ()
             (setq-local scroll-margin 0))))

(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/color-theme-github")

(defun p8 ()
  (interactive)
  (desktop-change-dir "~/par8o/par8o"))


(add-hook 'org-mode-hook (function (lambda () (define-key org-mode-map [(tab)] 'org-cycle))))

(define-key prelude-mode-map (kbd "C-c t") 'eshell)
