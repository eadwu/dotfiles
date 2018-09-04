{ pkgs, ... }:

{
  imports =
    [
      ./atom.nix
      ./git.nix
      ./gtk.nix
      ./mpv.nix
      ./ncmpcpp.nix
      ./rofi.nix
      ./vim.nix
      ./vivaldi.nix
      ./zsh.nix
      ./Xorg.nix
    ];

  home = {
    packages = with pkgs; [
      # Environment
      nitrogen
      xfceUnstable.thunar
      xfceUnstable.xfce4-notifyd
      xfceUnstable.xfce4-screenshooter
      xfceUnstable.xfce4-taskmanager
      ## Theme
      gnome3.adwaita-icon-theme
      gtk-engine-murrine

      # Other
      ## Applications
      ark
      blender
      discord
      emacs
      gimp
      gnome3.gnome-disk-utility
      gnome3.pomodoro
      google-musicmanager
      st
      vivaldi
      winusb
      xfce.mousepad
      ### Emacs
      wakatime
    ];
  };

  programs = {
    home-manager = {
      enable = true;
      path = https://github.com/rycee/home-manager/archive/master.tar.gz;
    };
  };

  nixpkgs = {
    config = import ./config.nix;
    overlays = import /etc/nixos/overlay;
  };
}
