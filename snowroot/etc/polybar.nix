self: super:

let
  inherit (super) fetchgit;
in {
  polybar = (super.polybar.override {
    githubSupport = true;
    mpdSupport = true;
  }).overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = "https://github.com/jaagr/polybar";
      rev = "d1d307d5005a7acce47693a8179e5390fa9bc1c7";
      sha256 = "0slpmns2rv9c6dai306gnzphdjsvg7ciw0i242iwz11bchjqjcj0";
    };
  });
}
