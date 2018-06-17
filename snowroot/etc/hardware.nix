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

    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };

    opengl = {
      enable = true;
    };
  };
}
