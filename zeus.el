(defun zeus-testrb ()
  "Compiles the current ruby file with zeus from the project root"
  (interactive)
  (let ((curdir default-directory))
    (message curdir)
    (cd (projectile-project-root))
    (cond ((pr/buffer-rails-test?)
           (compile (concat "zeus testrb " (buffer-file-name)))
           (setq zeus-testrb-last-file-name (buffer-file-name)))
          (zeus-testrb-last-file-name
           (compile (concat "zeus testrb " zeus-testrb-last-file-name)))
          ('t (message "Not a test and no last test run")))
    (cd curdir)))
