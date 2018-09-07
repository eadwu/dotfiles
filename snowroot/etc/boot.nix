{ config, pkgs, lib, ... }:

let
  inherit (pkgs) linux_latest linuxPackages_latest linuxPackages_testing;

  settings = import /etc/nixos/settings.nix;
  linux_testing = linuxPackages_testing.kernel;
in with settings; {
  boot = {
    cleanTmpDir = true;
    kernelPackages = if linux_latest.meta.branch == linux_testing.meta.branch
      then linuxPackages_latest
      else linuxPackages_testing;

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
      # Use acpi-cpufreq as the CPU scaling governor
      "intel_pstate=passive"

      # https://wiki.archlinux.org/index.php/Improving_performance#Watchdogs
      "nowatchdog"

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
