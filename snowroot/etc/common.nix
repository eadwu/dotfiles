{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  imports =
    [
      /etc/nixos/dwm.nix
      /etc/nixos/general.nix
    ];

  nix = {
    buildCores = 0;
    package = pkgs.nixUnstable;
    requireSignedBinaryCaches = true;
    useSandbox = true;

    binaryCaches = [
      "https://cache.nixos.org/"
      "https://linux.cachix.org"
    ];

    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "linux.cachix.org-1:FgNkZq0e26bKnTHgvxT0Tz4bJxIuvbXY62bSyJbPxbc="
    ];

    trustedBinaryCaches = [
      "https://cache.nixos.org/"
      "https://linux.cachix.org"
    ];

    trustedUsers = [
      user
      "root"
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = import /etc/nixos/overlay;
  };

  powerManagement = {
    enable = true;
  };

  security = {
    sudo = {
      extraConfig = ''
        ${user} ALL=(ALL:ALL) NOPASSWD: ${HOME}/bin/kbd_backlight
        ${user} ALL=(ALL:ALL) NOPASSWD: ${HOME}/bin/mon_backlight
      '';
    };
  };
}
