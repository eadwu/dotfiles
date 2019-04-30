{ ... }:

{
  programs = {
    command-not-found.enable = true;

    zsh = {
      enable = true;
      enableCompletion = false;

      initExtra = ''
        docker-build () {
          docker build -t "$1" -f "$1/Dockerfile" .
        }

        docker-clean () {
          docker stop $(docker ps -aq)
          docker rm $(docker ps -aq)
          docker rmi $(docker images -q)
        }

        docker-push-image () {
          docker tag "$1" "''${DOCKER_ID_USER}/$1"
          docker push "''${DOCKER_ID_USER}/$1"
        }

        nix-upload-system () {
          {
            nix-build "<nixpkgs/nixos>" \
              -A config.system.build.toplevel \
              --no-out-link;

            nix-build "<home-manager/home-manager/home-manager.nix>" \
              -I home-manager=https://github.com/rycee/home-manager/archive/master.tar.gz \
              --argstr confAttr "" \
              --argstr confPath "$HOME/.config/nixpkgs/home.nix" \
              -A activationPackage \
              --no-out-link;
          } | cachix push config
        }
      '';
    };
  };
}
