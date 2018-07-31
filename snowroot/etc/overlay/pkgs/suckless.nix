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
      rev = "a74f37a12a12b7f235d86f3617180e92ff02f805";
      sha256 = "0ir5q4jb2c8wid415n8j0y5gpz0gw7apnrqm3p8r4m497mvqc8ar";
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
