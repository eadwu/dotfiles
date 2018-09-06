{ config, pkgs, ... }:

let
  backgrounds = pkgs.fetchgit {
    url = https://gitlab.com/eadwu/backgrounds;
    rev = "eb2ee548f9deeaab5b3865dd2e21f945604e7120";
    sha256 = "1s2kc6zlqzf8frh8ga4xzaixp4lnv9q358qim1wz15dql7rzw3ri";
  };
in {
  imports =
    [
      /etc/nixos/services/compton.nix
      /etc/nixos/services/mpd.nix
    ];

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    logind = {
      extraConfig = import /etc/nixos/services/logind/logind.conf.nix { };
    };

    printing = {
      enable = true;

      drivers = with pkgs; [
        hplip
      ];
    };

    redshift = {
      enable = true;
      latitude = "40.7";
      longitude = "-73.8";

      brightness = {
        day = "1";
        night = "0.8";
      };

      temperature = {
        day = 6504;
        night = 2700;
      };
    };

    tlp = {
      enable = true;
      extraConfig = ''
        CPU_SCALING_GOVERNOR_ON_AC=performance
        CPU_SCALING_GOVERNOR_ON_BAT=schedutil

        CPU_MIN_PERF_ON_AC=0
        CPU_MAX_PERF_ON_AC=100
        CPU_MIN_PERF_ON_BAT=0
        CPU_MAX_PERF_ON_BAT=40

        CPU_BOOST_ON_AC=1
        CPU_BOOST_ON_BAT=0
      '';
    };

    udev = {
      extraRules = ''
        # Automatically suspend the system at <5%
        SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="${pkgs.systemd}/bin/systemctl suspend"
      '';
    };

    xserver = {
      enable = true;
      layout = "us";

      desktopManager = {
        default = "none";

        xterm = {
          enable = false;
        };
      };

      displayManager = {
        lightdm = {
          enable = true;
          background = "${backgrounds}/Prinz-Eugen_Admiral.jpg";

          greeters = {
            enso = {
              blur = true;
              enable = true;
            };

            gtk = {
              clock-format = "%I:%M %p";

              iconTheme = {
                name = "Papirus-Adapta-Nokto";
                package = pkgs.papirus-icon-theme;
              };

              theme = {
                name = "Adapta-Nokto";
                package = pkgs.adapta-gtk-theme;
              };
            };
          };
        };
      };

      libinput = {
        clickMethod = "buttonareas";
        disableWhileTyping = true;
        enable = true;
        middleEmulation = true;
        tapping = true;
      };
    };
  };
}
