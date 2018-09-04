{ pkgs, ... }:

{
  xdg = {
    configFile = {
      "glava" = {
        source = ./glava;
      };
    };
  };
}
