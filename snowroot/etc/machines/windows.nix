{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/other/intel
      /etc/nixos/other/nividia
    ];

  boot = {
    kernelParams = [
      "acpi_rev_override acpi_osi=! acpi_osi='Windows 2009'"
    ];

    blacklistedKernelModules = [
      "nouveau"
    ];

    initrd = {
      luks = {
        devices = {
          cryptkey = {
            device = "";
          };

          cryptroot = {
            device = "";
            keyfile = /dev/mapper/cryptkey;
          };

          cryptswap = {
            device = "";
            keyfile = /dev/mapper/cryptkey;
          };
        };
      };
    };
  };
}
