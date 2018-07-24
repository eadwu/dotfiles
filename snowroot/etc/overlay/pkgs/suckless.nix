self: super:

let
  inherit (super) fetchgit;
  settings = import /etc/nixos/settings.nix;
in with settings; {
  dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/dmenu;
      rev = "eae2a506dab7168d030fb43a2fcb6c79fd601d8f";
      sha256 = "0a143vw1nap80xzbasqy0r82ky4v6ah1ffn4mfmjxwg3m82j00np";
    };
  });
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/dwm;
      rev = "c6e01987ffe0cffefc076742b56a8b2c8f41bf44";
      sha256 = "1mfi7kjbawypn6c83kb76i109x7j5a02w2lksbc9qm5yy116g8kl";
    };
  });
  st = super.st.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/st;
      rev = "f43aa9382c0cc7a46a6a8d6e4b0c030ad8dce8e1";
      sha256 = "1bmsvqb4l4ayzandgb9awfr9d9minrgy0wvy6w7jkp7izij0q9jp";
    };
  });
}
