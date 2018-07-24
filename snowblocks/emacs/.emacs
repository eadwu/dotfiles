; (package-initialize)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(scroll-bar-mode nil)
 '(size-indication-mode t))

(global-set-key (kbd "C-x g") 'magit-status)

(straight-use-package 'flycheck)
(straight-use-package 'helm)
(straight-use-package 'magit)
(straight-use-package 'moe-theme)
(straight-use-package 'nix-buffer)
(straight-use-package 'nix-mode)
(straight-use-package 'wakatime-mode)

(add-to-list
 'default-frame-alist
 '(font . "IBM Plex Mono-10"))

(require 'moe-theme)
(moe-theme-set-color 'cyan)
(require 'moe-theme-switcher)

(global-wakatime-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(electric-pair-mode t)

(setq
 calender-latitude +41
 calender-longitude -74
 display-line-numbers 'relative
 display-line-numbers-current-absolute t
 indent-tabs-mode nil
 require-final-newline t
 tab-width 2)

(let ((autosaves-dir "~/.emacs.d/autosaves/")
      (backup-dir "~/.emacs.d/backups"))
  (dolist (dir (list backup-dir autosaves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq-default
   auto-save-file-name-transforms `((".*" ,autosaves-dir t))
   backup-by-copying 5
   backup-directory-alist `((".*" . ,backup-dir))
   delete-old-versions t
   kept-new-versions 20
   kept-old-versions 5
   tramp-auto-save-directory autosaves-dir
   tramp-backup-directory-alist `((".*" . ,backup-dir))
   version-control t
   wakatime-api-key "ed822699-9d02-4e78-a09b-4951adb539de"
   wakatime-cli-path ""
   wakatime-python-bin "/run/current-system/sw/bin/wakatime"))

(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
