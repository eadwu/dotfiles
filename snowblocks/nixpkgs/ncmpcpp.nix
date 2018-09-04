{ pkgs, ... }:

let
  config = pkgs.writeText "config" ''
    mpd_host = localhost
    mpd_port = 6600
    mpd_music_dir = ~/Music

    visualizer_fifo_path = "/tmp/mpd.fifo"
    visualizer_output_name = "my_fifo"
    visualizer_in_stereo = "yes"
    visualizer_sync_interval = "30"
    visualizer_type = "spectrum"
    visualizer_look = "+|"
  '';
in {
  home = {
    file = {
      ".ncmpcpp/config" = {
        source = config;
      };
    };
  };
}
