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
      rev = "6025c25cce2f14ad723a58c8bcb27762bd4d985e";
      sha256 = "06ci1i8wrpngx5xlh188nn2gcvnpds77mdsgr2dqx3yw0ml213vp";
    };
  });
  st = super.st.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/st;
      rev = "ee204febe07dfbe65bb2c069a35a9fd70bb3e0c3";
      sha256 = "1b60rfrn9qhsak44zhs6vc6nxvpvc9bfvk5x8f3ysic2mn260069";
    };
  });
}
