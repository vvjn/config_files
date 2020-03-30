;;
;; Install package from command line. Example:
;;
;;   $ emacs --batch --expr "(define pkg-to-install 'smex)" -l emacs-pkg-install.el
;;
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Fix HTTP1/1.1 problems
(setq url-http-attempt-keepalives nil)
(package-refresh-contents)
;; (package-install pkg-to-install)
(package-install 'elpy)
(package-install 'ivy)
(package-install 'magit)
(package-install 'julia-mode)
(package-install 'julia-repl)
(package-install 'markdown-mode)
