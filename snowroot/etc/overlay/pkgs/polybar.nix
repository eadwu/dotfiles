self: super:

let
  inherit (super) fetchgit fetchpatch;
in {
  polybar = (super.polybar.override {
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  }).overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://github.com/jaagr/polybar;
      rev = "01fc545e096052dee2984fbbc985727afe38fca3";
      sha256 = "0v471id84nvp1l542ymjmnljc7apkcgx7cr017prra22cppsiimp";
    };

    patches = [
      /etc/nixos/overlay/patches/1322.patch
    ];
  });
}
