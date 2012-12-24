; function( -> ƒ(
; ty emacs-starter-kit
(font-lock-add-keywords
 'js-mode `(("\\(function *\\)("
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "ƒ")
                       nil)))))

(defun pd/add-js-bindings ()
  (pd/enable-newline-and-indent js-mode-map))

(setq js-indent-level 2
      js-auto-indent-flag nil)

(add-hook 'js-mode-hook 'pd/run-coding-hook)
(add-hook 'js-mode-hook 'pd/add-js-bindings)