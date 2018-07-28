{ config, pkgs, ... }:

{
  system = {
    stateVersion = "18.09";

    autoUpgrade = {
      enable = false;
      channel = https://nixos.org/channels/nixpkgs-unstable;
    };
  };
}
