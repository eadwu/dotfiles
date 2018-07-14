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
        dwm = {
          enable = true;
        };
      };
    };
  };
}
