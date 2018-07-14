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
      rev = "e7a6148c73ba696a98346001a2575c4455539bf2";
      sha256 = "0plr1xycb046aircx0jg8lmjyv5hhwh3m954xci22yhcvch242q8";
    };
  });
  dwmstatus = super.dwmstatus.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/dwmstatus;
      rev = "f3c14a25d2858194460ad5d45787373ff2ee2996";
      sha256 = "0pmdq4mi9i7nv2a7x10435ckp46as21ap1pww902yvnrsdhwdil0";
    };
    buildInputs = oldAttrs.buildInputs ++ [
      super.alsaLib
    ];
  });
  slstatus = super.slstatus.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/slstatus;
      rev = "dd7f1896aa9883f33b4d28cd192e8088db0cab5a";
      sha256 = "1yibgvm543yrjrhfasxqkbxqdrcwr4j203p5fjzb0r78rqvg3hkd";
    };
  });
  st = super.st.overrideAttrs (oldAttrs: rec {
    src = fetchgit {
      url = https://gitlab.com/eadwu/st;
      rev = "77326466b636daee79f9a6fd946ac892c4997d09";
      sha256 = "0p1z05mzw07mwxh0p4j0mda0gzsg29xj1vizqpja95yl4i89jn0f";
    };
  });
}
