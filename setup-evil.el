(require 'key-chord)
(require 'evil)
(require 'evil-leader)
(require 'mode-line-color)
(require 'evil-mode-line)
(require 'evil-textobj-between)
(require 'surround)

(setq evil-shift-width 2)

(evil-mode 1)

;; I don't think these are adding anything
;; (require 'evil-little-word)
;; for arugments, basically

;; default key binding overrides 'C' in vim
;; (setq evil-operator-comment-key (kbd "\\"))
;; (require 'evil-operator-comment)
;; (global-evil-operator-comment-mode 1)

(global-surround-mode 1)

;; Light background modeline
;; (setq evil-mode-line-color
;;   `((normal   . "LightGrey")
;;     (insert   . "DeepSkyBlue1")
;;     (replace  . "yellow1")
;;     (operator . "yellow1")
;;     (visual  . "gold")
;;     (emacs    . "green1")))

;; Dark background modeline
(setq evil-mode-line-color
  `((normal   . "gray14")
    (insert   . "SteelBlue")
    (replace  . "darkgoldenrod")
    (operator . "darkgoldenrod")
    (visual   . "DarkSlateGrey")
    (emacs    . "DarkOliveGreen")))

(defun set-mode-to-default-emacs (mode)
  (evil-set-initial-state mode 'emacs))

(mapcar 'set-mode-to-default-emacs
        '(dired
          magit-branch-manager-mode
          magit-commit-mode
          magit-log-mode
          log-view-mode
          deft-mode))
