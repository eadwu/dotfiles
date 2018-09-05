{ lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      eclipses.eclipse-platform
      (lib.lowPrio jdk)
      jetbrains.idea-community
    ];
  };

  xsession = {
    profileExtra = lib.mkForce "";
  };
}
