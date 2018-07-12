{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      dwmstatus
      slstatus
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
