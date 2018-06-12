{ config, pkgs, ... }:

{
  hardware = {
    pulseaudio = {
      configFile = pkgs.writeText "default.pa" (import /etc/nixos/hardware/pulseaudio/default.pa.nix { });
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };
}
