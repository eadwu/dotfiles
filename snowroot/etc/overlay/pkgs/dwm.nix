self: super:

let
  inherit (super) fetchurl;
  settings = import /etc/nixos/settings.nix;
in with settings; {
  dwm = super.dwm.override {
    patches = [
      # config.h
      (/. + "${HOME}/.dwm/config.h.diff")
      # config.mk
      (/. + "${HOME}/.dwm/config.mk.diff")
      # cyclelayouts
      (fetchurl {
        url = https://dwm.suckless.org/patches/cyclelayouts/dwm-cyclelayouts-20180524-a09e766.diff;
        sha256 = "1ijslwbfmmznv4m5hadra8jcrds4zwky2m98d7cg8zdz3s9rva4q";
      })
      # fibonacci
      (fetchurl {
        url = https://dwm.suckless.org/patches/fibonacci/dwm-fibonacci-5.8.2.diff;
        sha256 = "06qavwzi9hgg3vcwfsrc520gwd4dcmawcsamcryhbisdbss2kr37";
      })
      # pertag
      (fetchurl {
        url = https://dwm.suckless.org/patches/pertag/dwm-pertag-6.1.diff;
        sha256 = "0sdlnwz1048hx4qw5mp1rf10npah9sg87w2g28a143pvw1srnzgv";
      })
      # ewmhtags
      (fetchurl {
        url = https://dwm.suckless.org/patches/ewmhtags/dwm-ewmhtags-6.1.diff;
        sha256 = "1gzf48bxi5hxv918j6isyj21z1xkgrch2zzaslwnf1hbvydnsz34";
      })
    ];
  };
}
