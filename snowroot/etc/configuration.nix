{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  imports =
    [
      /etc/nixos/common.nix
      /etc/nixos/hardware-configuration.nix
    ];

  security.sudo.extraRules = [
    {
      users = [
        user
      ];
      commands = [
        {
          command = "${HOME}/.bspwm/bin/kbd_backlight";
          options = [
            "NOPASSWD"
          ];
        }
        {
          command = "${HOME}/.bspwm/bin/mon_backlight";
          options = [
            "NOPASSWD"
          ];
        }
      ];
    }
  ];
}
