{ pkgs, ... }:

let
  gtk-theme-collections = pkgs.stdenv.mkDerivation rec {
    name = "gtk-theme-collections-${version}";
    version = "2018-08-30";

    src = pkgs.fetchgit {
      url = "https://github.com/addy-dclxvi/gtk-theme-collections";
      rev = "3e42534725b23feb63f5940aecfc6eccaf00d184";
      sha256 = "1illjld7mg7g6ws1pm9j3hzs216v1zmhh6b3yrmybkdlyzlq7czr";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/themes
      find . -mindepth 1 -maxdepth 1 -type d -exec cp -r "{}" $out/share/themes \;
    '';
  };
in {
  gtk = {
    enable = true;

    font = {
      name = "IBM Plex Mono";
      package = pkgs.ibm-plex;
    };

    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };

    theme = {
      name = "Fantome";
      package = gtk-theme-collections;
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
