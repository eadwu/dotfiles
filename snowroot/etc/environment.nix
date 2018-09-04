{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  environment = {
    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];

    systemPackages = with pkgs; [
      openssl
      wget

      gptfdisk
      ## Console
      feh
      home-manager
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
      wallama-paper
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
      EDITOR = "vim";
      VISUAL = "vim";
      DOCKER_ID_USER = DOCKER_ID_USER;
    };
  };
}
