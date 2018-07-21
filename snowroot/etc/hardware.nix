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
      driSupport32Bit = true;
      enable = true;
    };
  };
}
