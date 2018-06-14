{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
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

    ntp = {
      enable = true;
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
      longitude = "73.8";
    };

    tlp = {
      enable = true;
    };

    udisks2 = {
      enable = true;
    };

    xserver = {
      enable = true;
      layout = "us";

      desktopManager = {
        xterm = {
          enable = false;
        };
      };

      displayManager = {
        lightdm = {
          enable = true;

          greeters = {
            gtk = {
              enable = true;

              iconTheme = {
                name = "Papirus-Adapta-Nokto";
                package = pkgs.papirus-icon-theme;
              };

              theme = {
                name = "Adapta-Nokto-Eta";
                package = pkgs.adapta-gtk-theme;
              };
            };
          };
        };
      };

      libinput = {
        clickMethod = "buttonareas";
        disableWhileTyping = false;
        enable = true;
        middleEmulation = true;
        tapping = false;
      };

      windowManager = {
        default = "bspwm";

        bspwm = {
          configFile = "${HOME}/.bspwm/bspwmrc";
          enable = true;

          sxhkd = {
            configFile = "${HOME}/.bspwm/sxhkdrc";
          };
        };
      };
    };
  };
}