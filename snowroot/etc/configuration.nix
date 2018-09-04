{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/common.nix
      /etc/nixos/hardware-configuration.nix
      # /etc/nixos/machines/darwin.nix
      /etc/nixos/machines/windows.nix
    ];
}
