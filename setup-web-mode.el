;; consider looking at this or alternative: https://github.com/fgallina/multi-web-mode

(require 'web-mode)
(require 'js2-mode)
(require 'rhtml-mode)

(add-to-list 'auto-mode-alist '("\\.phtml$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$" . web-mode))
;; will use rhtml-mode instead actually for now
;; (add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))

(defun web-mode-hook ()
  (local-set-key (kbd "RET") 'newline-and-indent)
  (setq web-mode-indent-style 2)
  (setq web-mode-html-offset 2)
  (setq web-mode-css-offset 2)
  (setq web-mode-script-offset 2))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))

(add-hook 'web-mode-hook  'web-mode-hook)
