{ config, pkgs, ... }:

{
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
