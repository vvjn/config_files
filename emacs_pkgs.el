;;
;; Install package from command line. Example:
;;
;;   $ emacs --batch -l emacs_pkgs.el
;;
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Fix HTTP1/1.1 problems
(setq url-http-attempt-keepalives nil)
(package-refresh-contents)
;; (package-install pkg-to-install)

;; List of packages to install
(setq my-packages
      '(elpy
        pyvenv jedi yasnippet kind-icon
        corfu cape 
        ivy counsel swiper 
        magit projectile))

;; Install each package if not already installed
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

