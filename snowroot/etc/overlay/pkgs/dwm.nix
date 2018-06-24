self: super:

let
  inherit (super) fetchgit;
  settings = import /etc/nixos/settings.nix;
in with settings; {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/dwm;
      rev = "63affd3ee071f3e08d374164e67de39922e8b805";
      sha256 = "094cssy6ccbj3p0w4ggjvq12rpfh859ip48kfnxhk1c7nvyyc9cr";
    };
  });
}
