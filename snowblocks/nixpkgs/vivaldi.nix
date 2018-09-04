{ pkgs, ... }:

with import <nixpkgs> { };

let
  vivaldi-ffmpeg-codecs = stdenv.mkDerivation rec {
    name = "vivaldi-ffmpeg-codecs-${version}";
    version = "68.0.3440.106";

    src = fetchurl {
      url = "http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_${version}-0ubuntu0.16.04.1_amd64.deb";
      sha256 = "18pi0aacd48vnwxfib7asi1r99ihbzjh3c651jn0wvq836zxcavi";
    };

    unpackPhase = ''
      ${pkgs.libarchive}/bin/bsdtar xOf ${src} data.tar.xz | \
        ${pkgs.gnutar}/bin/tar xJf - ./usr/lib/chromium-browser/libffmpeg.so --strip 4
    '';

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/lib
      cp libffmpeg.so $out/lib
    '';
  };
in {
  home = {
    packages = [
      vivaldi-ffmpeg-codecs
    ];
  };
}
