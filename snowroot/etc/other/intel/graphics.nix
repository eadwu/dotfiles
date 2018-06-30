{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      intel-gpu-tools
    ];
  };

  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        libGL
        vaapiIntel
      ];
    };
  };
}
