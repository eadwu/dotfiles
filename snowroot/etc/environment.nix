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
      ntp
      openssl
      wget

      # Environment
      nitrogen
      polybar
      xfce.thunar
      xfce.xfce4-notifyd
      xfce.xfce4-screenshooter
      xfce.xfce4-taskmanager
      ## Theme
      deepin.deepin-gtk-theme
      papirus-icon-theme

      # Other
      ## Applications
      ark
      discord
      gimp
      gnome3.pomodoro
      rxvt_unicode
      vivaldi
      vscode-with-extensions
      xfce.mousepad
      ### VSCode
      xorg.libxkbfile
      #### latex-workshop
      perlPackages.YAMLTiny
      perlPackages.FileHomeDir
      perlPackages.UnicodeLineBreak
      ## Console
      feh
      libarchive
      pass
      pipes
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
      ## Languages / SDKs
      fsharp
      git
      nodejs
      openjdk10
      python
      (pkgs.python3.withPackages(ps: with ps; [
        # Dependencies
        ## Bspwm
        ### gmail
        google_api_python_client
        ### weather_icons
        requests
        ### VSCode Python
        autopep8
        pylint
      ]))
      rustup
      sass
      ### Build Tools
      cmake
      ## Misc
      bfg-repo-cleaner
      docker
      ffmpeg
      gnupg
      google-musicmanager
      i3lock-color
      imagemagick7
      mono
      oblogout
      powertop
      scrot
      stack
      texlive.combined.scheme-full
      watchman
      xclip
      xorg.xsetroot
      yarn

      # Debug / Utils
      lsof
      nix-prefetch-scripts
      pciutils
      xorg.xprop
    ];

    variables = {
      # General
      EDITOR = "vim";
      VISUAL = "vim";
      DOCKER_ID_USER = DOCKER_ID_USER;
    };
  };
}
