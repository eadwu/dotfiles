{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/other/nvidia
    ];

  boot = {
    blacklistedKernelModules = [
      # Disable integrated webcam
      "uvcvideo"
    ];

    kernelParams = [
      "acpi_rev_override=5"
      "i915.enable_dc=1"
      "i915.enable_guc=-1"
      "i915.enable_psr=1"
      "i915.disable_power_well=0"
      "psmouse.synaptics_intertouch=0"
    ];
  };

  fonts = {
    fontconfig = {
      antialias = false;
      dpi = 240;
    };
  };

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  powerManagement = {
    undervolt = {
      enable = true;
      core = -100;
      cache = -100;
      gpu = -50;
    };
  };

  services = {
    fwupd = {
      enable = true;
    };

    xserver = {
      extraConfig = ''
        Section "InputClass"
          Identifier "SynPS/2 Synaptics TouchPad"
          MatchProduct "SynPS/2 Synaptics TouchPad"
          MatchIsTouchpad "on"
          MatchOS "Linux"
          MatchDevicePath "/dev/input/event*"
          Option "Ignore" "on"
        EndSection
      '';

      monitorSection = ''
        DisplaySize 406 228
      '';

      libinput = {
        additionalOptions = ''
          Option "AccelSpeed" "1"
        '';
      };
    };
  };
}
