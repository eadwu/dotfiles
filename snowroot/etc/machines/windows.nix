{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/other/nvidia
    ];

  boot = {
    blacklistedKernelModules = [
      "nouveau"
    ];

    kernelParams = [
      "acpi=force"
      "acpi_rev_override=1"
      "acpi_osi=!"
      "acpi_osi='Windows 2009'"
      "i915.alpha_support=1"
      "i915.preliminary_hw_support=1"
      "i915.modeset=1"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      glxinfo
    ];
  };

  hardware = {
    opengl = {
      driSupport32Bit = true;
    };

    bumblebee = {
      driver = "nvidia";
      enable = false;
      pmMethod = "bbswitch";
    };
  };

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  # powerManagement = {
  #   cpuFreqGovernor = "powersave";
  # };

  services = {
    xserver = {
      monitorSection = ''
        DisplaySize 406 228
      '';

      videoDrivers = [
        "nvidia"
        "modesetting"
      ];
    };
  };
}
