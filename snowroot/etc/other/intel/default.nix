{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel/cpu.nix
      /etc/nixos/other/intel/graphics.nix
    ];
}
