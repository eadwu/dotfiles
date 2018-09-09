self: super:

let
  inherit (super) fetchgit;
in {
  dmenu = super.dmenu.overrideAttrs (oldAttrs: {
    src = fetchgit {
      url = "https://gitlab.com/eadwu/dmenu";
      rev = "eae2a506dab7168d030fb43a2fcb6c79fd601d8f";
      sha256 = "0a143vw1nap80xzbasqy0r82ky4v6ah1ffn4mfmjxwg3m82j00np";
    };
  });
  dwm = super.dwm.overrideAttrs (oldAttrs: {
    src = fetchgit {
      url = "https://gitlab.com/eadwu/dwm";
      rev = "e4c4a29f8f7139308b114dd3485cd5ae94238f52";
      sha256 = "0vjb1jrbplz9lrfhx7nwmpm2irj3qp688k8kjpardiakfbvmzx1a";
    };
  });
  st = super.st.overrideAttrs (oldAttrs: {
    src = fetchgit {
      url = "https://gitlab.com/eadwu/st";
      rev = "f43aa9382c0cc7a46a6a8d6e4b0c030ad8dce8e1";
      sha256 = "1bmsvqb4l4ayzandgb9awfr9d9minrgy0wvy6w7jkp7izij0q9jp";
    };
  });
}
