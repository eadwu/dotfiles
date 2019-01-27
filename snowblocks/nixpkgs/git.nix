{ pkgs, ... }:

let
  gitignore = pkgs.fetchurl {
    name = "gitignore";
    url = "https://www.gitignore.io/api/c,r,git,c++,java,macos,linux,latex,elisp,emacs,cmake,intellij,database,visualstudiocode";
    sha256 = "1l61m21dqy99g9136r98ayjml9z6bh8w4a2ylgy16zavphjn338q";
  };

  queryWatchman = pkgs.runCommand "fsmonitor-watchman" {
    src = "${pkgs.git}/share/git-core/templates/hooks/fsmonitor-watchman.sample";
    buildInputs = [ pkgs.gnused ];
  } ''
    sed 's@/usr@${pkgs.perl}@' $src > $out
    chmod +x $out
  '';
in {
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
          excludesfile = ${gitignore}
          fsmonitor = ${queryWatchman}

        [credential]
          helper = cache --timeout=3600

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
