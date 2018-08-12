{ config, pkgs, ... }:

{
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
      drivers = [
        pkgs.hplip
      ];
      enable = true;
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
        CPU_MIN_PERF_ON_AC=0
        CPU_MAX_PERF_ON_AC=100
        CPU_MIN_PERF_ON_BAT=0
        CPU_MAX_PERF_ON_BAT=30

        CPU_BOOST_ON_AC=1
        CPU_BOOST_ON_BAT=0
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
