(package-initialize)

;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
;;(setq package-archives
;;             '(("melpa-stable" . "http://stable.melpa.org/packages/")))

;; (server-start)

(defun scroll-up-10-lines ()
  "Scroll up 10 lines"
  (interactive)
  (scroll-up 10))

(defun scroll-down-10-lines ()
  "Scroll down 10 lines"
  (interactive)
  (scroll-down 10))

(global-set-key (kbd "<mouse-4>") 'scroll-down-10-lines)
(global-set-key (kbd "<mouse-5>") 'scroll-up-10-lines)

(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))

;;(add-hook 'after-init-hook 'global-company-mode)
;;(add-hook 'after-init-hook 'ivy-mode)
;; (define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-wrapper)

;; (require 'company)
;; (global-company-mode 1)
;; (setq company-idle-delay 0.1
;;       company-minimum-prefix-length 1)
;; (setq company-tooltip-align-annotations t)

;;(ivy-mode)

;; Minimal Ivy everywhere
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t
      enable-recursive-minibuffers t
      ivy-wrap t
      ivy-count-format "(%d/%d) "
      ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

(require 'counsel)
(counsel-mode 1)

(require 'swiper)
(global-set-key (kbd "C-c C-s") 'swiper)

(xterm-mouse-mode 1)
(global-set-key (kbd "C-M-y") 'popup-kill-ring)
;;(global-set-key (kbd "C-c C-s") 'swiper)
;;(global-set-key (kbd "C-s") 'swiper)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

;(tabbar-mode)
;(global-unset-key (kbd "C-t"))
;(global-set-key (kbd "C-t n") 'tabbar-forward)
;(global-set-key (kbd "C-t p") 'tabbar-backward)

(defun backward-delete-word (arg)
    "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
    (interactive "p")
    (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key [M-backspace] 'backward-delete-word)

;; (global-unset-key [down-mouse-1])

(defalias 'qrr 'query-replace-regexp)
(global-set-key [f5] 'call-last-kbd-macro)


(setq default-input-method "TeX")

(setq-default frame-title-format
              '(:eval
                (format "%s"
                        (buffer-name)
                        )))

;;(set-face-attribute 'default nil
;;                    :family "Consolas" :height 125)
(load-theme 'tsdh-dark t)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x <right>"))
(global-set-key (kbd "C-x <left>") 'previous-multiframe-window)
(global-set-key (kbd "C-x <right>") 'next-multiframe-window)
(global-unset-key (kbd "C-x <up>"))
(global-unset-key (kbd "C-x <down>"))
(global-set-key (kbd "C-x <up>") 'previous-multiframe-window)
(global-set-key (kbd "C-x <down>") 'next-multiframe-window)
;;(undo-tree-mode 0)
;;(delete 'lines-tail whitespace-style) ;; lines-tail colors after 80 cols. no likey.

(global-unset-key (kbd "M-w"))
(global-set-key (kbd "M-w") 'kill-ring-save)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq-default c-basic-offset 4)

;;(global-hl-line-mode 0)

(global-set-key (kbd "C-x g") 'goto-line)
;; (global-set-key (kbd "<mouse-2>") nil)


(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-iso-lefttab>") 'previous-buffer) 

(add-hook 'html-mode-hook 'turn-off-auto-fill)

;;(add-hook 'ess-mode-hook
;;          (lambda ()
;;            (setq ess-fancy-comments nil)))
;;
;; (add-hook 'ess-post-run-hook (lambda ()
;;   (ess-execute-screen-options)
;;   (local-set-key "\C-cw" 'ess-execute-screen-options)))
;; (add-hook 'ess-R-post-run-hook (lambda ()
;;   (ess-toggle-underscore nil)
;;   (setq ess-smart-S-assign-key ";")
;;   (ess-toggle-S-assign nil)))
;; 
(add-hook 'latex-mode-hook
    (lambda ()
        (visual-line-mode 1)))

(add-hook 'emacs-lisp-mode
    (lambda ()
        (setq lisp-indent-offset 4)))

(require 'elpy)
(elpy-enable)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'elpy-company-backend))

(require 'pyvenv)

;; Make Elpy use the active venv for its backend
(setq elpy-rpc-virtualenv-path 'current)
(add-hook 'pyvenv-post-activate-hooks #'elpy-rpc-restart)
(add-hook 'pyvenv-post-deactivate-hooks #'elpy-rpc-restart)

(defun my/python-auto-venv ()
  "Activate venv if pyvenv-activate is set in dir-locals."
  (when (and (boundp 'pyvenv-activate) pyvenv-activate)
    (unless (string= pyvenv-activate pyvenv-virtual-env)
      (message "Activating venv: %s" pyvenv-activate)
      (pyvenv-activate pyvenv-activate))))

(add-hook 'python-mode-hook #'my/python-auto-venv)


(require 'corfu)
(global-corfu-mode 1)

(require 'kind-icon)
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
(require 'cape)
(add-to-list 'completion-at-point-functions #'elpy-completion-at-point)
(setq completion-at-point-functions
      (list #'elpy-completion-at-point
            #'cape-dabbrev
            #'cape-file))
(setq corfu-auto t)          ;; popup automatically
(setq corfu-auto-delay 0.1)  ;; short delay
(setq corfu-min-width 20)
(setq corfu-max-width 80)
(setq corfu-cycle t)         ;; cycle through candidates


;; (add-hook 'python-mode-hook    
;;           (lambda ()
;;             (setq indent-tabs-mode nil)
;;             (setq tab-width 4)
;;             (setq python-indent 4)
;;             (elpy-mode)
;;             (setq elpy-rpc-virtualenv-path 'current)
;;             (pyvenv-activate "/home/vvijayan/opt/conda/envs/modis")
;; 	    (setq elpy-rpc-backend "rope") ;; "jedi")
;;             (setq elpy-rpc-virtualenv-path 'current)
;;             (setq python-indent-offset 4)
;;             ;;            (setq elpy-rpc-python-command "python3")
;;             ;; (local-unset-key (kbd "C-c C-c"))
;;             ;; (define-key elpy-mode-map (kbd "C-c C-c") 'elpy-shell-send-statement-and-step)
;;             ))
;; 
(add-hook 'elixir-mode-hook
          (lambda ()
            (alchemist-mode)))

;;(require 'company-lsp)
;;(push 'company-lsp company-backends)


(font-lock-add-keywords nil
                        '(("\\<\\(FIXME\\|TODO\\|QUESTION\\|NOTE\\)"
                           1 font-lock-warning-face t)))

;; (add-hook 'ess-julia-mode-hook 'customize-julia-mode)

;;(require 'lsp-mode)
;; (require 'lsp-julia)

 ;;(autoload 'ess-julia-mode "julia" "Julia Editing Mode" t)
;; (add-to-list 'auto-mode-alist '("\\.jl$" . julia-mode))
(add-hook 'julia-mode-hook
          (lambda ()
            (julia-repl-mode)
            ;;(lsp)
            ))

(add-hook 'ess-julia-mode-hook
          (lambda () (local-set-key (kbd "<tab>")
                                    'julia-latexsub-or-indent))) 

;;(require 'julia-mode)
(defun julia-paren-indent ()
  "Returns nil if we're not within nested parens. Else indent column."
  (save-excursion
    (beginning-of-line)
    (let ((parser-state (syntax-ppss)))
      (cond ((nth 3 parser-state) nil)       ;; strings
            ((= (nth 0 parser-state) 0) nil) ;; top level
            (t
             (ignore-errors ;; return nil if any of these movements fail
               (backward-up-list)
               (forward-char)
               (skip-syntax-forward " ")
               (+ (current-indentation) julia-indent-offset)))))))


(add-hook 'lsp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c h") 'lsp-describe-thing-at-point)))

;;(add-to-list 'eglot-server-programs
;;    `(julia-mode . ("julia" "--startup-file=no" "--history-file=no"
;;                       (concat "-e using LanguageServer, Sockets, SymbolServer;"
;;                           " server = LanguageServer.LanguageServerInstance("
;;                           " stdin, stdout, false,"
;;                           " \"" (egl-julia--get-root) "\","
;;                           " \"" (egl-julia--get-depot-path) "\","
;;                           "Dict());"
;;                           " server.runlinter = true;"
;;                           " run(server);"))))
;;

;(visual-line-mode 1)
;(transient-mark-mode 0)
;(setq line-move-visual nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point))) 
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

;;(global-set-key (kbd "C-*") 'isearch-forward-at-point)
(global-set-key (kbd "C-c *") 'isearch-forward-at-point)

(defun joc-bounce-sexp ()
  "Will bounce between matching parens just like % in vi"
  (interactive)
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
    (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
          ((string-match "[\]})>]" prev-char) (backward-sexp 1))
          (t (error "%s" "Not on a paren, brace, or bracket")))))

;;(global-set-key (kbd "C-=") 'joc-bounce-sexp)
(global-set-key (kbd "C-c =") 'joc-bounce-sexp)

;;BACKUP
(setq hname system-name)
;;(if (compare-string hname 0 9 "graphzilla" 0 nil)
;(if (string= hname "graphzilla02.cse.nd.edu")
;  (setq bkdir "~/.emacs.d/backups/")
;  (setq bkdir (format "%s/%s" "~/.emacs.d/backups" hname)))
(setq bkdir (format "%s/%s" "~/.emacs.d/backups" hname))
(setq backup-directory-alist (list (cons ".*" bkdir)))

(setq
 version-control t ;; Use version numbers for backups
 kept-new-versions 16 ;; Number of newest versions to keep
 kept-old-versions 2 ;; Number of oldest versions to keep
 delete-old-versions t ;; Ask to delete excess backup versions? t for don't ask.
 backup-by-copying-when-linked t) ;; Copy linked files, don't rename.

;;(defun force-backup-of-buffer ()
;;  (setq buffer-backed-up nil))
;;(add-hook 'before-save-hook  'force-backup-of-buffer)

(setq auto-save-list-file-prefix (format "%s/%s" "~/.emacs.d/auto-save-list" hname))
;;(setq auto-save-file-name-transforms `((".*" ,auto-save-list-file-prefix t)))

;; END BACKUP

;;  (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(setq ispell-program-name "aspell")
(setq ispell-list-command "--list")
(setq ispell-extra-args '("--sug-mode=fast"))

(setq bell-volume 0)
(setq visible-bell t)

;(menu-bar-mode 0)
;(tool-bar-mode 0)
(setq inhibit-startup-screen t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(ein:completion-backend 'ein:use-company-backend)
 '(package-selected-packages
   '(alchemist cape company-lsp corfu counsel dumb-jump eglot elixir-mode
               elpy ess flyspell-correct-ivy ivy jedi julia-mode
               julia-repl jupyter kind-icon lsp-julia lsp-mode
               lua-mode magit matlab-mode popup-kill-ring quelpa
               undo-tree)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
