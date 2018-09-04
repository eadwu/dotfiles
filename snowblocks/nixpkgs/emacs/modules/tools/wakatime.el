(use-package wakatime-mode
  :diminish
  :custom
  (wakatime-api-key "ed822699-9d02-4e78-a09b-4951adb539de")
  (wakatime-cli-path "wakatime")
  (wakatime-python-bin "")
  :init (global-wakatime-mode)
  :commands (global-wakatime-mode))
