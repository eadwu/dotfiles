{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      polybar
    ];
  };

  services = {
    xserver = {
      windowManager = {
        default = "dwm";

        dwm = {
          enable = true;
        };
      };
    };
  };
}
