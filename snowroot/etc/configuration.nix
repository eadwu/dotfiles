{ config, pkgs, ... }:

let
  uuid = "d43adf5e-b229-4884-a291-e62a6c697d81";
  hostname = "nixos";
  user = "yin";
  password = "yang";

  HOME = "/home/${user}";
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

      # Environment
      nitrogen
      polybar
      xfce.thunar
      xfce.xfce4-notifyd
      xfce.xfce4-screenshooter
      xfce.xfce4-taskmanager
      ## Theme
      deepin.deepin-gtk-theme
      papirus-icon-theme

      # Other
      ## Applications
      ark
      discord
      gimp
      gnome3.pomodoro
      rxvt_unicode
      vivaldi
      vscode-with-extensions
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
      ncmpcpp
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
      ## Misc
      bfg-repo-cleaner
      docker
      ffmpeg
      gnupg
      i3lock-color
      imagemagick7
      mono
      oblogout
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
      DOCKER_ID_USER = "tianxian";
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

      packageOverrides = pkgs: {
        ncmpcpp = pkgs.ncmpcpp.override {
          visualizerSupport = true;
        };

        polybar = pkgs.polybar.override {
          githubSupport = true;
          mpdSupport = true;
        };

        vscode-with-extensions = pkgs.vscode-with-extensions.override {
          vscodeExtensions = with pkgs.vscode-extensions; [
            bbenoist.Nix
            ms-vscode.cpptools
            ms-python.python
          ]

          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "auto-rename-tag";
              publisher = "formulahendry";
              version = "0.0.15";
              sha256 = "f1550037d78bd74844cb2876c21fb287323c53d5b56e638285377fef903fedc1";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "azure-account";
              publisher = "ms-vscode";
              version = "0.4.0";
              sha256 = "877662c2701a445e97a59fbea0d56d51bb7f94fcf54e547952925c3d95719ec0";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "cmake";
              publisher = "twxs";
              version = "0.0.17";
              sha256 = "0858af6b500efe81e9b336e977b94bb43cdbbf5622e79c903903cffe40931f86";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "code-settings-sync";
              publisher = "Shan";
              version = "2.9.2";
              sha256 = "48acfc7814d75d6e7f5010728f1f13055ad7afc5aaf9d579dc5cd2439d3c2753";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "csharp";
              publisher = "ms-vscode";
              version = "1.15.2";
              sha256 = "8e596639c1b7bfe7714164a5ab1e6e8025497851917d6db5586eb79a77e73e1e";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "debugger-for-chrome";
              publisher = "msjsdiag";
              version = "4.5.0";
              sha256 = "beedb3183ce91e4b828f6019b546aa8855deb0ebe200f1d8d341ee05012e30e3";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "githistory";
              publisher = "donjayamanne";
              version = "0.4.1";
              sha256 = "9fc8d0b6bae67a880efbe77fbbbd05c71400de857650afa20c014ec2d3eeb263";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "gitlens";
              publisher = "eamodio";
              version = "8.3.3";
              sha256 = "2ac60be573e2cddb764be76ab12c86ccfb7fa378dc066ee1001c6d70e0e3bc56";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "Ionide-FAKE";
              publisher = "Ionide";
              version = "1.2.3";
              sha256 = "49e896f331d6c1a39cf8e9512368f174864585ee9e4af6f59031acda58b74f46";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "Ionide-fsharp";
              publisher = "Ionide";
              version = "3.21.0";
              sha256 = "e05ed7818d58f348d9131b2702f02cfdea01f48c15f4414b29b4418393707dd7";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "Ionide-Paket";
              publisher = "Ionide";
              version = "1.11.1";
              sha256 = "3be4a94beb5aad4de8fe628b1e1233afb62d4d14d32557035daa2bb16e645fc5";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "java";
              publisher = "redhat";
              version = "0.26.0";
              sha256 = "79e601d0e470d7700eaa81c754475718c995a9755256d14738f176eb910a46c3";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "jupyter";
              publisher = "donjayamanne";
              version = "1.1.4";
              sha256 = "9e11714580dde1a65e7ab1479d67b7d976c5c8a541ef7ee4403d356d2e828d0a";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "language-haskell";
              publisher = "justusadam";
              version = "2.5.0";
              sha256 = "639987da2d55d524bc7e7e307e19593c2fd687ca4bc28f6852cdf4c231925882";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "latex-workshop";
              publisher = "James-Yu";
              version = "5.5.0";
              sha256 = "fed2250d547f04445eaacacd67bc3deac68a1bf5eed6f763062dd9095c546ecd";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "nord-wave";
              publisher = "dnlytras";
              version = "0.3.4";
              sha256 = "e01d5425b950d3c23b517b964bc44ec33ae2c947be48522c929742803cac3aac";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "path-intellisense";
              publisher = "christian-kohler";
              version = "1.4.2";
              sha256 = "248f3d5e785f2e9c032bd5c700c4a782738d1b47fec9c187686152cb4c424b44";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "prettier-vscode";
              publisher = "esbenp";
              version = "1.3.1";
              sha256 = "340c7af652710fef9bfc9e13a69fd969a5f21b1e70ae56e224623a8c5a7f34da";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "Ruby";
              publisher = "rebornix";
              version = "0.18.0";
              sha256 = "567959e717b7fd9d8ec0eef39a0214eeb3c47b7ce16cc1d2cc586cde05e18dc0";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "rust";
              publisher = "rust-lang";
              version = "0.4.4";
              sha256 = "6da4fc501fb18d26a626ed315a076fae890bc98d73336727de121686341742b7";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "solargraph";
              publisher = "castwide";
              version = "0.17.4";
              sha256 = "3f28c7d8280a59a1670a41ba0687ad94d0442e3ebefb5c8632e5a8c1eefeca61";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "stylelint";
              publisher = "shinnn";
              version = "0.36.3";
              sha256 = "19ac7904f22e4f615f0a1d054463d05c9d5d0d1e532f2464a4ef1c31f36dfd4c";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "tslint";
              publisher = "eg2";
              version = "1.0.30";
              sha256 = "0be8e8c0952787672bbc194b70e72dd0dcdc0033ba90a5a6b769a778af937a8f";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vs-keybindings";
              publisher = "ms-vscode";
              version = "0.2.0";
              sha256 = "4831b78db2a59ad9e61b2a54c5aa33ad4468b68f60351a942e9a0ea718dedd9c";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vsc-material-theme";
              publisher = "Equinusocio";
              version = "2.1.0";
              sha256 = "e15a6439a03b459faca0fdaaa047895236da4dfd48f04681ef33fcf4627e1ee6";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-code-outline";
              publisher = "patrys";
              version = "0.2.1";
              sha256 = "7ce047120791242f3274c904f0d751988072e9accb455a3e9dab230a449a1227";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-docker";
              publisher = "PeterJausovec";
              version = "0.0.27";
              sha256 = "f1bfd484dcde832b78d059d5b84e2e805d850af85af106b8e9a5cc4f6ed1d585";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-eslint";
              publisher = "dbaeumer";
              version = "1.4.10";
              sha256 = "86a5149f84c326ba6538223722e3f0e6d13b861e4171dfa599963af5b3b6b48a";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-filesize";
              publisher = "mkxml";
              version = "2.1.0";
              sha256 = "37fa0276205a22dcaaa2ff5e52db6e147f8c7c41eaaadced64a43c7f7b0dd63f";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-java-debug";
              publisher = "vscjava";
              version = "0.9.0";
              sha256 = "61e1cf349151e5240e7a3e6ea7dd2bb28857b01fae49bdfdcce8becb55a86b02";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-java-pack";
              publisher = "vscjava";
              version = "0.3.0";
              sha256 = "f88aa98eca7bbf4db95ff8af31959a1c7194345f6ffd483e55b531c90feaed73";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-java-test";
              publisher = "vscjava";
              version = "0.6.1";
              sha256 = "9f184e05af8cc6cf90851d8c1d882be5bbf96816cf3ac7e0605afcee7372389e";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-language-babel";
              publisher = "mgmcdermott";
              version = "0.0.14";
              sha256 = "25dc5742743b537a1478aa8629f931667ff5038f30804837623f57a1119f3c4d";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-maven";
              publisher = "vscjava";
              version = "0.8.0";
              sha256 = "6e5249e1b7080366fc29cc308be0aca0c16b0c43c92e0cb993ba73efaa204c3a";
            }
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-todo-highlight";
              publisher = "wayou";
              version = "0.5.12";
              sha256 = "672f29dfb38cf29bfe19e438569b2e3d1dccea029b2dbabf13522a0a08a8c565";
            }
          # ]
          # ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          #   {
          #     name = "vscode-wakatime";
          #     publisher = "WakaTime";
          #     version = "1.2.2";
          #     sha256 = "1cf4a4a3e0c35f293124e5613c29cfec850f67c0c43cec2ce1d8cc2e83aa217f";
          #   }
          # ]
          # ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          #   {
          #     name = "vsliveshare";
          #     publisher = "ms-vsliveshare";
          #     version = "0.3.262";
          #     sha256 = "78c35f07cdb3a182c25076b2d683d181daf0fdbc09e7f03dfff1bcbc31901b26";
          #   }
          ];
        };
      };
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
      promptInit = ''
        autoload -U promptinit && promptinit && prompt pure
      '';
    };
  };

  security = {
    sudo = {
      extraRules = [
        {
          users = [ "${user}" ];
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
      dataDir = "${HOME}/.config/mpd";
      musicDirectory = "${HOME}/Music";
      startWhenNeeded = true;

      network = {
        listAddress = "127.0.0.1";
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
        password = "${password}";
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
}
