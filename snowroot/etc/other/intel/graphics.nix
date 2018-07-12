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
        # vaapiIntel
      ];
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "modesetting"
      ];
    };
  };
}
