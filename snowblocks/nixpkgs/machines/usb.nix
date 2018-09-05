{ lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      eclipses.eclipse-platform
      (lib.lowPrior jdk)
      jetbrains.idea-community
    ];
  };

  xsession = {
    profileExtra = lib.mkForce "";
  };
}
