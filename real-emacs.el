(setq ring-bell-function 'ignore)
(setq warning-minimum-level :emergency)
(setq message-log-max t)
(add-to-list 'load-path "~/.emacs.d")

(setq term-setup-hook
      '(lambda ()
         (setq keyboard-translate-table "\C-@\C-a\C-b\C-c\C-d\C-e\C-f\C-g\C-?")
         (global-set-key "\M-h" 'help-for-help)))

(defun cleanup-on-save ()
  (add-hook 'write-contents-functions
            (lambda()
              (save-excursion
                (delete-trailing-whitespace))))
  )

(add-hook 'c-mode-common-hook (lambda() (cleanup-on-save)))

(eval-after-load "ruby-mode"
  (add-hook 'ruby-mode-hook
            (lambda() (cleanup-on-save))))

(eval-after-load "scala-mode"
  (add-hook 'scala-mode-hook
            (lambda() (cleanup-on-save))))

(eval-after-load "javascript-mode"
  (add-hook 'javascript-mode-hook
            (lambda() (cleanup-on-save))))

(autoload 'nav "nav" "nav" t)
(eval-after-load 'nav
  '(progn
      (nav-disable-overeager-window-splitting)
      (evil-make-overriding-map nav-mode-map 'normal t)
      (evil-define-key 'normal nav-mode-map
        "j" 'evil-next-line
        "k" 'evil-previous-line)))

(eval-after-load 'compilation-mode
  '(progn
    (evil-make-overriding-map compilation-mode 'normal t)
    (evil-define-key 'normal nav-mode-map
      "gt" 'elscreen-next
      "gT" 'elscreen-previous)))

(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-enable-at-startup nil)

(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/evil-tabs")
(add-to-list 'load-path "~/.emacs.d/evil-numbers")

(require 'evil)
(require 'evil-tabs)
(require 'evil-numbers)

(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(projectile-global-mode)
;; default text formatting options
(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)
(setq-default fill-column 101)
(setq column-number-mode t)


(electric-indent-mode 1)
;; ruby

(setq-default ruby-indent-level 2)
(setq-default evil-shift-width 2)
(add-hook 'ruby-mode-hook
  (lambda () (setq-default evil-shift-width ruby-indent-level)))

(setq auto-mode-alist (cons '("\\.rake\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Rakefile" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Gemfile" . ruby-mode) auto-mode-alist))

; use rsense autocomplete for C-n in insert

; C
(setq-default c-indent-level 4)

; keyboard interface options
(evil-mode 1)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-evil-tabs-mode t)

(setq scroll-conservatively 5)
(setq scroll-margin 5)

; GUI options
(add-to-list 'default-frame-alist  '(width . 100) )
(require 'fill-column-indicator)

;(load-theme 'solarized-dark t)

; plugins
(autoload 'coq-mode "ProofGeneral" "~/.emacs.d/ProofGeneral/generic/proof-site.el"
  "ProofGeneral for coq")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(coq-prog-args (quote ("-I" "/home/corey/Development/cpdt_coconnor/cpdt/src")))
 '(ecb-auto-activate t)
 '(ecb-display-default-dir-after-start t)
 '(ecb-fix-window-size (quote width))
 '(ecb-layout-name "dironly")
 '(ecb-layout-window-sizes (quote (("basic" (ecb-directories-buffer-name 0.25728155339805825 . 0.48214285714285715) (ecb-analyse-buffer-name 0.25728155339805825 . 0.5)) ("left8" (ecb-directories-buffer-name 0.1796116504854369 . 0.26785714285714285) (ecb-sources-buffer-name 0.1796116504854369 . 0.25) (ecb-methods-buffer-name 0.1796116504854369 . 0.2857142857142857) (ecb-history-buffer-name 0.1796116504854369 . 0.17857142857142858)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 40)
 '(inhibit-startup-screen t)
 '(nav-width 40)
 '(nxml-slash-auto-complete-flag t))

(setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(when (file-readable-p "~/.emacs-local.el")
  (load-file "~/.emacs-local.el")
)

(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
; (semantic-mode 1)

(autoload 'dirtree "dirtree" "dirtree" t)

(setq inhibit-default-init t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; Java stuff
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(autoload 'java-mode "jde.el"
  "JDEE for java" t)

(defvar java-src-dir "src/")
(defun java-src-stack-trace-regexp-to-filename ()
  "Generates a relative filename from java-stack-trace regexp match data."
  (concat java-src-dir
          (replace-regexp-in-string "\\." "/" (match-string 1))
          (match-string 2)))

(require 'compile)

;; regexps are not case sensitive so we jump through hoops to get this regex to match as expected
(add-to-list 'compilation-error-regexp-alist 'java-src-stack-trace)
(add-to-list 'compilation-error-regexp-alist-alist
  '(java-src-stack-trace .
    ("at \\(\\(?:[[:alnum:]]+\\.\\)+\\)+[[:alnum:]]+\\..+(\\([[:alnum:]]+\\.java\\):\\([[:digit:]]+\\))$"
     java-src-stack-trace-regexp-to-filename 3)))

(defvar java-tst-dir "tst/")
(defun java-tst-stack-trace-regexp-to-filename ()
  "Generates a relative filename from java-stack-trace regexp match data."
  (concat java-tst-dir
          (replace-regexp-in-string "\\." "/" (match-string 1))
          (match-string 2)))

(add-to-list 'compilation-error-regexp-alist 'java-tst-stack-trace)
(add-to-list 'compilation-error-regexp-alist-alist
  '(java-tst-stack-trace .
    ("at \\(\\(?:[[:alnum:]]+\\.\\)+\\)+[[:alnum:]]+\\..+(\\([[:alnum:]]+\\Test.java\\):\\([[:digit:]]+\\))$"
     java-tst-stack-trace-regexp-to-filename 3)))

(add-hook 'compilation-mode-hook (lambda () (visual-line-mode 1)))
(add-hook 'compilation-minor-mode-hook (lambda () (visual-line-mode 1)))

; from: https://zuttobenkyou.wordpress.com/2012/06/15/emacs-vimlike-tabwindow-navigation/
(defun vimlike-quit ()
  "Vimlike ':q' behavior: close current window if there are split windows;
otherwise, close current tab (elscreen)."
  (interactive)
  (let ((one-elscreen (elscreen-one-screen-p))
        (one-window (one-window-p))
        )
    (cond
     ; if current tab has split windows in it, close the current live window
     ((not one-window)
      (delete-window) ; delete the current window
      ; (balance-windows) ; balance remaining windows
      nil)
     ; if there are multiple elscreens (tabs), close the current elscreen
     ((not one-elscreen)
      (elscreen-kill)
      nil)
     ; if there is only one elscreen, just try to quit (calling elscreen-kill
     ; will not work, because elscreen-kill fails if there is only one
     ; elscreen)
     (one-elscreen
      (evil-quit)
      nil)
     )))

(evil-ex-define-cmd "q[uit]" 'vimlike-quit)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(setq scala-indent:align-parameters t)
(setq blink-matching-paren nil)
(setq dabbrev-case-replace nil)
