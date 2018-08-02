{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  environment = {
    interactiveShellInit = ''
      export fpath=( "${HOME}/.zsh" $fpath )

      setopt histignorespace
    '';

    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];

    systemPackages = with pkgs; [
      # Core
      openssl
      wget

      # Environment
      nitrogen
      xfceUnstable.thunar
      xfceUnstable.xfce4-notifyd
      xfceUnstable.xfce4-screenshooter
      xfceUnstable.xfce4-taskmanager
      ## Theme
      capitaine-cursors
      gnome3.adwaita-icon-theme
      gtk-engine-murrine
      papirus-icon-theme

      # Other
      ## Applications
      ark
      blender
      discord
      emacs
      gimp
      gnome3.gnome-disk-utility
      gnome3.pomodoro
      st
      vivaldi
      winusb
      xfce.mousepad
      ### Disk
      gptfdisk
      ### Emacs
      wakatime
      ## Console
      feh
      htop
      libarchive
      pass
      pipes
      powerstat
      pwgen
      pywal
      ranger
      rofi
      tree
      unrar
      unzip
      youtube-dl
      zip
      ### Applications
      vim
      ### Version Control
      gitlab
      gitAndTools.hub
      ## Languages / SDKs
      fsharp
      gcc
      git
      nodejs
      openjdk10
      python
      python3
      rustup
      sass
      ### Build Tools
      cmake
      ## Misc
      bfg-repo-cleaner
      llvmPackages.clang-unwrapped
      docker
      ffmpeg
      glava
      gnupg
      i3lock-color
      imagemagick7
      mono
      mpv
      oblogout
      pscircle
      rclone
      scrot
      stack
      texlive.combined.scheme-full
      watchman
      xclip
      xorg.xsetroot
      xwinwrap
      yarn

      # Benchmarks
      mprime
      unigine-valley

      # Debug / Utils
      lsof
      nix-prefetch-scripts
      pciutils
      usbutils
    ];

    variables = {
      # General
      EDITOR = "vim";
      VISUAL = "vim";
      DOCKER_ID_USER = DOCKER_ID_USER;
    };
  };
}
