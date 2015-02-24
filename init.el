(add-to-list 'load-path "~/.emacs.d")

;; Color Theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-clarity)))

;; Highlight Hex Colors
(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer)
  )
(add-hook 'web-mode-hook 'xah-syntax-color-hex)
(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)
;; Custom Themes path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(ansi-color-names-vector ["#e4e4e4" "#d70000" "#5f8700" "#af8700" "#0087ff" "#af005f" "#00afaf" "#808080"])
;;  '(background-color "#000000")
;;  '(background-mode dark)
;;  '(c-label-minimum-indentation 2)
;;  '(cursor-color "#626262")
;;  '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "dc2ae53baca6dabf168ddc038e3c5add1a34a1947087e778e9d14f0e2d4b89a2" default)))
;;  '(fci-rule-color "#383838")
;;  '(foreground-color "#626262")
;;  '(vc-annotate-background "#2B2B2B")
;;  '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3")))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;; ;; ;; ;; Solarized theme
;; (add-to-list 'load-path "~/.emacs.d/themes")
;; (require 'solarized-light-theme)
;; ;;(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-6.6.0/themes/emacs-color-theme-solarized/")
;; ;; (require 'color-theme-solarized)
;; ;; ;; ;; set dark theme
;; ;; (color-theme-solarized-dark)
;; ;; ;; (load-theme 'solarized-dark t)

(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
    (set-face-background 'default "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)

;; Web Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Javascript mode 
(setq js-indent-level 2) ;; indent 2 instead of 4

;; Jshint
;(add-to-list 'load-path "~/.emacs.d/jshint-mode")
;(require 'flymake-jshint)
;(add-hook 'javascript-mode-hook
;     (lambda () (flymake-mode t)))

;; js2-mode
(add-to-list 'load-path "~/.emacs.d/js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(custom-set-variables  
 '(js2-basic-offset 2)  
 '(js2-bounce-indent-p t)  
)

;; electric pair minor mode for emacs24 autopair braces, brackets etc
(electric-pair-mode 1)

;; Show matching parenthesis
(show-paren-mode 1)

;;; popup (required by auto-complete)
(require 'popup)
;;; auto complete mod
(require 'auto-complete-config)
(ac-config-default)

;;; Tern.js
(add-to-list 'load-path "~/.emacs.d/")
(autoload 'tern-mode "tern.el" nil t)

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;;YASnippet
(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Flymake
;;(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(add-to-list 'load-path "~/.emacs.d/jshint-mode")
(require 'flymake-jshint)
(add-hook 'js-mode-hook
     (lambda () (flymake-mode t)))

;; enhancements for displaying flymake errors
(require 'flymake-cursor)

;; flymake error and warning faces 
(custom-set-faces 
 '(flymake-errline ((t (:background "DarkRed")))) 
 '(flymake-warnline ((((class color)) (:background "DarkBlue"))))) 

;; js-comint
(require 'js-comint)
(setq inferior-js-program-command "node --interactive")
(setenv "NODE_NO_READLINE" "1")
(add-hook 'js2-mode-hook '(lambda () 
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)
			    ))
