{ config, pkgs, ... }:

with import <nixpkgs> { };

let
  settings = import /etc/nixos/settings.nix;

  spaceship-prompt = stdenv.mkDerivation rec {
    name = "spaceship-prompt-${version}";
    version = "2018-08-26";

    src = pkgs.fetchgit {
      url = https://github.com/denysdovhan/spaceship-prompt;
      rev = "63a3611e4bd863f042113459752b365070f0c131";
      sha256 = "0h1l78jcr4v23vz1alb0p2iki2hmx2ndz8xjgsa7q1zgv9jxgxv6";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out

      cp -r lib $out
      cp -r sections $out
      cp spaceship.zsh $out/prompt_spaceship_setup
    '';
  };
in with settings; {
  programs = {
    oblogout = {
      enable = true;
      opacity = 40;
      bgcolor = "black";
      buttontheme = "simplistic";
      buttons = "logout, suspend, hibernate, restart, shutdown, cancel";
      cancel = "Escape";
      shutdown = "S";
      restart = "R";
      suspend = "U";
      logout = "L";
      lock = "";
      hibernate = "H";
      clogout = "pkill -KILL -u $USER";
      clock = "";
      cswitchuser = "";
    };

    zsh = {
      enable = true;
      interactiveShellInit = ''
        fpath+=(${spaceship-prompt})
        setopt histignorespace

        bios-upgrade () {
          ${pkgs.fwupd}/bin/fwupdmgr get-devices
          ${pkgs.fwupd}/bin/fwupdmgr get-updates
          ${pkgs.fwupd}/bin/fwupdmgr update
        }

        nix-clean () {
          nix-env --delete-generations old
          nix-store --gc
          nix-channel --update
          nix-env -u --always
          for link in /nix/var/nix/gcroots/auto/*; do rm $(readlink "$link"); done
          nix-collect-garbage -d
        }

        drill () { nix-shell -p ldns --run "drill "$@""; }
        file () { nix-shell -p file --run "file "$@""; }
        sensors () { nix-shell -p lm_sensors --run "sensors "$@""; }
        xprop () { nix-shell -p xorg.xprop --run "xprop "$@""; }
      '';
      promptInit = ''
        autoload -U promptinit
        promptinit
        prompt spaceship
      '';
      shellAliases = {
        "download-audio" = "youtube-dl --extract-audio --audio-format mp3";
        "emacs-nox" = "${pkgs.emacs}/bin/emacs --no-window-system";
        "nixos-rebuild-local" = "nixos-rebuild -I nixpkgs=${HOME}/Downloads/nixpkgs";
        "nixos-generate-iso" = ''nix-build "<nixpkgs/nixos>" -A config.system.build.isoImage -I nixos-config="${HOME}/Downloads/dotfiles/snowroot/etc/iso.nix" -I nixpkgs="${HOME}/Downloads/nixpkgs"'';
      };
    };
  };
}
