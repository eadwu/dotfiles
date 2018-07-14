{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  imports =
    [
      /etc/nixos/dwm.nix
      /etc/nixos/general.nix
      /etc/nixos/laptop.nix
    ];

  security = {
    sudo = {
      extraConfig = ''
        ${user} ALL=(ALL:ALL) NOPASSWD: ${HOME}/bin/kbd_backlight
        ${user} ALL=(ALL:ALL) NOPASSWD: ${HOME}/bin/mon_backlight
      '';
    };
  };

  services = {
    xserver = {
      windowManager = {
        default = "dwm";
      };
    };
  };

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
    ];
    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    ];
    buildCores = 0;
    requireSignedBinaryCaches = true;
    trustedBinaryCaches = [
      "https://cache.nixos.org/"
    ];
    useSandbox = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = import /etc/nixos/overlay;
  };
}
