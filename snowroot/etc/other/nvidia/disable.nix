{ config, pkgs, ... }:

{
  boot = {
    blacklistedKernelModules = [
      "nvidia"
      "nouveau"
    ];
  };

  hardware = {
    nvidiaOptimus = {
      disable = true;
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
