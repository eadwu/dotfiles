{ config, pkgs, ... }:

let
  settings = import /etc/nixos/settings.nix;
in with settings; {
  systemd = {
    services = {
      i3color = {
        before = [
          "sleep.target"
          "systemd-suspend.service"
          "systemd-hibernate.target"
        ];
        description = "i3lock with suspend/sleep";
        enable = true;
        environment = {
          DISPLAY = ":0";
        };
        serviceConfig = {
          Type = "forking";
          User = user;
        };
        script = ''
          image="$(mktemp).png"

          ${pkgs.ffmpeg}/bin/ffmpeg -y -s 1440x900 -probesize 10MB -f x11grab -i $DISPLAY -vframes 1 -vf "gblur=sigma=16" "$image"
          ${pkgs.imagemagick}/bin/convert "$image" "$HOME/.local/share/pixmaps/lock-overlay.png" -gravity center -composite "$image"
          ${pkgs.i3lock-color}/bin/i3lock-color -i "$image" \
            --verifcolor=FFFFFF00 \
            --wrongcolor=FFFFFF00 \
            --layoutcolor=FFFFFF00 \
            --insidecolor=FADDC500 \
            --ringcolor=FAFAFA00 \
            --linecolor=2D283E00 \
            --keyhlcolor=FABB5CAA \
            --ringvercolor=FADD5CAA \
            --separatorcolor=22222200 \
            --insidevercolor=FADD5C00 \
            --ringwrongcolor=F13459AA \
            --insidewrongcolor=F1345900
        '';
        wantedBy = [
          "sleep.target"
          "suspend.target"
          "hibernate.target"
        ];
      };

      powertop = {
        description = "Powertop tunings";
        enable = false;
        path = pkgs.powertop;
        serviceConfig = {
          ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune";
          Type = "oneshot";
        };
        wantedBy = [
          "multi-user.target"
        ];
      };
    };
  };
}
