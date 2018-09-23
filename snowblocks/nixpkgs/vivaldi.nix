{ pkgs, lib, ... }:

with import <nixpkgs> { };

let
  vivaldi-ffmpeg-codecs = stdenv.mkDerivation rec {
    name = "vivaldi-ffmpeg-codecs-${version}";
    version = "69.0.3497.81";

    src = pkgs.fetchurl {
      url = "http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_${version}-0ubuntu0.16.04.1_amd64.deb";
      sha256 = "0ajmdapsxdkhs720jghk565q2k8x774w6z84nk49kq2mw3y1z92p";
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
    file = {
      ".local/lib/vivaldi/libffmpeg.so" = {
        source = "${lib.makeLibraryPath [ vivaldi-ffmpeg-codecs ]}/libffmpeg.so";
      };
    };
  };
}
