{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      libva-utils
      intel-gpu-tools
    ];
  };

  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        vaapiIntel
      ];
    };
  };
}
