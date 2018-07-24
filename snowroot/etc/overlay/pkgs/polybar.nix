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
      rev = "4cb0b1838939d78295e8f9acd32e9cf58865a798";
      sha256 = "18msm8ffpy2kdms2lxmj92f338vrlls23j5s7m9gspf10ivv2w1w";
    };
  });
}
