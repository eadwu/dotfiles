{ pkgs, ... }:

let
  queryWatchman = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/git/git/1fff303fc2b31d5005f38f55f38c4e8521da5a93/t/t7519/fsmonitor-watchman";
    sha256 = "0l1wbl3ba3nmlj9gpxphlpxg6pf9fimfamx10dw3m7v1idqgzh4p";
    postFetch = ''
      ${pkgs.gnused}/bin/sed -i 's@/usr@${pkgs.perl}@' $downloadedFile
    '';
  };
in {
  home = {
    file = {
      "git/hooks/query-watchman" = {
        executable = true;
        source = queryWatchman;
      };
    };
  };

  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Edmund Wu";
      userEmail = "fangkazuto@gmail.com";

      signing = {
        key = "43C9E53FFCF51DEC";
        signByDefault = true;
      };

      extraConfig = ''
        [core]
          autocrlf = input
          editor = vim
          fsmonitor = .git/hooks/query-watchman

        [init]
          templatedir = ~/git

        [protocol]
          version = 2
      '';
    };
  };
}
