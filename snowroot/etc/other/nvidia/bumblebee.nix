{ config, pkgs, ... }:

let
  inherit (config.boot.kernelPackages) nvidia_x11_beta;
  settings = import /etc/nixos/settings.nix;

  naps = pkgs.writeShellScriptBin "naps" ''
    ## NAPS (Not A Prime Select)

    case "$1" in
      "init")
        echo "auto" > /sys/bus/pci/devices/0000:01:00.0/power/control
        ;;
      "status")
        cat "/sys/bus/pci/devices/0000:"$(lspci -vnn | grep 3D | awk '{print $1}')"/power/runtime_status"
        ;;
      *)
        $0 status
    esac
  '';
in with settings; {
  imports =
    [
      /etc/nixos/other/nvidia/polyfill.nix
    ];

  environment = {
    systemPackages = [
      naps
    ];
  };

  hardware = {
    bumblebee = {
      enable = true;
      package = nvidia_x11_beta;
      pmMethod = "none";
    };
  };

  nixpkgs = {
    overlays = [
      (self: super: with self.pkgs; {
        bumblebee = (super.bumblebee.override {
          nvidia_x11 = nvidia_x11_beta;
        }).overrideAttrs (oldAttrs: {
          src = fetchgit {
            url = "https://github.com/Bumblebee-Project/Bumblebee";
            rev = "9695e227756de45249ba98fce7103e446bd10d88";
            sha256 = "0cdcpx6mg51hw4in3vcwx8hjny4s8y20irpqzlrk53x83s52pz9y";
          };

          patchPhase = ''
            patch -p1 -i ${./983.patch}
            patch -p1 -i ${./module-unload.patch}
            patch -p1 -i ${./bumblebee.patch}
          '';

          configureFlags = oldAttrs.configureFlags
            ++ [
              "CONF_BRIDGE=virtualgl"
              "CONF_PRIMUS_LD_PATH=${primusLib}/lib"
            ];

          nativeBuildInputs = oldAttrs.nativeBuildInputs
            ++ [
              autoreconfHook
            ];
        });

        primusLib = super.primusLib.override {
          nvidia_x11 = nvidia_x11_beta;
        };
      })
    ];
  };

  security = {
    sudo = {
      extraConfig = ''
        ${user} ALL=(ALL:ALL) NOPASSWD: ${naps}/bin/naps
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
