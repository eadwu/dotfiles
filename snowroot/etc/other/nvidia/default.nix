{ config, pkgs, ... }:

{
  imports =
    [
      # /etc/nixos/other/nvidia/bumblebee.nix
      # /etc/nixos/other/nvidia/disable.nix
      /etc/nixos/other/nvidia/prime.nix
    ];

  environment = {
    systemPackages = with pkgs; [
      cudatoolkit
      glxinfo
      vdpauinfo
    ];
  };

  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
    };
  };
}
