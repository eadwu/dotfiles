{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/general.nix
      /etc/nixos/laptop.nix
      /etc/nixos/other/intel
    ];

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://wu.cachix.org"
    ];
    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "wu.cachix.org-1:cHow32fFlXna8uBQA6yoo+505O5eImitDtdXu2JYd0Y="
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
