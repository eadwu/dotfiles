{ config, pkgs, ... }:

{
  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        libGL
        vaapiIntel
      ];
    };
  };
}
