(require 'color-theme)
(setq color-theme-is-cumulative nil)

; Causes color-theme-initialize to blow up for unknown reasons:
;(setq color-theme-directory (concat dotfiles-dir "themes"))

(dolist (file (directory-files (concat emacs-dotfiles-dir "themes") 'full "\\.el\\'"))
  (load file))

(color-theme-initialize)
(color-theme-hober2)

; Other decent themes so far:
; (color-theme-deep-blue)
; (color-theme-hober)
; (color-theme-snow)
; (color-theme-vim-colors)
; (color-theme-pok-wob) ; white on black
; (color-theme-pok-wog) ; white on grey