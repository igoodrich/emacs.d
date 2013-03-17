;; (require 'etags)
;; (defun ido-find-tag ()
;;   "Find a tag using ido"
;;   (interactive)
;;   (tags-completion-table)
;;   (let (tag-names)
;;     (mapc (lambda (x)
;; 	    (unless (integerp x)
;; 	      (push (prin1-to-string x t) tag-names)))
;; 	  tags-completion-table)
;;     (find-tag (ido-completing-read "Tag: " tag-names))))

;; (defun ido-find-file-in-tag-files ()
;;   (interactive)
;;   (save-excursion
;;     (let ((enable-recursive-minibuffers t))
;;       (visit-tags-table-buffer))
;;     (find-file
;;      (expand-file-name
;;       (ido-completing-read
;;        "Project file: " (tags-table-files) nil t)))))

;; (global-set-key [remap find-tag] 'ido-find-tag)
;; (global-set-key (kbd "C-.") 'ido-find-file-in-tag-files)
;; (global-git-gutter-mode t)
;; (setq visible-bell t)

