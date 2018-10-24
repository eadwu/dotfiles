{ pkgs, ... }:

with import <nixpkgs> { };

let
  adeos-oblogout = stdenv.mkDerivation rec {
    name = "adeos-oblogout-${version}";
    version = "2017-10-14";

    src = pkgs.fetchgit {
      url = "https://github.com/bruhensant/Adeos-Oblogout";
      rev = "dd25774c90f4802868d6e793c9185eb1b82e829a";
      sha256 = "0fmqhn2ij0nrpm6k82d7k33yck2fk2qa7c3yfd30z12nqr2pvy7z";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/themes
      find . -mindepth 1 -maxdepth 1 -type d -exec cp -r "{}" $out/share/themes \;
    '';
  };
in {
  home = {
    file = {
      ".themes/adeos-cores" = {
        source = "${adeos-oblogout}/share/themes/adeos-cores";
      };
    };
  };
}
