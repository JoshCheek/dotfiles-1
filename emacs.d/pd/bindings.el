;; smex
(keydef "M-x" smex)
(keydef "M-X" smex-major-mode-commands)

;; buffer manipulation
(keydef "C-x C-b" ibuffer)
(keydef "C-c b r" rename-buffer)
(keydef "C-c b R" pd/rename-buffer-and-file)
(keydef "C-c b z" reload-buffer) ; rerun hooks
(keydef "C-c b Z" revert-buffer) ; actually reload the file
(keydef "C-c b b" previous-buffer)
(keydef "C-c b f" next-buffer)
(keydef "C-c b n" (message "%s" (pd/kill-file-name)))

;; buffer-move: move current buffer to another window
(keydef "C-x w k" buf-move-up)
(keydef "C-x w j" buf-move-down)
(keydef "C-x w h" buf-move-left)
(keydef "C-x w l" buf-move-right)

;; super-[hjkl]: move cursor to another window
(keydef "s-h" windmove-left)
(keydef "s-j" windmove-down)
(keydef "s-k" windmove-up)
(keydef "s-l" windmove-right)

;; find files
(keydef "C-x C-d" dired) ; i never, ever want list-directory
(keydef "C-c f"   pd/find-file-in-repository-vertically)
(keydef "C-c C-f" find-file-at-point)

;; text navigation
(keydef "C-a"   pd/back-to-indentation-or-beginning-of-line)
(keydef "C-`"   pd/push-mark)
(keydef "M-`"   pd/jump-to-mark)
(keydef "M-i"   imenu)
(keydef "M-C-[" backward-paragraph) ; M-{, but less awkward on my pinky
(keydef "M-C-]" forward-paragraph)  ; M-}

;; text editing
(keydef "C-c p"    fill-paragraph)
(keydef "M-/"      hippie-expand)
(keydef (ac "C-,") auto-complete)
(keydef "C-S-k"    kill-whole-line)
(keydef "C-c w"    delete-trailing-whitespace)
(keydef "C-\\"     delete-horizontal-space)
(keydef "C-c #"    comment-or-uncomment-region)
(keydef "C-c / s"  replace-string)
(keydef "C-c / r"  replace-regexp)
(keydef "C-c ="    align-regexp)
(keydef "C-="      er/expand-region)
(keydef "M-j"      (join-line 1))
(keydef "M-<return>"   pd/append-and-move-to-new-line)
(keydef "M-S-<return>" pd/prepend-and-move-to-new-line)

;; multiple-cursors.el
(keydef "C-c m")
(keydef "H-SPC"     'set-rectangular-region-anchor)
(keydef "C-c m SPC" 'set-rectangular-region-anchor)
(keydef "C-c m e"   'mc/edit-lines)
(keydef "C-c m C-a" 'mc/edit-beginnings-of-lines)
(keydef "C-c m C-e" 'mc/edit-ends-of-lines)
(keydef "C-c m y"   'yank-rectangle) ; C-x r y, but i think of it in terms of mc/...
(keydef "C->"       'mc/mark-next-like-this)
(keydef "C-<"       'mc/mark-previous-like-this)
(keydef "C-%"       'mc/mark-all-like-this)

;; tranpositions
(keydef "M-t")
(keydef "M-t c" transpose-chars)
(keydef "M-t w" transpose-words)
(keydef "M-t l" transpose-lines)
(keydef "M-t s" transpose-sexps)

;; jump!
(keydef "C-c j f" find-function)
(keydef "C-c j l" find-library)
(keydef "C-c j k" find-function-on-key)
(keydef "C-c j v" find-variable)

;; shells
(keydef "C-c s" pd/smart-shell)
(keydef "C-c M-s" pd/ido-switch-shell)

;; C-c x: repls
(keydef "C-c x e" ielm)
(keydef "C-c x r" run-ruby)

;; misc
(keydef "C-x g" magit-status)
(keydef "s-+" pd/increase-font-size)
(keydef "s-_" pd/decrease-font-size)
(keydef "<f6>" linum-mode)
(keydef "C-c a" org-agenda)
(keydef "C-h a" apropos) ; defaults to command-apropos

;; Annoyances
(keydef "<menu>")
(keydef "C-x C-z")
(keydef "C-z")
(keydef "C-x m")

;; Habits to be broken
(keydef "M-<left>")
(keydef "M-<right>")

(provide 'pd/bindings)
