(require 'projectile)

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
