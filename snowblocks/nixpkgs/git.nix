{ pkgs, ... }:

let
  gitignore = pkgs.fetchurl {
    name = "gitignore";
    url = "https://www.gitignore.io/api/c,r,git,c++,java,macos,linux,latex,elisp,emacs,cmake,intellij,database,visualstudiocode";
    sha256 = "1l61m21dqy99g9136r98ayjml9z6bh8w4a2ylgy16zavphjn338q";
  };

  queryWatchman = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/git/git/1fff303fc2b31d5005f38f55f38c4e8521da5a93/templates/hooks--fsmonitor-watchman.sample";
    sha256 = "1afzvaa9m52v8jdpaz9rm2zd09wf5dnyff0nvyp3dandnz5zzwyl";
    executable = true;
    postFetch = ''
      ${pkgs.gnused}/bin/sed -i 's@/usr@${pkgs.perl}@' $out
    '';
  };
in {
  home = {
    file = {
      "git/hooks/query-watchman" = {
        executable = true;
        source = queryWatchman;
      };
      "git/info/exclude" = {
        source = gitignore;
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
        [alias]
          plfs = !git -c filter.lfs.smudge= -c filter.lfs.required=false pull && git lfs pull

        [core]
          autocrlf = input
          editor = vim
          fsmonitor = ${queryWatchman}

        [credential]
          helper = cache --timeout=3600

        [init]
          templatedir = ~/git

        [lfs]
          pruneverifyremotealways = true

        [protocol]
          version = 2

        [filter "lfs"]
          clean = git-lfs clean -- %f
          smudge = git-lfs smudge -- %f
          process = git-lfs filter-process
          required = true
      '';
    };
  };
}
