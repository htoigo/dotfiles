;;; Emacs initialization file

(org-babel-load-file "~/.emacs.d/configuration.org")

;;; Customization

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" default))
 '(delete-selection-mode nil)
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults))
 '(org-babel-load-languages '((emacs-lisp . t) (shell . t)))
 '(package-selected-packages
   '(clojure-mode mu4e which-key use-package-chords try solarized-theme smex slime org-bullets oauth2 jump-char intero fill-column-indicator elpy better-defaults auto-compile auctex ample-theme ace-jump-mode 2048-game))
 '(solarized-distinct-fringe-background t)
 '(solarized-use-more-italic t)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
