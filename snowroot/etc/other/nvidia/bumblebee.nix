{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  hardware = {
    bumblebee = {
      enable = true;
      package = config.boot.kernelPackages.nvidia_x11_beta;
      pmMethod = "none";
    };
  };

  nixpkgs = {
    overlays = [
      (self: super: {
        bumblebee = (super.bumblebee.override {
          nvidia_x11 = config.boot.kernelPackages.nvidia_x11_beta;
        }).overrideAttrs (oldAttrs: {
          src = self.pkgs.fetchgit {
            url = https://github.com/Bumblebee-Project/Bumblebee;
            rev = "9695e227756de45249ba98fce7103e446bd10d88";
            sha256 = "0cdcpx6mg51hw4in3vcwx8hjny4s8y20irpqzlrk53x83s52pz9y";
          };

          patchPhase = ''
            patch -p1 ${./bumblebee.patch}
          '';

          preConfigure = ''
            # Don't use a special group, just reuse wheel.
            substituteInPlace configure.ac \
              --replace 'CONF_GID="bumblebee"' 'CONF_GID="wheel"'

            # Apply configuration options
            substituteInPlace conf/xorg.conf.nvidia \
              --subst-var nvidiaDeviceOptions

            substituteInPlace conf/xorg.conf.nouveau \
              --subst-var nouveauDeviceOptions

            ${self.pkgs.autoconf}/bin/autoreconf -fi
          '';
        });
      })
    ];
  };

  security = {
    sudo = {
      extraConfig = ''
        ${user} ALL=(ALL:ALL) NOPASSWD: ${HOME}/bin/naps
      '';
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "modesetting"
      ];
    };
  };
}
