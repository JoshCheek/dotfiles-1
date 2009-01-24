(eval-when-compile
  (require 'eproject)
  (require 'linkify))

(define-project-type oly-app (rails)
  (eproject--scan-parents-for file
                              (lambda (dir)
                                (or (string-match "oly-dev/$" (file-name-directory dir)) nil))))

(add-hook 'oly-app-project-file-visit-hook
          (lambda ()
            (define-key eproject-mode-map (kbd "C-c o a") 'olympian-run-aok)
            (define-key eproject-mode-map (kbd "C-c o s") 'olympian-run-aok:specs)
            (define-key eproject-mode-map (kbd "C-c o i") 'olympian-run-aok:integration)
            (define-key eproject-mode-map (kbd "C-c o f") 'olympian-run-aok:features)
            (define-key eproject-mode-map (kbd "C-c o L") 'olympian-tail-log)
            (define-key eproject-mode-map (kbd "C-c f RET") 'olympian-run-feature)
            (define-key eproject-mode-map (kbd "C-c f .") 'olympian-run-feature-at-line)
            ; Overrides my typical ruby irb keybinding
            (define-key eproject-mode-map (kbd "C-c r i") 'olympian-run-script-console)))

(defun olympian-app-root ()
  (file-name-as-directory eproject-root))

(defmacro olympian-in-app-root (&rest body)
  `(let ((default-directory ,(olympian-app-root)))
     ,@body))

; Use script/console, not irb
(defun olympian-run-script-console ()
  (interactive)
  (olympian-in-app-root
   (run-ruby "script/console")))

(defun olympian-ansi-linkify-proc-filter (proc string)
  (linkify-filter proc (ansi-color-apply string)))

(defun olympian-run (bufname cmd args)
  "Uses start-process to run CMD with ARGS, with output to buffer BUFNAME"
  (setq buf (get-buffer-create bufname))
  (save-excursion
    (set-buffer buf)
    (erase-buffer)
    (setq linkify-regexps
          '("^\\(/.*\\):\\([0-9]+\\):?$"
            " \\(features/.+\\):\\([0-9]+\\)")))
  (set-process-filter (apply #'start-process (concat "olympian: " cmd) buf cmd args)
                      'olympian-ansi-linkify-proc-filter)
  (display-buffer buf))

(defun olympian-rake (task)
  (olympian-in-app-root
   (olympian-run (concat "oly: rake " task)
                 "rake" (list task))))

(defun olympian-run-aok ()
  (interactive)
  (olympian-rake "aok"))

(defun olympian-run-aok:specs ()
  (interactive)
  (olympian-rake "aok:specs"))

(defun olympian-run-aok:integration ()
  (interactive)
  (olympian-rake "aok:integration"))

(defun olympian-run-aok:features ()
  (interactive)
  (olympian-rake "aok:features"))

(defun olympian-tail-log (log)
  "Opens a buffer, tailing the named log; defaults to development.log"
  (interactive "sLog (default development): ")
  (let ((log (concat (if (string= "" log)
                         "development"
                       log) ".log")))
    (olympian-in-app-root
     (olympian-run (concat "oly: " log)
                   "tail" (list "-f" (concat "log/" log))))))

(defun olympian-run-feature ()
  (interactive)
  (olympian-in-app-root
   (olympian-run "oly: cucumber" "script/cucumber" (list "-p" "default" (buffer-file-name)))))

(defun olympian-run-feature-at-line ()
  (interactive)
  (olympian-in-app-root
   (olympian-run "oly: cucumber" "script/cucumber" (list
                                                    "-p" "default"
                                                    (concat (buffer-file-name) ":"
                                                            (number-to-string (line-number-at-pos)))))))
