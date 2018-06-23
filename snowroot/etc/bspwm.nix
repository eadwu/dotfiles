{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  environment = {
    systemPackages = with pkgs; [
      polybar
      xdo
    ];
  };

  services = {
    xserver = {
      windowManager = {
        bspwm = {
          configFile = "${HOME}/.bspwm/bspwmrc";
          enable = true;

          sxhkd = {
            configFile = "${HOME}/.bspwm/sxhkdrc";
          };
        };
      };
    };
  };
}
