{ config, pkgs, ... }:

{
  services = {
    dunst = {
      enable = true;

      iconTheme = {
        package = pkgs.paper-icon-theme;
        name = "Paper";
      };

      settings = {
        global = {
          transparency = 10;
          font = "Liberation Mono 10";
        };
      };
    };
  };
}
