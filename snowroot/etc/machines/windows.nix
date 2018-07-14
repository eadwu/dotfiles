{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/other/nvidia
    ];

  boot = {
    kernelParams = [
      "acpi_rev_override=1"
      # i915 kernel power saving
      "enable_psr=1"
      "disable_power_well=0"
    ];
  };

  fonts = {
    fontconfig = {
      antialias = false;
      dpi = 240;
    };
  };

  hardware = {
    opengl = {
      driSupport32Bit = true;
    };
  };

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  services = {
    xserver = {
      monitorSection = ''
        DisplaySize 406 228
      '';
    };
  };
}
