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
      rev = "0ae4de7d1e9b368f65a827451bca8548822d0699";
      sha256 = "1armjcsc66iyh40v6k74w24ajfq228xm8wgykrbg4anxj888n2y8";
    };
  });
}
