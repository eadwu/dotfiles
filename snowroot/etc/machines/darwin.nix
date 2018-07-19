{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  imports =
    [
      /etc/nixos/other/intel
    ];

  boot = {
    initrd = {
      luks = {
        devices = [
          {
            name = "root";
            device = "/dev/disk/by-uuid/${uuid}";
            preLVM = true;
            allowDiscards = true;
          }
        ];
      };
    };
  };

  fileSystems = {
    "/" = {
      options = [
        "discard"
      ];
    };
  };

  services = {
    ntp = {
      enable = true;
    };
  };
}
