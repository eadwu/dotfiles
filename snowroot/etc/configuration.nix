{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  imports =
    [
      /etc/nixos/common.nix
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/dwm.nix
    ];

  security = {
    sudo = {
      extraRules = [
        {
          users = [
            user
          ];
          commands = [
            {
              command = "${HOME}/bin/kbd_backlight";
              options = [
                "NOPASSWD"
              ];
            }
            {
              command = "${HOME}/bin/mon_backlight";
              options = [
                "NOPASSWD"
              ];
            }
          ];
        }
      ];
    };
  };

  services = {
    xserver = {
      windowManager = {
        default = "dwm";
      };
    };
  };
}
