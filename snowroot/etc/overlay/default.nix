[
  (import /etc/nixos/overlay/pkgs/capitaine-cursors.nix)
  (import /etc/nixos/overlay/pkgs/lightdm-enso-os-greeter.nix)
  (import /etc/nixos/overlay/pkgs/polybar.nix)
  (import /etc/nixos/overlay/pkgs/suckless.nix)
  (import /etc/nixos/overlay/pkgs/vscode.nix)

  (self: super: {
    ark = super.ark.override {
      unfreeEnableUnrar = true;
    };

    glava = super.glava.override {
      enableGlfw = true;
    };

    ncmpcpp = super.ncmpcpp.override {
      clockSupport = true;
      outputsSupport = true;
      visualizerSupport = true;
    };
  })
]
