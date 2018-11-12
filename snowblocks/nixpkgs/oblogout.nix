{ pkgs, ... }:

{
  home = {
    file = {
      ".themes/adeos-cores" = {
        source = "${pkgs.fetchFromGitHub {
          owner = "bruhensant";
          repo = "Adeos-Oblogout";
          rev = "dd25774c90f4802868d6e793c9185eb1b82e829a";
          sha256 = "0fmqhn2ij0nrpm6k82d7k33yck2fk2qa7c3yfd30z12nqr2pvy7z";
        }}/adeos-cores";
      };
    };
  };
}
