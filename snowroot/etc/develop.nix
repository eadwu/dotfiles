{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      dwmstatus
    ];
  };
}
