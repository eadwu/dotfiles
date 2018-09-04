{ pkgs, ... }:

let
  gmail = pkgs.fetchgit {
    url = https://github.com/vyachkonovalov/polybar-gmail;
    rev = "a5c299123ba6a0d748ae044958ddc165dcbb14df";
    sha256 = "1z6h1zzp0kllk0v3djs3axmbl5b7d6h7xk99mchyzgmn6xkhdm8s";
  };

  bspwmrc = pkgs.writeShellScriptBin "bspwmrc" ''
    bspc monitor -d web code model social game idle other

    bspc config border_width 0
    bspc config window_gap 0

    # Useless since space is reserved from Polybar
    bspc config top_padding 20
    bspc config bottom_padding 20
    bspc config left_padding 20
    bspc config right_padding 20

    bspc config split_ratio 0.52
    bspc config borderless_monocle true
    bspc config gapless_monocle true

    bspc desktop ^1 -l monocle
    bspc desktop ^2 -l monocle

    bspc rule -a Vivaldi-stable -o desktop=^1
    bspc rule -a Code -o desktop=^2
    bspc rule -a Blender -o desktop=^3
    bspc rule -a discord -o desktop=^4
    bspc rule -a EVE -o desktop=^5

    bspc rule -a Steam state=floating
    bspc rule -a Zenity state=floating
    bspc rule -a Nitrogen state=floating
    bspc rule -a Oblogout state=floating
    bspc rule -a Pinentry state=floating
    bspc rule -a Xfce4-screenshooter state=floating
    bspc rule -a Xfce4-notifyd-config state=floating

    bspc config click_to_focus any
    bspc config focus_follows_pointer true
    bspc config external_rules_command ~/.bspwm/external_rules

    bspc config presel_feedback_color \#aaaaaa
  '';

  external_rules = pkgs.writeShellScriptBin "external_rules" ''
    wid=$1
    class=$2
    instance=$3

    if [[ "$instance" == GLava ]]; then
      # Keep above xwinwrap (root window)
      # xdo above -t "$(xdo id -n root | sort | head -n 1)" $wid
      # Actually let's just put on top of everything
      xdo raise $wid
    else
      # Lower everything else
      xdo below -t "$(xdo id -a GLava)" $wid
    fi
  '';

  sxhkdrc = pkgs.writeText "sxhkdrc" ''
    #
    # wm independent hotkeys
    #

    # power off menu
    XF86PowerOff
      scrot /tmp/screenshot.png && oblogout

    # volume
    XF86AudioMute
      pactl set-sink-mute @DEFAULT_SINK@ toggle

    XF86Audio{LowerVolume,RaiseVolume}
      pactl set-sink-volume @DEFAULT_SINK@ {-5%,+5%}
    alt + XF86Audio{LowerVolume,RaiseVolume}
      pactl set-sink-volume @DEFAULT_SINK@ {-1%,+1%}

    # monitor brightness
    {_,alt +}XF86MonBrightness{Down,Up}
      sudo mon_backlight {1,5} {-,+}

    # keyboard brightness
    {_,alt +}XF86KbdBrightness{Down,Up}
      sudo kbd_backlight {1,5} {-,+}

    # reload bspwm
    # alt + Escape
      # killall sxhkd compton polybar redshift || true && ~/.bspwm/bspwmrc

    # reload polybar
    alt + shift + Escape
      polybar-msg cmd restart

    # make sxhkd reload its configuration files:
    alt + shift + r
      pkill -USR1 -x sxhkd

    # terminal emulator
    alt + grave
      urxvt -cd ~

    # program launcher
    alt + z
      rofi -show drun

    #
    # bspwm hotkeys
    #

    # quit bspwm normally
    # alt + shift + e
      # bspc quit

    # close and kill
    alt + {_,shift + }q
      bspc node -{c,k}

    # alternate between the tiled and monocle layout
    alt + space
      bspc desktop -l next

    # if the current node is automatic, send it to the last manual, otherwise pull the last leaf
    # super + y
      # bspc query -N -n focused.automatic && bspc node -n last.!automatic || bspc node last.leaf -n focused

    # swap the current node and the biggest node
    # alt + g
      # bspc node -s biggest

    #
    # state/flags
    #

    # set the window state
    alt + {t,shift + t,s,f}
      bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

    # set the node flags
    # super + ctrl + {x,y,z}
      # bspc node -g {locked,sticky,private}

    #
    # focus/swap
    #

    # focus the node in the given direction
    # super + {_,shift + }{h,j,k,l}
      # bspc node -{f,s} {west,south,north,east}

    # focus the node for the given path jump
    # super + {p,b,comma,period}
    # 	bspc node -f @{parent,brother,first,second}

    # focus the next/previous node
    # super + {_,shift + }c
      # bspc node -f {next,prev}

    # focus the next/previous desktop
    # super + bracket{left,right}
      # bspc desktop -f {prev,next}

    # focus the last node/desktop
    # super + {grave,Tab}
      # bspc {node,desktop} -f last

    # focus the older or newer node in the focus history
    # super + {o,i}
      # bspc wm -h off; \
      # bspc node {older,newer} -f; \
      # bspc wm -h on

    # focus or send to the given desktop
    alt + {_,shift + }{1-7}
      bspc {desktop -f,node -d} '^{1-7}'

    # focus the next/previous node in the same window
    # super + {comma,period}
      # bspc node -f {next,prev}.local

    #
    # preselect
    #

    # preselect the direction
    # super + ctrl + {h,j,k,l}
      # bspc node -p {west,south,north,east}

    # preselect the ratio
    # super + ctrl + {1-9}
      # bspc node -o 0.{1-9}

    # cancel the preselection for the focused node
    # super + ctrl + space
      # bspc node -p cancel

    # cancel the preselection for the focused desktop
    # super + ctrl + shift + space
      # bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

    #
    # move/resize
    #

    # expand a window by moving one of its side outward
    alt + ctrl + {h,j,k,l}
      bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

    # contract a window by moving one of its side inward
    alt + ctrl + shift + {h,j,k,l}
      bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

    # move a floating window
    # super + {Left,Down,Up,Right}
      # bspc node -v {-20 0,0 20,0 -20,20 0}

    # super + {equal,minus}
      # bspc config window_gap $(( $(bspc config window_gap) {+,-} 5 ))

    # super + ctrl + {Left,Right,Up,Down}
      # bspc node @focused:/ --rotate {270,90,180,180}
  '';

  weather_icons = pkgs.writeText "weather_icons" ''
    #! ${pkgs.python3}/bin/python3
    import datetime
    import requests

    CITY = "5115985"
    API_KEY = "e38905b6ac16fba9d18e85447d1f4547"
    UNITS = "imperial"
    # UNIT_KEY = "%{T6}%{T-}"
    UNIT_KEY = "F"

    REQ = requests.get(
        "http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units={}".format(CITY, API_KEY, UNITS))
    try:
        # HTTP CODE = OK
        if REQ.status_code == 200:
            CURRENT = REQ.json()["weather"][0]["description"].capitalize()
            ID = int(float(REQ.json()["weather"][0]["id"]))
            TEMP = int(float(REQ.json()["main"]["temp"]))
            HOUR = datetime.datetime.now().hour
        else:
            print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
    except (ValueError, IOError):
        print("Error: Unable print the data")

    if ID >= 200 and ID <= 232:  # thunderstorm
        ICON = "%{T6}%{T-}"
    elif ID >= 310 and ID <= 531:  # rain
        ICON = "%{T6}%{T-}"
    elif ID >= 600 and ID <= 622:  # snow
        ICON = "%{T6}%{T-}"
    elif ID >= 701 and ID <= 761:  # atmosphere
        ICON = "%{T6}%{T-}"
    elif ID >= 801 and ID <= 804:  # clouds
        if HOUR >= 6 and HOUR <= 18:  # morning?
            ICON = "%{T6}%{T-}"
        else:  # sunset
            ICON = "%{T6}%{T-}"
    elif ID >= 900 and ID <= 902 or ID >= 957 and ID <= 962:  # natural disaster
        ICON = "%{T6}%{T-}"
    elif ID == 903 or ID == 906:  # cold || hail
        ICON = "%{T6}%{T-}"
    elif ID == 904:  # hot
        ICON = "%{T6}%{T-}"
    elif ID == 905 or ID >= 951 and ID <= 956:  # wind
        ICON = "%{T6}%{T-}"
    else:
        if HOUR >= 6 and HOUR <= 18:  # morning?
            ICON = "%{T6}%{T-}"
        else:  # sunset
            ICON = "%{T6}%{T-}"
    # print("%%{F#e06c75}%s %%{F-}%i °%s" %
        #   (ICON, TEMP, UNIT_KEY))  # Icon without description
    print("%%{F#757575}%s %%{F-}%s, %i°%s" %
          (ICON, CURRENT, TEMP, UNIT_KEY))  # Icon with description
  '';
in {
  home = {
    file = {
      ".bspwm/bspwmrc" = {
        executable = true;
        source = bspwmrc;
      };

      ".bspwm/external_rules" = {
        executable = true;
        source = external_rules;
      };

      ".bspwm/sxhkdrc" = {
        source = sxhkdrc;
      };

      ".bspwm/weather_icons" = {
        executable = true;
        source = weather_icons;
      };
    };
  };

  services = {
    polybar = {
      enable = true;

      config = rec {
        settings = {
          compositing-foreground = "source";
        };

        colors = rec {
          # #00${xrdb:*background}
          background = "#002a0f21";
          # ${xrdb:*foreground}
          foreground = "#b8b8c5";

          color0 = background;
          color1 = ''''${xrdb:*color0}'';
          color2 = ''''${xrdb:*color1}'';
          color3 = ''''${xrdb:*color5}'';
        };

        "section/universal" = {
          monitor = "eDP-1";
          width = "100%";
          height = 25;
          offset-x = 0;
          offset-y = 0;
          enable-ipc = true;

          background = colors.background;
          foreground = colors.foreground;

          font-0 = "Liberation Mono:pixelsize=9;3";
          font-1 = "Font Awesome 5 Free:style=Regular:pixelsize=10;3";
          font-2 = "Font Awesome 5 Free:style=Solid:pixelsize=10;3";
          font-3 = "Font Awesome 5 Brands:pixelsize=10;3";
          font-4 = "Powerline Extra Symbols:pixelsize=17;4";
          font-5 = "Weather Icons:pixelsize=10;3";
          font-6 = "Unifont:pixelsize=10;3";

          wm-restack = "bspwm";
        };

        "bar/workspace" = {
          "inherit" = "section/universal";

          modules-left = "bspwm LSeperator0 weather LSeperator1 backlight LSeperator3 LSeperator4";
          # modules-center = "RSeperator4 RSeperator3 mpdInfo LSeperator2 LSeperator5";
          modules-right = "RSeperator RSeperator2 temperature0 temperature1 temperature2 cpu RSeperator0 memory";
        };

        "bar/stat" = {
          "inherit" = "section/universal";
          offset-y = 25;

          modules-left = "filesystem LSeperator1 network0 network1 LSeperator0 battery LSeperator1 volume LSeperator3 LSeperator4";
          # modules-center = "RSeperator4 RSeperator3 mpdControls LSeperator2 LSeperator5";
          modules-right = "RSeperator RSeperator2 arch RSeperator0 wm RSeperator1 date";
        };

        "module/LSeperator" = {
          type = "custom/text";
          content = "%{F-}";

          content-prefix = "%{T5}%{T-}";
          content-prefix-background = colors.color1;
          content-prefix-foreground = colors.color0;
          content-suffix = "%{T5}%{T-}";
          content-suffix-foreground = colors.color1;
        };

        "module/LSeperator0" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color2;
          content-background = colors.color1;
        };

        "module/LSeperator1" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color1;
          content-background = colors.color2;
        };

        "module/LSeperator2" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color3;
        };

        "module/LSeperator3" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color2;
        };

        "module/LSeperator4" = {
          type = "custom/text";
          content = "%{F-}";

          content-prefix = "%{T5}%{T-}";
          content-prefix-background = colors.color2;
          content-prefix-foreground = colors.color0;
          content-suffix = "%{T5}%{T-}";
          content-suffix-foreground = colors.color2;
        };

        "module/LSeperator5" = {
          type = "custom/text";
          content = "%{F-}";

          content-prefix = "%{T5}%{T-}";
          content-prefix-background = colors.color3;
          content-prefix-foreground = colors.color0;
          content-suffix = "%{T5}%{T-}";
          content-suffix-foreground = colors.color3;
        };

        "module/RSeperator" = {
          type = "custom/text";
          content = "%{F-}";

          content-prefix = "%{T5}%{T-}";
          content-prefix-foreground = colors.color1;
          content-suffix = "%{T5}%{T-}";
          content-suffix-background = colors.color1;
          content-suffix-foreground = colors.color0;
        };

        "module/RSeperator0" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color2;
          content-background = colors.color1;
        };

        "module/RSeperator1" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color1;
          content-background = colors.color2;
        };

        "module/RSeperator2" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color1;
        };

        "module/RSeperator3" = {
          type = "custom/text";
          content = "%{T5}%{T-}";
          content-foreground = colors.color3;
        };

        "module/RSeperator4" = {
          type = "custom/text";
          content = "%{F-}";

          content-prefix = "%{T5}%{T-}";
          content-prefix-foreground = colors.color3;
          content-suffix = "%{T5}%{T-}";
          content-suffix-background = colors.color3;
          content-suffix-foreground = colors.color0;
        };

        "module/bspwm" = {
          type = "internal/bspwm";
          ws-icon-default = "KISS";

          label-empty = "";
          label-empty-padding = 2;

          label-focused = "%{T3}%{T-}";
          label-focused-background = colors.color2;
          label-focused-foreground = colors.color1;
          label-focused-padding = 2;

          label-occupied = "%{T3}%{T-}";
          label-occupied-background = colors.color2;
          label-occupied-foreground = "#382e37";
          label-occupied-padding = 2;

          label-urgent = "%{T3}%{T-}";
          label-urgent-background = colors.color2;
          label-urgent-padding = 2;

          format = "<label-state>";
        };

        "module/weather" = {
          type = "custom/script";
          exec = ~/.bspwm/weather_icons;
          tail = true;
          interval = 600;

          label = "%{u#5d4037 +u}%output%%{-u}";
          label-background = colors.color1;
          label-padding = 1;
        };

        "module/backlight" = {
          type = "internal/backlight";
          card = "intel_backlight";

          format = "%{F#fff176}<ramp>%{F-} <bar>";
          format-background = colors.color2;
          format-padding = 1;
          format-underline = "#fbc02d";

          bar-empty = "%{T7}━%{T-}";
          bar-empty-foreground = colors.background;
          bar-fill = "%{T7}━%{T-}";
          bar-foreground-0 = colors.color1;
          bar-gradient = false;
          bar-indicator = "%{T7}━%{T-}";
          bar-indicator-foreground = colors.color1;
          bar-width = 8;

          ramp-0 = "%{T6}%{T-}";
          ramp-1 = "%{T6}%{T-}";
          ramp-2 = "%{T6}%{T-}";
          ramp-3 = "%{T6}%{T-}";
          ramp-4 = "%{T6}%{T-}";
          ramp-5 = "%{T6}%{T-}";
          ramp-6 = "%{T6}%{T-}";
          ramp-7 = "%{T6}%{T-}";
          ramp-8 = "%{T6}%{T-}";
          ramp-9 = "%{T6}%{T-}";
          ramp-10 = "%{T6}%{T-}";
          ramp-11 = "%{T6}%{T-}";
          ramp-12 = "%{T6}%{T-}";
          ramp-13 = "%{T6}%{T-}";
          ramp-14 = "%{T6}%{T-}";
        };

        "section/mpd" = rec {
          type = "internal/mpd";

          host = "127.0.0.1";
          port = 6600;
          password = "";

          interval = 1;

          format-offline-background = format-online-background;
          format-offline-padding = format-online-padding;
          format-online-background = colors.color3;
          format-online-padding = 1;
          format-paused-background = format-online-background;
          format-paused-padding = format-online-padding;
          format-playing-background = format-online-background;
          format-playing-padding = format-online-padding;
          format-stopped-background = format-online-background;
          format-stopped-padding = format-online-padding;
        };

        "module/mpdInfo" = rec {
          "inherit" = "section/mpd";

          label-offline = "";
          label-song = "%title:0:25:...%";
          label-time = "%elapsed% / %total%";

          format-offline = "<label-offline>";
          format-online = "<bar-progress> <label-time> <label-song>";
          format-paused = format-online;
          format-playing = format-online;
          format-stopped = format-online;

          bar-progress-empty = "%{T7}━%{T-}";
          bar-progress-fill = "%{T7}━%{T-}";
          bar-progress-indicator = "%{T7}┃%{T-}";
          bar-progress-width = 20;
        };

        "section/temperature" = {
          type = "internal/temperature";
          interval = "0.5";
          thermal-zone = 0;
          warn-temperature = 80;

          label-background = colors.color1;
          label-padding = 1;
          label-warn-background = colors.color1;
          label-warn-padding = 1;

          format = "%{F#a1887f}<ramp>%{F-}<label>";
          format-background = colors.color1;
          format-underline = "#5d4037";
          format-warn = "%{F#a1887f}<ramp>%{F-}<label-warn>";
          format-warn-background = colors.color1;
          format-warn-underline = "#5d4037";

          ramp-0 = "%{T3}%{T-}";
          ramp-1 = "%{T3}%{T-}";
          ramp-2 = "%{T3}%{T-}";
          ramp-3 = "%{T3}%{T-}";
          ramp-4 = "%{T3}%{T-}";
        };

        "module/temperature0" = {
          "inherit" = "section/temperature";
          hwmon-path = /sys/devices/platform/coretemp.0/hwmon/hwmon0/temp1_input;
        };

        "module/temperature1" = {
          "inherit" = "section/temperature";
          hwmon-path = /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input;
        };

        "module/temperature2" = {
          "inherit" = "section/temperature";
          hwmon-path = /sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input;
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = "0.5";

          format = "%{F#a1887f}%{F-} <ramp-coreload>";
          format-background = colors.color1;
          format-padding = 1;
          format-underline = "#5d4037";

          ramp-coreload-0 = "%{T7}▁%{T-}";
          ramp-coreload-1 = "%{T7}▂%{T-}";
          ramp-coreload-2 = "%{T7}▃%{T-}";
          ramp-coreload-3 = "%{T7}▄%{T-}";
          ramp-coreload-4 = "%{T7}▅%{T-}";
          ramp-coreload-5 = "%{T7}▆%{T-}";
          ramp-coreload-6 = "%{T7}▇%{T-}";
          ramp-coreload-7 = "%{T7}█%{T-}";
          ramp-coreload-foreground = colors.color2;
        };

        "module/memory" = {
          type = "internal/memory";
          interval = "0.5";

          format = " %{F#e57373}%{F-} <ramp-used>";
          format-background = colors.color2;
          format-padding = 1;
          format-underline = "#d32f2f";

          ramp-used-0 = "%{T7}▁%{T-}";
          ramp-used-1 = "%{T7}▂%{T-}";
          ramp-used-2 = "%{T7}▃%{T-}";
          ramp-used-3 = "%{T7}▄%{T-}";
          ramp-used-4 = "%{T7}▅%{T-}";
          ramp-used-5 = "%{T7}▆%{T-}";
          ramp-used-6 = "%{T7}▇%{T-}";
          ramp-used-7 = "%{T7}█%{T-}";
          ramp-used-foreground = colors.color1;
        };

        "module/github" = {
          type = "internal/github";
          empty-notifications = true;
          interval = 2;
          token = ''''${file:~/.bspwm/github.token}'';

          label = "%{u#90a4ae +u}%{A1:xdg-open 'https\://github.com/notifications/':}%{F#757575}%{F-} %notifications%%{A}%{-u}";
          label-background = colors.color1;
          label-padding = 1;
        };

        "module/gmail" = {
          type = "custom/script";
          exec = "~/.bspwm/gmail/launch.py --prefix '%{T3}%{T-}' --color '#ff8a65' --nosound";
          tail = true;

          label = "%{u#e64a19 +u}%output%%{-u}";
          label-background = colors.color2;
          label-padding = 1;

          click-left = "xdg-open https://mail.google.com/";
        };

        "module/filesystem" = {
          type = "internal/fs";
          mount-0 = /.;
          interval = 10;
          fixed-values = true;

          label-mounted = "%{F#ff8a65}%{F-} %used% / %total%";
          label-mounted-background = colors.color1;
          label-mounted-padding = 1;
          label-unmounted = "%{F#ff8a65}%{F-} N/A";
          label-unmounted-background = colors.color1;
          label-unmounted-padding = 1;

          format-mounted = "<label-mounted>";
          format-unmounted = "<label-unmounted>";

          format-mounted-underline = "#e64a19";
          format-unmounted-underline = "#e64a19";
        };

        "section/network" = {
          type = "internal/network";
          interval = "3.0";

          label-connected = "%{F#64b5f6}%{F-} %essid%";
          label-connected-background = colors.color2;
          label-connected-padding = 1;
          label-disconnected = "%{F#64b5f6}%{F-} N/A";
          label-disconnected-background = colors.color2;
          label-disconnected-padding = 1;

          format-connected = "<label-connected>";
          format-disconnected = "<label-disconnected>";
          format-packetloss = "<animation-packetloss> <label-connected>";

          format-connected-underline = "#1976d2";
          format-disconnected-underline = "#1976d2";
          format-packetloss-underline = "#1976d2";

          animation-packetloss-0 = "";
        };

        "module/network0" = {
          "inherit" = "section/network";
          interface = "wlp2s0";
        };

        "module/network1" = {
          "inherit" = "section/network";
          interface = "wlp59s0";
        };

        "module/battery" = {
          type = "internal/battery";
          full-at = 99;
          adapter = "ADP1";
          battery = "BAT0";
          time-format = "%H:%M";
          poll-interval = 5;

          label-full = "%{F#81c784}%{F-} %percentage%%";
          label-full-background = colors.color1;
          label-full-padding = 1;
          label-charging = "%percentage%% (%time%)";
          label-discharging = "%percentage%% (%consumption%, %time%)";

          format-full = "<label-full>";
          format-charging = "<animation-charging> <label-charging>";
          format-charging-background = colors.color1;
          format-charging-padding = 1;
          format-discharging = "<ramp-capacity> <label-discharging>";
          format-discharging-background = colors.color1;
          format-discharging-padding = 1;

          format-full-underline = "#388e3c";
          format-charging-underline = "#388e3c";
          format-discharging-underline = "#388e3c";

          ramp-capacity-0 = "%{F#e57373}%{F-}";
          ramp-capacity-1 = "%{F#e57373}%{F-}";
          ramp-capacity-2 = "%{F#fff176}%{F-}";
          ramp-capacity-3 = "%{F#81c784}%{F-}";
          ramp-capacity-4 = "%{F#81c784}%{F-}";

          animation-charging-0 = "%{F#e57373}%{F-}";
          animation-charging-1 = "%{F#e57373}%{F-}";
          animation-charging-2 = "%{F#fff176}%{F-}";
          animation-charging-3 = "%{F#81c784}%{F-}";
          animation-charging-4 = "%{F#81c784}%{F-}";
          animation-charging-framerate = 750;
        };

        "module/volume" = {
          type = "internal/alsa";

          label-muted = "%{F#e57373}%{F-} muted";

          format-muted = "<label-muted>";
          format-muted-underline = "#5d4037";
          format-muted-background = colors.color2;
          format-muted-padding = 1;
          format-volume = "%{F#e57373}<ramp-volume>%{F-} <bar-volume>";
          format-volume-background = colors.color2;
          format-volume-padding = 1;
          format-volume-underline = "#5d4037";

          bar-volume-empty = "%{T7}━%{T-}";
          bar-volume-empty-foreground = colors.background;
          bar-volume-fill = "%{T7}━%{T-}";
          bar-volume-foreground-0 = colors.color1;
          bar-volume-gradient = false;
          bar-volume-indicator = "%{T7}━%{T-}";
          bar-volume-indicator-foreground = colors.color1;
          bar-volume-width = 8;

          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-2 = "";
        };

        "module/mpdControls" = rec {
          "inherit" = "section/mpd";

          format-offline = "";
          format-online = "<icon-prev> <icon-seekb> <icon-stop> <toggle> <icon-seekf> <icon-next> <icon-random>";
          format-paused = format-online;
          format-playing = format-online;
          format-stopped = format-online;

          icon-consume = "";
          icon-next = "%{T3}%{T-}";
          icon-pause = "%{T3}%{T-}";
          icon-play = "%{T3}%{T-}";
          icon-prev = "%{T3}%{T-}";
          icon-random = "%{T3}%{T-}";
          icon-repeat = "";
          icon-repeatone = "";
          icon-seekb = "%{T3}%{T-}";
          icon-seekf = "%{T3}%{T-}";
          icon-stop = "%{T3}%{T-}";

          toggle-off-foreground = colors.color1;
          toggle-on-foreground = colors.foreground;
        };

        "module/arch" = {
          type = "custom/script";
          exec = ''echo "%{F#64b5f6}%{F-} $(uname -sr)"'';

          label-background = colors.color1;
          label-padding = 1;

          format-underline = "#1976d2";
        };

        "module/wm" = {
          type = "custom/script";
          exec = ''echo "%{F#e57373}%{F-} bspwm $(bspwm -version)"'';

          label-background = colors.color2;
          label-padding = 1;

          format-underline = "#d32f2f";
        };

        "module/date" = {
          type = "internal/date";
          interval = "1.0";
          date = "%a %b %d";
          time = "%I:%M %p";
          date-alt = "%A, %B %d %Y";
          time-alt = "%r";

          label = "%{F#81c784}%{F-} %date% %{F#81c784}%{F-} %time%";
          label-background = colors.color1;
          label-padding = 1;

          format-underline = "#388e3c";
        };
      };

      script = ''
        ${pkgs.polybar}/bin/polybar -r stat &
        ${pkgs.polybar}/bin/polybar -r workspace &
      '';
    };
  };
}
