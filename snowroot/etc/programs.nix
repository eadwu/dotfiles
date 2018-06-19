{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
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
      clogout = "bspc quit 1"; #TODO: If comparison on package exist pkill -KILL -u $USER
      clock = "";
      cswitchuser = "";
    };

    zsh = {
      enable = true;
      interactiveShellInit = ''
        function nix-clean () {
          nix-env --delete-generations old
          nix-store --gc
          nix-channel --update
          nix-env -u --always
          for link in /nix/var/nix/gcroots/auto/*; do rm $(readlink "$link"); done
          nix-collect-garbage -d
        }
      '';
      promptInit = ''
        autoload -U promptinit && promptinit && prompt pure
      '';
      shellAliases = {
        "download-audio" = "youtube-dl --extract-audio --audio-format mp3";
        "nixos-rebuild-local" = "nixos-rebuild -I nixpkgs=${HOME}/Downloads/nixpkgs";
        "pass-hash" = ''openssl passwd -1 -salt "$(od -vAn -N4 -tu4 < /dev/urandom)"'';
        "sensors" = "nix-shell -p lm_sensors --run sensors";
        "xprop" = "nix-shell -p xorg.xprop --run xprop";
      };
    };
  };
}
