{ lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      eclipses.eclipse-platform
      (lib.lowPrio jdk)
      jetbrains.idea-community
      rstudioWrapper
    ];
  };

  xsession = {
    profileExtra = lib.mkForce "";
  };
}
