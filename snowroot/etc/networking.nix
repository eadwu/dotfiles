{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  networking = {
    hostName = hostname;

    nameservers = [
      "2606:4700:4700::1111,2606:4700:4700::1001"
      "1.0.0.1"
    ];

    networkmanager = {
      enable = true;
    };
  };
}
