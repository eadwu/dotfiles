{ config, pkgs, ... }:

{
  powerManagement = {
    enable = true;

    powertop = {
      enable = true;
    };
  };
}
