;;; Emacs initialization file

(org-babel-load-file "~/.emacs.d/configuration.org")

;;; Customization

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(package-selected-packages
   (quote
    (clojure-mode mu4e which-key use-package-chords try solarized-theme smex slime org-bullets oauth2 jump-char intero fill-column-indicator elpy better-defaults auto-compile auctex ample-theme ace-jump-mode 2048-game)))
 '(solarized-distinct-fringe-background t)
 '(solarized-use-more-italic t)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
