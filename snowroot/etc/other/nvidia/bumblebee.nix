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
            patch -p1 -i ${./bumblebee.patch}
          '';

          configureFlags = oldAttrs.configureFlags
            ++ [
              "CONF_BRIDGE=virtualgl"
              "CONF_PRIMUS_LD_PATH=${self.pkgs.primusLib}/lib"
            ];

          nativeBuildInputs = oldAttrs.nativeBuildInputs
            ++ [
              self.pkgs.autoreconfHook
            ];
        });

        primusLib = super.primusLib.override {
          nvidia_x11 = config.boot.kernelPackages.nvidia_x11_beta;
        };
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
