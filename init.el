(add-to-list 'load-path "~/.emacs.d")

;; Melpa package manager
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


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

;; ;; ;; ;; Solarized theme
;; (add-to-list 'load-path "~/.emacs.d/themes")
;; (require 'solarized-light-theme)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized/")
;; ;; (require 'color-theme-solarized)
;; ;; ;; ;; set dark theme
;; ;; (color-theme-solarized-dark)
;;(load-theme 'solarized-dark t)

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

(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

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

;; Configure flymake for Python
;; install pylint first
;; sudo pip install pylint
(setq pylint "/usr/local/bin/epylint")
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list (expand-file-name pylint "") (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; virtualenvwrapper.el
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "~/.virtualenvs/")
