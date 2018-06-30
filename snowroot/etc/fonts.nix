{ config, pkgs, ... }:

{
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      font-awesome_5
      ibm-plex
      liberation_ttf
      noto-fonts-cjk
      ubuntu_font_family
      unifont
    ];
  };
}
