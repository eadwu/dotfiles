{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
      # Window Manager
      # ./bspwm.nix
      ./dwm.nix
      # Nvidia Optimus
      # ./bumblebee.nix
    ];
}
