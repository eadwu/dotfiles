{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/machines/laptop.nix
    ];

  services = {
    xserver = {
      libinput = {
        additionalOptions = ''
          Option "PalmDetection" "on"
          Option "TappingButtonMap" "lmr"
        '';
      };
    };
  };
}
