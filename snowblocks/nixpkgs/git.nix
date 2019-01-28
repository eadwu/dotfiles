{ pkgs, lib, ... }:

let
  gitignore = pkgs.stdenv.mkDerivation {
    name = "gitignore";

    outputHash = "3401wmbz1xa7pn5g3ym71s17jpd2xix57bmg1lh2sv7pdpfv074z3rfw1zl7sj7ipx4mdvrsz231i2g19q42akraj1n51rr7mhnc332";
    outputHashAlgo = "sha512";
    outputHashMode = "flat";

    buildInputs = lib.singleton pkgs.wget;

    buildCommand = ''
      wget "https://www.gitignore.io/api/c,r,git,c++,java,macos,linux,latex,elisp,emacs,cmake,intellij,database,visualstudiocode" \
        --ca-certificate=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt \
        -O $out
    '';
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
        key = "9C0561D4193A3AFE";
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
