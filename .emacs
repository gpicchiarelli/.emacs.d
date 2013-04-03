  ;;; Giacomo Picchiarelli <gpicchiarelli@gmail.com>
 
    (defun display-startup-echo-area-message ()
      ".."
      (message "I'm here to serve."))
      (add-to-list 'load-path "~/.emacs.d/")
      (setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
      (load-file "~/.emacs.d/cedet/cedet-devel-load.el")
      (semantic-load-enable-excessive-code-helpers)
      (semantic-load-enable-code-helpers)
      (setq semantic-complete-analyze-inline t)
      (global-semantic-idle-completions-mode)

(defun my-c-like-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "." 'semantic-ia-complete-symbol-menu)
  (local-set-key ">" 'semantic-complete-self-insert))

(defun my-cpp-cedet-hook ()
  (local-set-key ":" 'semantic-complete-self-insert))
  
  (global-semanticdb-minor-mode 1)
(setq semantic-analyze-possible-completions t)
(setq semantic-load-turn-everything-on t)
(setq semanticdb-search-system-databases t)   
      (require 'semantic/ia)
      (require 'semantic/bovine/gcc)

;; Integration with imenu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; Display the line and column number in the modeline
    (setq line-number-mode t)
    (setq column-number-mode t)
    (global-linum-mode t)
    (line-number-mode 1)
    (column-number-mode t)

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode 1)
(ede-enable-generic-projects)

      (require 'semantic/analyze)
      (provide 'semantic-analyze)
      (provide 'semantic-ctxt)
      (provide 'semanticdb)
      (provide 'semanticdb-find)
      (provide 'semanticdb-mode)
      (provide 'semantic-load)

(setq c-style-variables-are-local-p t)

(defun my-c-mode-hooks ()
  (let ((bname (buffer-file-name)))
    (cond
     ((string-match "tools_src/" bname) (c-set-style "gnu"))
     ((string-match "uClinux/" bname) (c-set-style "linux"))
     ((string-match "pump/" bname) (c-set-style "gnu"))
     ((string-match "dhcp-" bname) (c-set-style "gnu"))
     ((string-match "ipconfd/" bname) (c-set-style "gnu"))
     ((string-match "gnu/emacs/" bname) (gnu-tabs))
     ((string-match "nn-tk/" bname) (tab8))
     ((string-match "gnu" bname) t)
     ((string-match "\\.[ch]$" bname) (c-set-style "gnu"))
     )))

(add-hook 'c-mode-hook 'my-c-mode-hooks)

(enable-visual-studio-bookmarks)

(defun astyle-this-buffer (pmin pmax)
  (interactive "r")
  (shell-command-on-region pmin pmax
                           "astyle --style=ansi --indent=tab"
                           (current-buffer) t 
                           (get-buffer-create "*Astyle Errors*") t))

(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))


(when (cedet-ectag-version-check t)
  (semantic-load-enable-primary-ectags-support))


      (add-to-list 'load-path "~/.emacs.d/ecb")
     (load-file "~/.emacs.d/ecb/ecb.el")

      (require 'ecb)
      (require 'semantic-load)

      
;;IRC chat
      (add-to-list 'load-path "~/.emacs.d/ecb")
      (require 'erc)
      
      (setq erc-user-full-name "Giacomo Picchiarelli")
                              (setq erc-email-userid "gpicchiarelli@gmail.com")
                              (setq ecb-tip-of-the-day nil)
                              ; I like Ctrl-C Ctrl-V
                              (setq cua-enable-cua-keys)
                              (custom-set-variables '(ecb-options-version "2.40")
                              '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)))
                              (setq ecb-source-path '("~/sviluppo/"))
                              (setq semantic-load-turn-everything-on t)                              
			     
                              (setq ecb-fix-window-size t)                              
                              (ecb-activate)
;; Truncate buffers so they don't hog core.
(setq erc-max-buffer-size 20000)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)

(semantic-add-system-include "/usr/include/*" 'c++-mode)
(semantic-add-system-include "/usr/include/*" 'c-mode)
(semantic-add-system-include "/usr/lib/include/*" 'c++-mode)
(semantic-add-system-include "/usr/lib/include/*" 'c-mode)


(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

    (add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
    (defun my-indent-setup ()
      (c-set-offset 'arglist-intro '+))
    (add-hook 'java-mode-hook 'my-indent-setup)
    
        (defun maybe-linux-style ()
      (when (and buffer-file-name (string-match "linux" buffer-file-name))
        (c-set-style "Linux")))
        (add-hook 'c-mode-hook 'maybe-linux-style)
    

    ;; Show matching parens (mixed style)
    (show-paren-mode t)
    (setq show-paren-delay 0.0)
    
    ;; 'mixed highligts the whole sexp making it unreadable, maybe tweak
    ;; color display?
    (setq show-paren-style 'parenthesis)
    
    ;; Highlight selection
    (transient-mark-mode t)
    
    ;; make all "yes or no" prompts show "y or n" instead
    (fset 'yes-or-no-p 'y-or-n-p)
    
    ;; Don't insert instructions in the *scratch* buffer
    (setq initial-scratch-message nil)
    
    ;; I use version control, don't annoy me with backup files everywhere
    (setq make-backup-files nil)
    (setq auto-save-default nil)
    
  ;;;; Debugging
    (setq
    eval-expression-debug-on-error t ; debugger on errors in eval-expression
    stack-trace-on-error nil ; backtrace of error on debug
    debug-on-error nil ; debugger on errors
    debug-on-quit nil ; debug when C-g is hit
    debug-on-signal nil) ; debug any/every error
(setq-default c-basic-offset 4)
  ;;;; User info
  (setq user-full-name "Giacomo Picchiarelli")
  (setq user-mail-address "gpicchiarelli@gmail.com")

  ;;; Used in ChangeLog entries
  (setq add-log-mailing-address "gpicchiarelli@gmail.com")

  ;;;; Encoding
  ;; I use UTF-8 for everything on my systems, some of the below might
  ;; be redundant.
  (setq locale-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (setq file-name-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
(set-language-environment "Latin-1")
;; Make F1 invoke help
(global-set-key [f1] 'help-command)
;; Make F2 be `undo'
(global-set-key [f2] 'undo)
(global-set-key [f3] 'find-file)
(global-set-key [f4] 'set-mark-command)
;;copy
(global-set-key [f5] "\M-w")
;;paste
(global-set-key [f6] "\C-y")
;; Make F7 be `save-buffer'
(global-set-key [f7] 'save-buffer)
(setq default-major-mode 'text-mode)
(set-language-environment "Latin-1")
(add-hook 'text-mode-hook
  '(lambda () (auto-fill-mode 1)))
;; fullscreen on F11
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
      (if (equal 'fullboth current-value)
  (if (boundp 'old-fullscreen) old-fullscreen nil)
(progn (setq old-fullscreen current-value)
'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)

(defun backward-delete-whitespace-to-column ()
    "delete back to the previous column of whitespace, or just one
  char if that's not possible. This emulates vim's softtabs
  feature."
    (interactive)
    (if indent-tabs-mode
(call-interactively 'backward-delete-char-untabify)
      ;; let's get to work
      (let ((movement (% (current-column) tab-width))
    (p (point)))
;; brain freeze, should be easier to calculate goal
(when (= movement 0) (setq movement tab-width))
(if (save-excursion
      (backward-char movement)
      (string-match "^\\s-+$" (buffer-substring-no-properties (point) p)))
    (delete-region (- p movement) p)
  (call-interactively 'backward-delete-char-untabify)))))
  
    
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(ecb-options-version "2.40")
 '(ede-auto-add-method (quote always))
 '(ede-make-command "make -j2")
 '(ede-project-directories (quote ("/home/giacomo/sviluppo/*")))
 '(erc-nick "n0ti0nis")
 '(erc-nick-uniquifier "`n0ti0nis")
 '(erc-port nil)
 '(erc-prompt-for-password nil)
 '(erc-server "irc.freenode.org")
 '(erc-warn-about-blank-lines nil)
 '(fancy-splash-image nil)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(inhibit-startup-screen t)
 '(speedbar-show-unknown-files t)
 '(speedbar-sort-tags t)
 '(speedbar-use-images t))

  
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(require 'color-theme)
;(color-theme-simple-1)
(color-theme-scintilla)
(set-face-attribute 'default nil :height 100)
(set-scroll-bar-mode 'right) 