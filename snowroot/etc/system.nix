{ config, pkgs, ... }:

{
  system = {
    autoUpgrade = {
      enable = true;
      channel = https://nixos.org/channels/nixos-unstable-small;
    };

    nixos = {
      stateVersion = "18.09";
    };
  };
}
