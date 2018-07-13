{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/other/nvidia
    ];

  environment = {
    systemPackages = with pkgs; [
      glxinfo
    ];
  };

  hardware = {
    opengl = {
      driSupport32Bit = true;
    };

    bumblebee = {
      driver = "nvidia";
      enable = false;
      pmMethod = "bbswitch";
    };
  };

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  services = {
    xserver = {
      autorun = true;
      monitorSection = ''
        DisplaySize 406 228
      '';

      videoDrivers = [
        "nvidia"
        "modesetting"
      ];
    };
  };
}
