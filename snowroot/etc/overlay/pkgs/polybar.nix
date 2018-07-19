self: super:

let
  inherit (super) fetchgit fetchpatch;
in {
  polybar = (super.polybar.override {
    githubSupport = true;
    mpdSupport = true;
  }).overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://github.com/jaagr/polybar;
      rev = "028b1413ef9490cdcb21348ea0ca704828ef538e";
      sha256 = "01mqwnlq7d9c503c5cnc19hl7hvk03fmih1wis7zljxdiz5hb82d";
    };

    patches = [
      (fetchpatch {
        url = https://github.com/jaagr/polybar/pull/1322.patch;
        sha256 = "1xvk5qhvg52x1fyqk7dw3f4w4hi595s3sa3qdg493vn2x3zzxfkq";
      })
    ];
  });
}
