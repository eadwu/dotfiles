self: super:

let
  inherit (self.pkgs) fetchgit;
in {
  capitaine-cursors = super.capitaine-cursors.overrideAttrs (oldAttrs: {
    src = fetchgit {
      url = https://github.com/keeferrourke/capitaine-cursors;
      rev = "3ae9acee30f482677caa345ec702141a1db696c2";
      sha256 = "1kck0lpzwvcb8bbsvzsvvfyaa7cs1h0p5xfbn798lx0c281lis5q";
    };
  });
}
