{ pkgs, ... }:

{
  home = {
    file = {
      "git/hooks/query-watchman" = {
        executable = true;
        source = git/query-watchman;
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
      '';
    };
  };
}
