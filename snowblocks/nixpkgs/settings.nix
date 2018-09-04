let
  settings = import /etc/nixos/settings.nix;
in rec {
  inherit (settings) user HOME DOCKER_ID_USER;
  dotfiles = /. + "${HOME}/Downloads/dotfiles";
}
