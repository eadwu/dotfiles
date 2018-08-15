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
      rev = "2a3b2b2b998d84df56800cd196315307d9d481fb";
      sha256 = "0yhmh50l0cmi3ib25jpf9j9gl24d83jzvfn0h3wibiqfdm4g6qh6";
    };
  });
}
