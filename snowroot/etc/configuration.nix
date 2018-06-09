{ config, pkgs, ... }:

let
  uuid = "d43adf5e-b229-4884-a291-e62a6c697d81";
  hostname = "nixos";
  user = "yin";
  passwordFile = "/etc/nixos/passwords/${user}";

  HOME = "/home/${user}";
  DOCKER_ID_USER = "tianxian";
in {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    cleanTmpDir = true;

    initrd = {
      luks = {
        devices = [
          {
            name = "root";
            device = "/dev/disk/by-uuid/${uuid}";
            preLVM = true;
            allowDiscards = true;
          }
        ];
      };
    };

    kernel = {
      sysctl = {
        "fs.inotify.max_user_instances" = 1024;
        "fs.inotify.max_user_watches" = 524288;
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
      };
    };
  };

  environment = {
    shells = [
      "${pkgs.zsh}/bin/zsh"
    ];

    systemPackages = with pkgs; [
      # Core
      ntp
      openssl

      # Environment
      nitrogen
      (pkgs.polybar.override {
        githubSupport = true;
        mpdSupport = true;
      })
      xfce.thunar
      xfce.xfce4-notifyd
      xfce.xfce4-screenshooter
      xfce.xfce4-taskmanager
      ## Theme
      deepin.deepin-gtk-theme
      papirus-icon-theme

      # Other
      ## Applications
      (pkgs.ark.override {
        unfreeEnableUnrar = true;
      })
      discord
      gimp
      gnome3.pomodoro
      rxvt_unicode
      vivaldi
      (import /etc/nixos/pkgs/vscode-with-extensions.nix)
      xfce.mousepad
      ### VSCode
      #### latex-workshop
      perlPackages.YAMLTiny
      perlPackages.FileHomeDir
      perlPackages.UnicodeLineBreak
      ## Console
      feh
      libarchive
      mpd
      (pkgs.ncmpcpp.override {
        clockSupport = true;
        outputsSupport = true;
        visualizerSupport = true;
      })
      pass
      pipes
      pwgen
      pywal
      ranger
      rofi
      unrar
      unzip
      youtube-dl
      zip
      ### Applications
      vim
      ## Languages / SDKs
      fsharp
      git
      nodejs
      openjdk10
      python
      (python3.withPackages(ps: with ps; [
        # Dependencies
        ## Bspwm
        ### gmail
        google_api_python_client
        ### weather_icons
        requests
        ### VSCode Python
        autopep8
        pylint
      ]))
      rustup
      sass
      ### Build Tools
      cmake
      ## Misc
      bfg-repo-cleaner
      docker
      ffmpeg
      gnupg
      i3lock-color
      imagemagick7
      mono
      oblogout
      powertop
      stack
      texlive.combined.scheme-full
      watchman
      xclip
      xorg.xsetroot
      yarn

      # Debug / Utils
      lsof
      nix-prefetch-scripts
      pciutils
      xorg.xprop
    ];

    interactiveShellInit = ''
      export fpath=( "${HOME}/.zsh" $fpath )

      setopt histignorespace
    '';

    variables = {
      # General
      DOCKER_ID_USER = DOCKER_ID_USER;
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  fileSystems = {
    "/" = {
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };
  };

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      font-awesome_5
      liberation_ttf
      noto-fonts-cjk
      source-code-pro
      ubuntu_font_family
      unifont
    ];
  };

  hardware = {
    bluetooth = {
      enable = true;
    };

    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };

    pulseaudio = {
      configFile = pkgs.writeText "default.pa" ''
        #!/usr/bin/pulseaudio -nF
        #
        # This file is part of PulseAudio.
        #
        # PulseAudio is free software; you can redistribute it and/or modify it
        # under the terms of the GNU Lesser General Public License as published by
        # the Free Software Foundation; either version 2 of the License, or
        # (at your option) any later version.
        #
        # PulseAudio is distributed in the hope that it will be useful, but
        # WITHOUT ANY WARRANTY; without even the implied warranty of
        # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
        # General Public License for more details.
        #
        # You should have received a copy of the GNU Lesser General Public License
        # along with PulseAudio; if not, see <http://www.gnu.org/licenses/>.

        # This startup script is used only if PulseAudio is started per-user
        # (i.e. not in system mode)

        .fail

        ### Automatically restore the volume of streams and devices
        load-module module-device-restore
        load-module module-stream-restore
        load-module module-card-restore

        ### Automatically augment property information from .desktop files
        ### stored in /usr/share/application
        load-module module-augment-properties

        ### Should be after module-*-restore but before module-*-detect
        load-module module-switch-on-port-available

        ### Load audio drivers statically
        ### (it's probably better to not load these drivers manually, but instead
        ### use module-udev-detect -- see below -- for doing this automatically)
        #load-module module-alsa-sink
        #load-module module-alsa-source device=hw:1,0
        #load-module module-oss device="/dev/dsp" sink_name=output source_name=input
        #load-module module-oss-mmap device="/dev/dsp" sink_name=output source_name=input
        #load-module module-null-sink
        #load-module module-pipe-sink

        ### Automatically load driver modules depending on the hardware available
        .ifexists module-udev-detect.so
        load-module module-udev-detect
        .else
        ### Use the static hardware detection module (for systems that lack udev support)
        load-module module-detect
        .endif

        ### Automatically connect sink and source if JACK server is present
        .ifexists module-jackdbus-detect.so
        .nofail
        load-module module-jackdbus-detect channels=2
        .fail
        .endif

        ### Automatically load driver modules for Bluetooth hardware
        .ifexists module-bluetooth-policy.so
        load-module module-bluetooth-policy
        .endif

        .ifexists module-bluetooth-discover.so
        load-module module-bluetooth-discover
        .endif

        ### Load several protocols
        .ifexists module-esound-protocol-unix.so
        load-module module-esound-protocol-unix
        .endif
        load-module module-native-protocol-unix

        ### Network access (may be configured with paprefs, so leave this commented
        ### here if you plan to use paprefs)
        #load-module module-esound-protocol-tcp
        load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
        #load-module module-zeroconf-publish

        ### Load the RTP receiver module (also configured via paprefs, see above)
        #load-module module-rtp-recv

        ### Load the RTP sender module (also configured via paprefs, see above)
        #load-module module-null-sink sink_name=rtp format=s16be channels=2 rate=44100 sink_properties="device.description='RTP Multicast Sink'"
        #load-module module-rtp-send source=rtp.monitor

        ### Load additional modules from GConf settings. This can be configured with the paprefs tool.
        ### Please keep in mind that the modules configured by paprefs might conflict with manually
        ### loaded modules.
        .ifexists module-gconf.so
        .nofail
        load-module module-gconf
        .fail
        .endif

        ### Automatically restore the default sink/source when changed by the user
        ### during runtime
        ### NOTE: This should be loaded as early as possible so that subsequent modules
        ### that look up the default sink/source get the right value
        load-module module-default-device-restore

        ### Automatically move streams to the default sink if the sink they are
        ### connected to dies, similar for sources
        load-module module-rescue-streams

        ### Make sure we always have a sink around, even if it is a null sink.
        load-module module-always-sink

        ### Honour intended role device property
        load-module module-intended-roles

        ### Automatically suspend sinks/sources that become idle for too long
        load-module module-suspend-on-idle

        ### If autoexit on idle is enabled we want to make sure we only quit
        ### when no local session needs us anymore.
        .ifexists module-console-kit.so
        load-module module-console-kit
        .endif
        .ifexists module-systemd-login.so
        load-module module-systemd-login
        .endif

        ### Enable positioned event sounds
        load-module module-position-event-sounds

        ### Cork music/video streams when a phone stream is active
        load-module module-role-cork

        ### Modules to allow autoloading of filters (such as echo cancellation)
        ### on demand. module-filter-heuristics tries to determine what filters
        ### make sense, and module-filter-apply does the heavy-lifting of
        ### loading modules and rerouting streams.
        load-module module-filter-heuristics
        load-module module-filter-apply

        ### Make some devices default
        #set-default-sink output
        #set-default-source input

        ### Automatically switch to newly-connected devices
        load-module module-switch-on-connect
      '';
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };

  networking = {
    hostName = "nixos";

    nameservers = [
      "1.0.0.1"
    ];

    networkmanager = {
      enable = true;
    };
  };

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
    ];
    binaryCachePublicKeys = [
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    ];
    requireSignedBinaryCaches = true;
    trustedBinaryCaches = [
      "https://cache.nixos.org/"
    ];
    useSandbox = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  powerManagement = {
    enable = true;
  };

  programs = {
    oblogout = {
      enable = true;
      opacity = 40;
      bgcolor = "black";
      buttontheme = "simplistic";
      buttons = "logout, suspend, hibernate, restart, shutdown, cancel";
      cancel = "Escape";
      shutdown = "S";
      restart = "R";
      suspend = "U";
      logout = "L";
      lock = "";
      hibernate = "H";
      clogout = "bspc quit 1";
      clock = "";
      cswitchuser = "";
    };

    zsh = {
      enable = true;
      interactiveShellInit = ''
        function nix-clean () {
          nix-env --delete-generations old
          nix-store --gc --print-dead
          nix-collect-garbage -d
        }
      '';
      promptInit = ''
        autoload -U promptinit && promptinit && prompt pure
      '';
      shellAliases = {
        "download-audio" = "youtube-dl --extract-audio --audio-format mp3";
        "pass-hash" = ''openssl passwd -1 -salt "$(od -vAn -N4 -tu4 < /dev/urandom)"'';
      };
    };
  };

  security = {
    sudo = {
      extraRules = [
        {
          users = [ user ];
          commands = [
            {
              command = "${HOME}/.bspwm/bin/kbd_backlight";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${HOME}/.bspwm/bin/mon_backlight";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };

  services = {
    acpid = {
      enable = true;
    };

    avahi = {
      enable = true;
      nssmdns = true;
    };

    compton = {
      enable = true;
      fade = true;
      fadeDelta = 5;
      fadeSteps = [
        "0.03"
        "0.03"
      ];
      fadeExclude = [];
      shadow = true;
      shadowOffsets = [
        (-15)
        (-15)
      ];
      shadowOpacity = "0.5";
      shadowExclude = [
        "! name~=''"
        "name *= 'compton'"
        "name = 'Notification'"
        "class_g = 'Polybar'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
      activeOpacity = "0.95";
      inactiveOpacity = "0.85";
      menuOpacity = "0.95";
      opacityRules = [
        "99:name *?= 'EVE'"
        "99:class_g = 'Vivaldi-stable'"
        "85:class_g = 'Code'"
        "85:class_g = 'Code - Insiders'"
        "75:class_g = 'URxvt' && !_NET_WM_STATE@:32a"
        "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        "96:_NET_WM_STATE@:32a *= '_NET_WM_STATE_STICKY'"
      ];
      backend = "glx";
      vSync = "none";
      refreshRate = 0;
      extraOptions = ''
        # GLX backend
        glx-no-stencil = true;
        glx-copy-from-front = false;
        glx-swap-method = 1;

        # Shadows
        no-dnd-shadow = true;
        no-dock-shadow = true;
        clear-shadow = true;
        shadow-radius = 10;
        shadow-ignore-shaped = false;

        # Opacity
        frame-opacity = 1;
        inactive-opacity-override = false;
        alpha-step = 0.06;
        blur-background = true;
        blur-background-fixed = false;
        blur-background-exclude = [
          "window_type = 'desktop'"
        ];

        # Other
        mark-wmwin-focused = false;
        mark-ovredir-focused = false;
        use-ewmh-active-win = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        dbe = false;
        paint-on-overlay = true;
        sw-opti = false;
        unredir-if-possible = true;
        focus-exclude = [];
        detect-transient = true;
        detect-client-leader = true;

        wintypes:
        {
          tooltip =
          {
            fade = true;
            shadow = false;
            opacity = 0.85;
            focus = true;
          };
        };
      '';
    };

    logind = {
      extraConfig = ''
        #  This file is part of systemd.
        #
        #  systemd is free software; you can redistribute it and/or modify it
        #  under the terms of the GNU Lesser General Public License as published by
        #  the Free Software Foundation; either version 2.1 of the License, or
        #  (at your option) any later version.
        #
        # Entries in this file show the compile time defaults.
        # You can change settings by editing this file.
        # Defaults can be restored by simply deleting this file.
        #
        # See logind.conf(5) for details.

        [Login]
        #NAutoVTs=6
        #ReserveVT=6
        #KillUserProcesses=no
        #KillOnlyUsers=
        #KillExcludeUsers=root
        #InhibitDelayMaxSec=5
        HandlePowerKey=ignore
        #HandleSuspendKey=suspend
        #HandleHibernateKey=hibernate
        #HandleLidSwitch=suspend
        #HandleLidSwitchExternalPower=suspend
        #HandleLidSwitchDocked=ignore
        #PowerKeyIgnoreInhibited=no
        #SuspendKeyIgnoreInhibited=no
        #HibernateKeyIgnoreInhibited=no
        #LidSwitchIgnoreInhibited=yes
        #HoldoffTimeoutSec=30s
        #IdleAction=ignore
        #IdleActionSec=30min
        #RuntimeDirectorySize=10%
        #RemoveIPC=yes
        #InhibitorsMax=8192
        #SessionsMax=8192
        #UserTasksMax=33%
      '';
    };

    mpd = {
      enable = true;
      extraConfig = ''
        input {
          plugin "curl"
        }

        audio_output {
          type "pulse"
          name "pulse audio"
        }

        audio_output {
          type "pulse"
          name "Local Music Player Daemon"
          server "127.0.0.1"
        }

        audio_output {
          type "fifo"
          name "my_fifo"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
      musicDirectory = "${HOME}/Music";

      network = {
        listenAddress = "127.0.0.1";
        port = 6600;
      };
    };

    ntp = {
      enable = true;
    };

    printing = {
      drivers = [
        pkgs.hplip
      ];
      enable = true;
    };

    redshift = {
      enable = true;
      latitude = "40.7";
      longitude = "73.8";
    };

    tlp = {
      enable = true;
    };

    udisks2 = {
      enable = true;
    };

    xserver = {
      enable = true;
      layout = "us";

      desktopManager = {
        xterm = {
          enable = false;
        };
      };

      displayManager = {
        lightdm = {
          enable = true;

          greeters = {
            gtk = {
              enable = true;

              iconTheme = {
                name = "Papirus-Adapta-Nokto";
                package = pkgs.papirus-icon-theme;
              };

              theme = {
                name = "Adapta-Nokto-Eta";
                package = pkgs.adapta-gtk-theme;
              };
            };
          };
        };
      };

      libinput = {
        clickMethod = "buttonareas";
        disableWhileTyping = false;
        enable = true;
        middleEmulation = true;
        tapping = false;
      };

      windowManager = {
        default = "bspwm";

        bspwm = {
          configFile = "${HOME}/.bspwm/bspwmrc";
          enable = true;

          sxhkd = {
            configFile = "${HOME}/.bspwm/sxhkdrc";
          };
        };
      };
    };
  };

  time = {
    timeZone = "America/New_York";
  };

  users = {
    defaultUserShell = "${pkgs.zsh}/bin/zsh";
    extraUsers = {
      "${user}" = {
        createHome = true;
        extraGroups = [
          "docker"
          "networkmanager"
          "wheel"
        ];
        group = "users";
        home = "${HOME}";
        passwordFile = "${passwordFile}";
        uid = 1000;
        useDefaultShell = true;
      };
    };
    mutableUsers = false;
  };

  system = {
    autoUpgrade = {
      enable = true;
      channel = https://nixos.org/channels/nixos-unstable;
    };

    nixos = {
      stateVersion = "18.09";
    };
  };

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
