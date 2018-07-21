{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  boot = {
    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_testing;

    blacklistedKernelModules = [
      # https://wiki.archlinux.org/index.php/Improving_performance#Watchdogs
      "iTCO_wdt"
    ];

    kernel = {
      sysctl = {
        "fs.inotify.max_user_instances" = 1024;
        "fs.inotify.max_user_watches" = 524288;
      };
    };

    kernelParams = [
      # https://wiki.archlinux.org/index.php/Improving_performance#Watchdogs
      "nowatchdog"

      # https://ivanvojtko.blogspot.com/2016/04/how-to-get-longer-battery-life-on-linux.html
      "i915.enable_fbc=1"

      # https://wiki.archlinux.org/index.php/Power_management
      # Debugging feature to catch hardware hangs that cause a kernel panic
      # Disabling may cause decrease in power usage
      "nmi_watchdog=0"
      "snd_hda_intel.power_save=1"
      "vm.dirty_writeback_centisecs=6000"
    ];

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
