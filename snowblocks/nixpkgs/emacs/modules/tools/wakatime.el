(use-package wakatime-mode
  :diminish
  :custom
  (wakatime-api-key "297f24cc-5a6d-40fa-aded-1822cb51047e")
  (wakatime-cli-path "wakatime")
  (wakatime-python-bin "")
  :init (global-wakatime-mode)
  :commands (global-wakatime-mode))
