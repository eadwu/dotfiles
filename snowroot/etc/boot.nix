{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  boot = {
    cleanTmpDir = true;

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

    kernel = {
      sysctl = {
        "fs.inotify.max_user_instances" = 1024;
        "fs.inotify.max_user_watches" = 524288;
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
      };
    };
  };
}
