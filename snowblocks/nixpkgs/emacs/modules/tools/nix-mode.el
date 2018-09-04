(use-package nix-mode
  :custom
  (nix-indent-function 'nix-indent-line))

(use-package nix-update
  :bind (("C-. u" . nix-update-fetch)))
