{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
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
