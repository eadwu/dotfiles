{ lib, pkgs, ... }:

{
  xsession = {
    profileExtra = lib.mkForce "";
  };
}
