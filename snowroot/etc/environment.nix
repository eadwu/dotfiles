{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  environment = {
    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];

    systemPackages = with pkgs; [
      emacs
      gptfdisk
      openssl
      wget
      ### Emacs
      wakatime

      st
      feh
      home-manager
      htop
      libarchive
      pass
      pywal
      ranger
      rofi
      tree
      unrar
      unzip
      xclip
      youtube-dl
      zip
      vim
      ## Version Control
      gitlab
      gitAndTools.hub
      ## Languages / SDKs
      fsharp
      gcc
      git
      mongodb
      mysql57
      nodejs
      openjdk10
      python
      python3
      rustup
      rWrapper
      sass
      ## Build Tools
      cmake
      ## Misc
      bfg-repo-cleaner
      cachix
      llvmPackages.clang-unwrapped
      docker
      ffmpeg
      gnupg
      i3lock-color
      imagemagick7
      mono
      oblogout
      scrot
      stack
      texlive.combined.scheme-full
      watchman
      yarn

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
