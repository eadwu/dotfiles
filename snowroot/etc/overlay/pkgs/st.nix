self: super:

let
  inherit (super) fetchurl;
  settings = import /etc/nixos/settings.nix;
in with settings; {
  st = super.st.override {
    patches = [
      # xresources
      (fetchurl {
        url = https://st.suckless.org/patches/xresources/st-xresources-20180309-c5ba9c0.diff;
        sha256 = "1qgck68sf4s47dckvl9akjikjfqhvrv70bip0l3cy2mb1wdlln6d";
      })
    ];
  };
}
