{ pkgs, ... }:

{
  xsession = {
    profileExtra = ''
      sudo naps init
    '';
  };
}
