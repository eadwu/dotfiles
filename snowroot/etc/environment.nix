{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  environment = {
    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];

    systemPackages = with pkgs; [
      # Applications
      rofi
      st
      ### Emacs
      wakatime
      # Console
      cachix
      home-manager

      feh
      gptfdisk
      htop
      libarchive
      openssl
      pass
      pywal
      ranger
      tree
      unrar
      unzip
      vim
      wget
      xclip
      zip
      ## Version Control
      gitlab
      gitAndTools.hub
      ## Languages / SDKs
      fsharp
      gcc
      git
      llvmPackages.clang-unwrapped
      mongodb
      mysql57
      nodejs
      openjdk10
      python
      python3
      rustup
      rWrapper
      sass
      texlive.combined.scheme-full
      ### Haskell
      stack
      ## Build Tools
      cmake
      ## Misc
      docker
      ffmpeg
      gnupg
      i3lock-color
      imagemagick7
      mono
      oblogout
      scrot
      watchman
      xorg.xsetroot

      # Debug / Utils
      lsof
      nix-prefetch-scripts
      pciutils
      usbutils
    ];

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
      DOCKER_ID_USER = DOCKER_ID_USER;
    };
  };
}
