{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      #
    ];
  };

  hardware = {
    opengl = {
      extraPackages = with pkgs; [
      ];
    };
  };
}
