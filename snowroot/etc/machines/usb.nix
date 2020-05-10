{ config, pkgs, lib, ... }:

{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    kernelModules = [
      "uas"
    ];
  };
}
