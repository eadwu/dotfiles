{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
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
