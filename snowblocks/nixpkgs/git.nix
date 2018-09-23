{ pkgs, ... }:

let
  gitignore = pkgs.fetchurl rec {
    name = "gitignore";
    url = "https://www.gitignore.io/api/r,git,java,elisp,emacs,latex,linux,macos,intellij,database,visualstudiocode";
    sha256 = "0fypkg761aysi9ri5lp7dy6i4v21hkrksd5i8a1hdm5dgan13w23";
  };

  queryWatchman = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/git/git/1fff303fc2b31d5005f38f55f38c4e8521da5a93/templates/hooks--fsmonitor-watchman.sample";
    sha256 = "0jmpcqw8k3gfis4bwrn9hrd5kkpq0mzx9dmayqdfnj2krmg7apxw";
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
          excludesfile = ${gitignore}
          fsmonitor = .git/hooks/query-watchman

        [init]
          templatedir = ~/git

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
