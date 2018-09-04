{ pkgs, ... }:

let
  config = pkgs.writeText "config" ''
    vo=gpu
    hwdec=vaapi
  '';
in {
  xdg = {
    configFile = {
      "mpv/config" = {
        source = config;
      };
    };
  };
}
