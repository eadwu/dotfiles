{ config, pkgs, ... }:

let
  ucfg = config.services.undervolt;
in {
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
      # calculated: 282.42
      dpi = 240;
    };
  };

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  programs = {
    zsh = {
      shellAliases = {
        "google-musicmanager" = "QT_AUTO_SCREEN_SCALE_FACTOR=2 google-musicmanager";
      };
    };
  };

  services = {
    fwupd = {
      enable = true;
    };

    tlp = {
      extraConfig = ''
        # Autosuspend for USB device Goodix Fingerprint Device
        USB_WHITELIST="27c6:5395"
      '';
    };

    undervolt = {
      enable = true;
      coreOffset = "-100";
      gpuOffset = "-75";
      uncoreOffset = ucfg.coreOffset;
      analogioOffset = ucfg.coreOffset;
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

      # calculated: 293.58336 165.14064
      monitorSection = ''
        DisplaySize 406 228
      '';

      screenSection = ''
        Option "DPI" "240 x 240"
      '';

      libinput = {
        additionalOptions = ''
          Option "AccelSpeed" "1"
          Option "PalmDetection" "on"
          Option "TappingButtonMap" "lmr"
        '';
      };
    };
  };

  systemd = {
    services = {
      undervolt = {
        enable = false;
      };

      undervolts = {
        after = [
          "suspend.target"
          "hibernate.target"
          "hybrid-sleep.target"
        ];
        description = "Intel undervolting";
        serviceConfig = {
          ExecStart = ''
            ${pkgs.undervolt}/bin/undervolt \
              --core ${ucfg.coreOffset} \
              --cache ${ucfg.coreOffset} \
              --gpu ${ucfg.gpuOffset} \
              --uncore ${ucfg.uncoreOffset} \
              --analogio ${ucfg.analogioOffset}
          '';
        };
        wantedBy = [
          "suspend.target"
          "hibernate.target"
          "hybrid-sleep.target"
          "multi-user.target"
        ];
      };
    };

    timers = {
      undervolt = {
        enable = false;
      };
    };
  };
}
