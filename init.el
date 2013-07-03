(setq debug-on-error 't)
(setq debug-on-error nil)
(add-to-list 'load-path "~/.emacs.d/vendor/evil-plugins")
(add-to-list 'load-path "~/code/projectile-rails")

(require 'dash)
(require 'expand-region)
(require 'multiple-cursors)
(require 'rinari)
(require 'auto-complete)
(require 'escreen)
(escreen-install)

(require 'projectile-rails)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq electric-pair-mode nil)

(defun my-bell ()
  (message "bell"))
(setq ring-bell-function 'ignore)

(setq tab-width 2)
(setq c-basic-offset 2)
(setq js-indent-level 2)
(setq js2-basic-offset 2)

(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
(setq set-mark-command-repeat-pop t)


(setq ag-highlight-search t)

;; rinari

;; get rid of the prelude version
(global-auto-complete-mode)
(desktop-save-mode 1)

(defun p8 ()
  (interactive)
  (desktop-change-dir "~/par8o/par8o"))

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key evil-normal-state-map (kbd "<tab>") 'org-cycle)))

(setq blink-cursor-mode 't)

(set-cursor-color "Red")
