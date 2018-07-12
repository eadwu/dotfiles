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
      rev = "e16894859e4074c9f1835dbc00a69f4c28c0ef4b";
      sha256 = "18hdk7j4id1k8r80bh9hycaj802v0wn9nciwyngjraqmb73bafip";
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
