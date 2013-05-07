(require 'projectile)
(require 's)

(defun current-project-find-rails-model ()
  "Find a rails model in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "app/models")))

(defun current-project-find-rails-controller ()
  "Find a rails controller in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "app/controllers")))

(defun current-project-find-rails-view ()
  "Find a rails view in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "app/views")))

(defun current-project-find-rails-test ()
  "Find a rails test in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "test")))

(defun current-project-find-rails-interactor ()
  "Find a rails interactor in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "app/interactors")))

(defun current-project-find-rails-javascript ()
  "Find a rails javascript file in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "app/assets/javascripts")))

(defun current-project-find-rails-stylesheet ()
  "Find a rails stylesheet in the current projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "app/assets/stylesheets")))

(defun current-project-find-rails-lib-file ()
  "Find a file in lib in a rails  projectile project"
  (interactive)
  (ido-find-file-in-dir (concat (projectile-project-root) "lib")))

(defun current-project-find-rails-gemfile ()
  "Find a rails stylesheet in the current projectile project"
  (interactive)
  (find-file (concat (projectile-project-root) "Gemfile")))

(defun current-project-find-rails-routes ()
  "Find a rails stylesheet in the current projectile project"
  (interactive)
  (find-file (concat (projectile-project-root) "config/routes.rb")))

(defun current-project-find-rails-db-schema ()
  "Find a rails stylesheet in the current projectile project"
  (interactive)
  (find-file (concat (projectile-project-root) "db/schema.rb")))

(defun rails--key-pairs-with-prefix (prefix keys)
  (read-kbd-macro (concat prefix " " keys)))

(defun rails--add-keybindings (key-fn)
  (define-key global-map (funcall key-fn "m") 'current-project-find-rails-model)
  (define-key global-map (funcall key-fn "c") 'current-project-find-rails-controller)
  (define-key global-map (funcall key-fn "v") 'current-project-find-rails-view)
  (define-key global-map (funcall key-fn "i") 'current-project-find-rails-interactor)
  (define-key global-map (funcall key-fn "j") 'current-project-find-rails-javascript)
  (define-key global-map (funcall key-fn "s") 'current-project-find-rails-stylesheet)
  (define-key global-map (funcall key-fn "t") 'current-project-find-rails-test)
  (define-key global-map (funcall key-fn "l") 'current-project-find-rails-lib-file)
  (define-key global-map (funcall key-fn "g") 'current-project-find-rails-gemfile)
  (define-key global-map (funcall key-fn "d") 'current-project-find-rails-db-schema))

(defun rails-add-keybindings-with-prefix (prefix)
  (rails--add-keybindings (-partial 'rails--key-pairs-with-prefix prefix)))

(rails-add-keybindings-with-prefix "C-c C-g")


(defun pr/buffer-file-name-or-empty () (or buffer-file-name ""))

(defun pr/true-project-root () (file-truename (projectile-project-root)))

(defun pr/buffer-file-name-relative-to-project ()
  (s-chop-prefix (pr/true-project-root) (pr/buffer-file-name-or-empty)))

(defun pr/buffer-file-name-relative-to-app ()
  (s-chop-prefix (concat (pr/true-project-root) "app/") (pr/buffer-file-name-or-empty)))

(defun pr/buffer-file-name-relative-to-unit-test ()
  (s-chop-prefix (concat (pr/true-project-root) "test/unit") (pr/buffer-file-name-or-empty)))

(defun pr/buffer-file-name-relative-to-functional-test ()
  (s-chop-prefix (concat (pr/true-project-root) "test/functional") (pr/buffer-file-name-or-empty)))

(defun pr/buffer-rails-model? ()
  (s-starts-with? "app/models" (pr/buffer-file-name-relative-to-project)))

(defun pr/buffer-rails-controller? ()
  (s-starts-with? "app/controller" (pr/buffer-file-name-relative-to-project)))

(defun pr/buffer-rails-view? ()
  (s-starts-with? "app/views" (pr/buffer-file-name-relative-to-project)))

(defun pr/buffer-rails-test? ()
  (s-starts-with? "test/" (pr/buffer-file-name-relative-to-project)))

(defun pr/buffer-rails-unit-test? ()
  (s-starts-with? "test/unit" (pr/buffer-file-name-relative-to-project)))

(defun pr/buffer-rails-functional-test? ()
  (s-starts-with? "test/functional" (pr/buffer-file-name-relative-to-project)))

(defun pr/buffer-rails-spec? ()
  (s-starts-with? "spec/" (pr/buffer-file-name-relative-to-project)))

(defun pr/test-file-from-file-name (fname)
  (concat (s-chop-suffix ".rb" fname) "_test.rb"))

(defun pr/spec-file-from-file-name (fname)
  (concat (s-chop-suffix ".rb" fname) "_spec.rb"))

(defun pr/base-file-from-test-file-name (fname)
  (s-replace "_test.rb" ".rb" fname))

(defun pr/test-file-from-model ()
  (pr/test-file-from-file-name
   (concat
    (projectile-project-root)
    (s-replace "models" "test/unit" (pr/buffer-file-name-relative-to-app)))))

(defun pr/test-file-from-app-file ()
  "Given an arbirary app file, assume a corresponding relative path in test/unit"
  (concat
   (projectile-project-root)
   "test/unit/"
   (pr/test-file-from-file-name (pr/buffer-file-name-relative-to-app))))

(defun pr/app-file-in-dir-from-unit-test-file (dir-from-root)
  (concat
   (projectile-project-root)
   dir-from-root
   (pr/base-file-from-test-file-name (pr/buffer-file-name-relative-to-unit-test))))

(defun pr/app-file-from-unit-test-file ()
  (let ((model-file (pr/app-file-in-dir-from-unit-test-file "app/models"))
        (other-file (pr/app-file-in-dir-from-unit-test-file "app")))
    (cond ((file-exists-p model-file) model-file)
          ('t other-file))))

(defun pr/app-file-from-functional-test-file ()
  (concat
   (projectile-project-root)
   "app/controllers"
   (pr/base-file-from-test-file-name (pr/buffer-file-name-relative-to-functional-test))))

(defun pr/test-file-from-controller ()
  (pr/test-file-from-file-name
   (concat
    (projectile-project-root)
    (s-replace "controllers" "test/functional" (pr/buffer-file-name-relative-to-app)))))

(defun pr/test-file-from-view ()
  (pr/test-file-from-view-file (projectile-project-root) (pr/buffer-file-name-relative-to-project)))

(defun pr/test-file-from-view-file (root view-file-name)
  (concat root
          "test/functional/"
          (s-join "/" (butlast (s-split "/" (s-chop-prefix  "app/views/" view-file-name))))
          "_controller_test.rb"))

(defun pr/alternate-file-name ()
  (cond ((pr/buffer-rails-model?) (pr/test-file-from-model))
        ((pr/buffer-rails-controller?) (pr/test-file-from-controller))
        ((pr/buffer-rails-unit-test?) (pr/app-file-from-unit-test-file))
        ((pr/buffer-rails-functional-test?) (pr/app-file-from-functional-test-file))
        ((pr/buffer-rails-view?) (pr/test-file-from-view))
        ('t (pr/test-file-from-app-file))))

(defun pr/find-alternate-file ()
  (interactive)
  (let ((f (pr/alternate-file-name)))
    (cond ((file-exists-p f) (find-file f))
          ('t (message "No alternate file exists")))))

(defun pr/find-alternate-file-other-window ()
  (interactive)
  (let ((f (pr/alternate-file-name)))
    (cond ((file-exists-p f) (find-file-other-window f))
          ('t (message "No alternate file exists")))))

(defun pr/migrations-dir ()
  (file-name-as-directory (concat (projectile-project-root) "db/migrate")))

(defun pr/migrations ()
  (directory-files (pr/migrations-dir)))

(defun pr/last-migration ()
  (car (reverse (pr/migrations))))

(defun pr/find-last-migration ()
  (interactive)
  (find-file (concat (pr/migrations-dir) (pr/last-migration))))

(defun pr/prev-file ()
  (let* ((current-dir (file-name-directory (buffer-file-name)))
         (files (-reject (lambda (file) (file-directory-p file)) (directory-files current-dir)))
         (prev-file (pr/file-before files (buffer-name))))
    (cond (prev-file (concat current-dir prev-file))
          ('t nil))))

(defun pr/next-file ()
  (let* ((current-dir (file-name-directory (buffer-file-name)))
         (files (reverse
                 (-reject (lambda (file)
                            (file-directory-p file)) (directory-files current-dir))))
         (next-file (pr/file-before files (buffer-name))))
    (cond (next-file (concat current-dir next-file))
          ('t nil))))

(defun pr/file-before (files matching-file)
  (car (last (-take-while (lambda (file) (not (equal file matching-file))) files))))

(defun pr/find-prev-file ()
  (interactive)
  (let ((prev-file (pr/prev-file)))
    (cond (prev-file (find-file prev-file))
          ('t (message "No previous file")))))

(defun pr/find-next-file ()
  (interactive)
  (let ((next-file (pr/next-file)))
    (cond (next-file (find-file next-file))
          ('t (message "No next file")))))
