{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;

  kbd_backlight = pkgs.writeShellScriptBin "kbd_backlight" ''
    # USAGE:
    #   sudo $PATH/bin/kbd_backlight {-|+}

    kl_smc=$([ -d /sys/class/leds/smc::kbd_backlight ] && printf "/sys/class/leds/smc::kbd_backlight" || printf "/sys/class/leds/dell::kbd_backlight")
    steps=$([ -d /sys/class/leds/smc::kbd_backlight ] && printf "%d" 15 || printf "%d" 2)
    tick=1

    case $1 in
      -)
        new=$(( $(cat $kl_smc/brightness) - $(cat $kl_smc/max_brightness) / ( $steps * $tick ) ))
        if (( $new < 0 )); then
          echo "0" | tee $kl_smc/brightness
          exit 1
        fi
        ;;
      +)
        new=$(( $(cat $kl_smc/brightness) + $(cat $kl_smc/max_brightness) / ( $steps * $tick ) ))
        if (( $new > $(cat $kl_smc/max_brightness) )); then
          echo "$(cat $kl_smc/max_brightness)" | tee $kl_smc/brightness
          exit 1
        fi
        ;;
    esac

    echo "$new" | tee $kl_smc/brightness
  '';

  mon_backlight = pkgs.writeShellScriptBin "mon_backlight" ''
    # USAGE:
    #   sudo $PATH/bin/mon_backlight {-|+}

    bl_intel=/sys/class/backlight/intel_backlight
    steps=15
    tick=1

    case $1 in
      -)
        new=$(( $(cat $bl_intel/actual_brightness) - $(cat $bl_intel/max_brightness) / ( $steps * $tick ) ))
        if (( $new < 0 )); then
          echo "0" | tee $bl_intel/brightness
          exit 1
        fi
        ;;
      +)
        new=$(( $(cat $bl_intel/actual_brightness) + $(cat $bl_intel/max_brightness) / ( $steps * $tick ) ))
        if (( $new > $(cat $bl_intel/max_brightness) )); then
          echo "$(cat $bl_intel/max_brightness)" | tee $bl_intel/brightness
          exit 1
        fi
        ;;
    esac

    echo "$new" | tee $bl_intel/brightness
  '';
in with settings; {
  imports =
    [
      /etc/nixos/dwm.nix
      /etc/nixos/general.nix
    ];

  environment = {
    systemPackages = [
      kbd_backlight
      mon_backlight
    ];
  };

  nix = {
    buildCores = 0;
    package = pkgs.nixUnstable;
    requireSignedBinaryCaches = true;
    useSandbox = true;

    binaryCaches = [
      "https://cache.nixos.org/"

      # Cachix
      "https://emacs.cachix.org"
      "https://linux.cachix.org"
      "https://qt5.cachix.org"
      "https://texlive.cachix.org"
      "https://wu.cachix.org"
    ];

    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="

      "emacs.cachix.org-1:BgvmrJ8yBNHewnYF2wsp+yrPz+Rx7zrLSsevcVrL3Lg="
      "linux.cachix.org-1:FgNkZq0e26bKnTHgvxT0Tz4bJxIuvbXY62bSyJbPxbc="
      "qt5.cachix.org-1:Ka/DtafK6EmdVWthzRpYo+N0j0X6j7gUOIfenczmV7s="
      "texlive.cachix.org-1:OWd0kb4Wkw8F7T0+sSAPzyOo/pH+NEqIhAWty25oCLk="
      "wu.cachix.org-1:cHow32fFlXna8uBQA6yoo+505O5eImitDtdXu2JYd0Y="
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = import /etc/nixos/overlay;
  };

  powerManagement = {
    enable = true;
  };

  security = {
    sudo = {
      extraConfig = ''
        ${user} ALL=(ALL:ALL) NOPASSWD: ${kbd_backlight}/bin/kbd_backlight
        ${user} ALL=(ALL:ALL) NOPASSWD: ${mon_backlight}/bin/mon_backlight
      '';
    };
  };
}
