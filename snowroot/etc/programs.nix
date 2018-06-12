{ config, pkgs, ... }:

{
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
      clogout = "bspc quit 1"; # TODO: conditional based on display manager
      clock = "";
      cswitchuser = "";
    };

    zsh = {
      enable = true;
      interactiveShellInit = ''
        function nix-clean () {
          nix-env --delete-generations old
          nix-store --gc --print-dead
          nix-collect-garbage -d
        }
      '';
      promptInit = ''
        autoload -U promptinit && promptinit && prompt pure
      '';
      shellAliases = {
        "download-audio" = "youtube-dl --extract-audio --audio-format mp3";
        "pass-hash" = ''openssl passwd -1 -salt "$(od -vAn -N4 -tu4 < /dev/urandom)"'';
      };
    };
  };
}
