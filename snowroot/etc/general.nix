{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/boot.nix
      /etc/nixos/environment.nix
      /etc/nixos/fonts.nix
      /etc/nixos/hardware.nix
      /etc/nixos/networking.nix
      /etc/nixos/programs.nix
      /etc/nixos/services.nix
      /etc/nixos/system.nix
      /etc/nixos/systemd.nix
      /etc/nixos/users.nix
    ];

  fileSystems = {
    "/" = {
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };
  };

  time = {
    timeZone = "America/New_York";
  };
}
