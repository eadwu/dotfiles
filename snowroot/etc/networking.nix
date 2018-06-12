{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  networking = {
    hostName = hostname;

    nameservers = [
      "1.0.0.1"
    ];

    networkmanager = {
      enable = true;
    };
  };
}
