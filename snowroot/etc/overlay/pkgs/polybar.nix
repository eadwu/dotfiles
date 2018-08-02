self: super:

let
  inherit (self.pkgs) fetchgit fetchpatch;
in {
  polybar = (super.polybar.override {
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  }).overrideAttrs (oldAttrs: {
    src = fetchgit {
      url = https://github.com/jaagr/polybar;
      rev = "58e269b2d66195808197ef9176cf25a834728f52";
      sha256 = "1p47m8qrgq8rs67w19ah3kgghclghqfr150brfk0w84mkx5jxd7h";
    };
  });
}
