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
      rev = "feb81b63118c8ef892ef0e07ceb8dfae53b509ce";
      sha256 = "05ycikzvrzh5gvzc8j5x7nmryzi0ayxd27dxmi69xw94s3qnbpjz";
    };
  });
  st = super.st.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/st;
      rev = "a9d55cd4071d8a15d22c82494833abe94f2eb96c";
      sha256 = "1m1szz8p5924ngl16658j05xjcfdn8sz1rvpd2b7cx5ms40543fc";
    };
  });
}
