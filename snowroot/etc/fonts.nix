{ config, pkgs, ... }:

{
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      font-awesome_5
      liberation_ttf
      noto-fonts-cjk
      source-code-pro
      ubuntu_font_family
      unifont
    ];
  };
}
