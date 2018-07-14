{ config, pkgs, ... }:

{
  hardware = {
    bumblebee = {
      enable = true;
      pmMethod = "bbswitch";
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "nvidia"
        "modesetting"
      ];
    };
  };
}
