{ pkgs, lib, ... }:

{
  home = {
    file = {
      ".local/lib/vivaldi/libffmpeg.so" = {
        source = "${lib.makeLibraryPath [ pkgs.vivaldi-ffmpeg-codecs ]}/libffmpeg.so";
      };
    };
  };
}
