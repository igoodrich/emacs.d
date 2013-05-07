;; git-gutter
(global-git-gutter-mode t)
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x C-r") 'git-gutter:revert-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
