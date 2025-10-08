(package-initialize)

;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
;;(setq package-archives
;;             '(("melpa-stable" . "http://stable.melpa.org/packages/")))

;; (server-start)

;;(setq xterm-extra-capabilities '(getSelection setSelection))

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

;;(global-company-mode)
;;(ivy-mode)
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

(global-hl-line-mode 0)

(global-set-key (kbd "C-x g") 'goto-line)
;; (global-set-key (kbd "<mouse-2>") nil)


(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-iso-lefttab>") 'previous-buffer) 

(add-hook 'html-mode-hook 'turn-off-auto-fill)

(add-hook 'latex-mode-hook
    (lambda ()
        (visual-line-mode 1)))

(add-hook 'emacs-lisp-mode
    (lambda ()
      (setq lisp-indent-offset 4)))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))

(elpy-enable)

;(setq python-indent-guess-indent-offset t)  
;(setq python-indent-guess-indent-offset-verbose nil)
;
(add-hook 'python-mode-hook    
          (lambda ()
            (setq indent-tabs-mode nil)))


(require 'pyvenv)
(require 'seq)

(defvar-local my/pyvenv-activated-path nil
  "Stores the PYVENV_DIR activated for this buffer.")

(defun my/auto-activate-pyvenv ()
  "Activate the Python virtualenv defined by PYVENV_DIR from dir-locals."
  (when (and (derived-mode-p 'python-mode)
             (boundp 'PYVENV_DIR)
             (file-directory-p PYVENV_DIR)
             (not (equal pyvenv-virtual-env PYVENV_DIR)))
    (pyvenv-activate PYVENV_DIR)
    (setq my/pyvenv-activated-path PYVENV_DIR)
    (message "Activated PYVENV_DIR: %s" PYVENV_DIR)))

(defun my/buffers-using-venv (venv-path)
  "Return a list of buffers using the given VENV-PATH."
  (seq-filter
   (lambda (buf)
     (with-current-buffer buf
       (and (derived-mode-p 'python-mode)
            (equal my/pyvenv-activated-path venv-path))))
   (buffer-list)))

(defun my/auto-deactivate-unused-pyvenvs ()
  "Deactivate the current virtualenv if no buffer still uses it."
  (when (and pyvenv-virtual-env)
    (let ((still-used (my/buffers-using-venv pyvenv-virtual-env)))
      (when (null still-used)
        (pyvenv-deactivate)
        (message "Deactivated unused virtualenv: %s" pyvenv-virtual-env)))))



; (defun my/switch-pyvenv-on-buffer-change ()
;   "When switching buffers, activate or deactivate virtualenvs as needed."
;   (when (derived-mode-p 'python-mode)
;     (when (and my/pyvenv-activated-path
;                (not (equal pyvenv-virtual-env my/pyvenv-activated-path)))
;       (pyvenv-activate my/pyvenv-activated-path)
;       (message "Switched to PYVENV_DIR: %s" my/pyvenv-activated-path)))
;   (my/auto-deactivate-unused-pyvenvs))
                                        ;

(defvar my/last-buffer nil
  "Tracks the last buffer visited to detect real buffer switches.")

(defun my/switch-pyvenv-on-buffer-change ()
  "Switch pyvenv on real buffer changes only."
  (let ((current (current-buffer)))
    (unless (eq current my/last-buffer)
      (setq my/last-buffer current)
      (when (derived-mode-p 'python-mode)
        (when (and my/pyvenv-activated-path
                   (not (equal pyvenv-virtual-env my/pyvenv-activated-path)))
          (pyvenv-activate my/pyvenv-activated-path)
          (message "Switched to PYVENV_DIR: %s" my/pyvenv-activated-path)))))
  (my/auto-deactivate-unused-pyvenvs))

;; Run activation after dir-locals are loaded
(add-hook 'hack-local-variables-hook #'my/auto-activate-pyvenv)

;; Deactivate when killing a buffer
(add-hook 'kill-buffer-hook #'my/auto-deactivate-unused-pyvenvs)

;; Switch env when changing buffers
(add-hook 'buffer-list-update-hook #'my/switch-pyvenv-on-buffer-change)



;            (setq tab-width 4)
;            (setq python-indent 4)
;            (setq python-indent-offset 4)
;            ;(elpy-mode)
;            ;;(setq elpy-rpc-virtualenv-path 'current)
;            ;(pyvenv-activate (getenv "PYVENV"))
;	    ;(setq elpy-rpc-backend "jedi") ;; "rope") ;; 
;            ;(setq elpy-rpc-virtualenv-path 'current)
;            ;;(elpy-enable)
;            ;;            (setq elpy-rpc-python-command "python3")
;            ;; (local-unset-key (kbd "C-c C-c"))
;            ;; (define-key elpy-mode-map (kbd "C-c C-c") 'elpy-shell-send-statement-and-step)
;            ))
;
;(add-hook
; 'elpy-mode-hook
; (lambda ()
;   (setenv "WORKON_HOME" PYVENV_DIR)
;   (pyvenv-activate (getenv "WORKON_HOME"))))
;

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

(setq inferior-julia-program-name "/opt/julia/bin/julia")

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
 '(package-selected-packages '(markdown-mode json-mode yaml-mode magit ivy elpy))
 '(safe-local-variable-values
   '((PYVENV_DIR . "/home/vipin/venvs/clearml")
     (PYVENV_DIR . "/home/vipin/venvs/od")
     (PYVENV_DIR . "/home/vipin/opt/venvs/formation_detection")
     (PYVENV_DIR . "/home/vipin/opt/venvs/nm_vidinf")
     (PYVENV_DIR . "/home/vipin/opt/venvs/quizrush")
     (PYVENV_DIR . "/home/vipin/opt/venvs/football")
     (PYVENV_DIR . "/home/vipin/opt/venvs/fun")
     (PYVENV_DIR . "/home/vipin/opt/venvs/rdcode/")
     (PYVENV_DIR . "/home/vipin/opt/venvs/racode/")
     (PYVENV_DIR . "/home/vipin/opt/venvs/rdcode")
     (PYVENV_DIR . "/home/vipin/opt/venvs/racode") (PYVENV_DIR . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
