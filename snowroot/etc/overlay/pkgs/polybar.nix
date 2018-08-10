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
      rev = "b632e7da38cc07c4b7fc6613e6f64d99533e3a81";
      sha256 = "09bdmmb3mwsb3ijqmqdf1ix4yqjmx26dq4p6dzzvxxsq6gndq7lq";
    };
  });
}
