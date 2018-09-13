{ lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      eclipses.eclipse-platform
      (lib.lowPrio jdk)
      rstudioWrapper
    ];
  };

  xsession = {
    profileExtra = lib.mkForce "";
  };
}
