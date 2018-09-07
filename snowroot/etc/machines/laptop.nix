{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [
      # https://ivanvojtko.blogspot.com/2016/04/how-to-get-longer-battery-life-on-linux.html
      "i915.enable_fbc=1"
    ];
  };
}
