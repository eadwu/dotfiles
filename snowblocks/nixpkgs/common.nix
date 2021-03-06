{ pkgs, lib, ... }:

{
  imports =
    [
      ./atom.nix
      ./blender.nix
      ./code.nix
      ./dunst.nix
      ./edex-ui.nix
      ./emacs.nix
      ./glava.nix
      ./git.nix
      ./gtk.nix
      ./mpv.nix
      ./ncmpcpp.nix
      ./oblogout.nix
      ./rofi.nix
      ./ssh.nix
      ./vim.nix
      ./vivaldi.nix
      ./zsh.nix
      ./Xorg.nix
    ];

  home.packages = with pkgs; [
    # Environment
    nitrogen
    xfceUnstable.thunar
    xfceUnstable.xfce4-screenshooter
    xfceUnstable.xfce4-taskmanager
    ## Theme
    gtk-engine-murrine

    # Other
    ## Applications
    ark
    discord
    evince
    gimp
    gnome3.gnome-disk-utility
    google-musicmanager
    jetbrains.idea-ultimate
    rstudioWrapper
    winusb
    xfce.mousepad
    ## Console
    bfg-repo-cleaner
    file
    ldns
    lm_sensors
    pipes
    rclone
    xorg.xprop
    xwinwrap
    yarn
    youtube-dl

    # Benchmarks
    mprime
    unigine-valley
  ];

  nixpkgs = {
    config = import ./config.nix;
    overlays = lib.optional (builtins.pathExists <nixpkgs-overlays>) (import <nixpkgs-overlays>);
  };
}
