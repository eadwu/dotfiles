{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
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
