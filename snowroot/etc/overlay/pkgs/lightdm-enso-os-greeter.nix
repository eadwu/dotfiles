self: super:

let
  inherit (self.pkgs) fetchgit;
in {
  lightdm-enso-os-greeter = super.lightdm-enso-os-greeter.overrideAttrs (oldAttrs: {
    src = fetchgit {
      url = https://github.com/nick92/Enso-OS;
      rev = "91a064a4dcf469c1325be3806f016434e15da6e0";
      sha256 = "0y937zxsgdzja17hkr8gpz2yzjzydf90l0y0rsja29jawir8qqm6";
    };
  });
}
