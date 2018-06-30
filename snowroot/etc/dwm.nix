{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      dmenu
      dwmstatus
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
