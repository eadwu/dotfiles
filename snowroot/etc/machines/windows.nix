{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/other/nvidia
    ];

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  hardware = {
    opengl = {
      driSupport32Bit = true;
    };
  };

  services = {
    xserver = {
      autorun = true;
      monitorSection = ''
        DisplaySize 406 228
      '';

      videoDriverrs = [
        "nvidia"
        "modesetting"
      ];
    };
  };
}
