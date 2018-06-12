{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/general.nix
      /etc/nixos/laptop.nix
    ];

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
    ];
    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    ];
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

    overlays = [
      (import /etc/nixos/overlay/pkgs/ark.nix)
      (import /etc/nixos/overlay/pkgs/ncmpcpp.nix)
      (import /etc/nixos/overlay/pkgs/polybar.nix)
      # (import /etc/nixos/overlay/pkgs/python3.nix)
      (import /etc/nixos/overlay/pkgs/vscode-with-extensions.nix)
      # (import /etc/nixos/overlay/default.nix)
    ];
  };
}
