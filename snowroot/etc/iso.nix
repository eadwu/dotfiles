{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  environment = {
    interactiveShellInit = ''
      alias emacs="${pkgs.emacs}/bin/emacs --no-window-system"
      alias emacs-nox="${pkgs.emacs}/bin/emacs --no-window-system"
      alias passhash="${pkgs.mkpasswd}/bin/mkpasswd -m sha-512"
    '';

    systemPackages = with pkgs; [
      git
      emacs
      mkpasswd
    ];
  };

  i18n = {
    consoleFont = "latarcyrheb-sun32";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
