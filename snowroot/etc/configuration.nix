{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/common.nix
      /etc/nixos/develop.nix
      /etc/nixos/hardware-configuration.nix
    ];
}
