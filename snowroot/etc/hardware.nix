{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware/pulseaudio.nix
    ];

  hardware = {
    bluetooth = {
      enable = true;
    };

    opengl = {
      enable = true;
    };
  };
}
