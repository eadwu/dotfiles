{ pkgs, ... }:

{
  imports =
    [
      ./common.nix
      # Machines
      # ./machines/usb.nix
      # Window Manager
      # ./bspwm.nix
      ./dwm.nix
      # Nvidia Optimus
      ./bumblebee.nix
    ];
}
