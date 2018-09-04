{ pkgs, ... }:

let
  config = pkgs.writeText "config.cson" ''
    "*":
      "atom-clock":
        dateFormat: " [Cour] Q - MMMM Do YYYY, dddd, h:mm A"
        showClockIcon: true
      "atom-ide-ui":
        "atom-ide-diagnostics-ui":
          showDirectoryColumn: true
        hyperclick:
          darwinTriggerKeys: "ctrlKey,altKey,metaKey"
          linuxTriggerKeys: "altKey,metaKey"
          win32TriggerKeys: "altKey,metaKey"
        use: {}
      "atom-package-deps":
        ignored: [
          "linter-clang"
          "linter-eslint"
        ]
      "autocomplete-plus":
        backspaceTriggersAutocomplete: true
        confirmCompletion: "tab always, enter when suggestion explicitly selected"
        minimumWordLength: 1
        suggestionListFollows: "Cursor"
      core:
        autoHideMenuBar: true
        closeDeletedFileTabs: true
        disabledPackages: [
          "atom-ternjs"
          "linter-glsl"
          "linter-clang"
          "linter-xmllint"
          "linter-jsonlint"
          "linter-stylelint"
          "linter-moonscript"
          "linter-eslint"
        ]
        telemetryConsent: "limited"
        themes: [
          "bliss-ui"
          "nord-atom-syntax"
        ]
        useTreeSitterParsers: true
      docblockr:
        lower_case_primitives: true
      editor:
        fontFamily: "IBM Plex Mono, Anonymous Pro"
        fontSize: 12
        showInvisibles: true
      "exception-reporting":
        userId: "eb41a2a6-f07d-424b-b5c0-352fd0f466a5"
      filesize:
        UseDecimal: true
      "git-diff":
        showIconsInEditorGutter: true
      "git-plus":
        general:
          splitPane: "Right"
        tags:
          signTags: true
      "ide-flowtype":
        autoDownloadFlowBinaries: false
        customFlowPath:
          enabled: true
          flowPath: "/usr/bin/flow"
      "ide-java":
        javaHome: "/usr/lib/jvm/java-9-openjdk"
      "ide-typescript":
        javascriptSupport: false
      latex:
        engine: "xelatex"
        moveResultToSourceDirectory: false
        opener: "pdf-view"
        outputDirectory: ".."
      "linter-eslint":
        globalNodePath: "/usr"
        lintHtmlFiles: true
        scopes: [
          "source.js"
          "source.jsx"
          "source.js.jsx"
          "source.babel"
          "source.js-semantic"
          "text.html.basic"
        ]
      "linter-stylelint":
        disableWhenNoConfig: false
        useStandard: true
      "markdown-preview":
        useGitHubStyle: true
      minimap:
        plugins:
          "git-diff": true
          "git-diffDecorationsZIndex": 0
          "highlight-selected": true
          "highlight-selectedDecorationsZIndex": 0
      "package-status":
        packageList: [
          "atom-ternjs"
          "linter-glsl"
          "linter-clang"
          "linter-eslint"
          "linter-xmllint"
          "linter-jsonlint"
          "linter-stylelint"
          "linter-moonscript"
        ]
      "pdf-view":
        paneToUseInSynctex: "right"
        syncTeXPath: "/usr/bin/synctex"
      "sync-settings":
        _lastBackupHash: "b1cb6a97302a7e6655430c7a6c147ea18d79d1b3"
        gistDescription: "Atom configuration for Arch Linux"
        gistId: "3cf21fa5a80c6902213a3e1960cd9d3b"
        personalAccessToken: "c9ef7b530582ac552172abdfd0a1b97ed2d5715c"
      "tool-bar":
        iconSize: "16px"
        position: "Left"
      welcome:
        showOnStartup: false
  '';

  init = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/atom/atom/ef129f9491e303621f16c7806d716ad54ccd495b/dot-atom/init.coffee;
    sha256 = "15y0jgizyvd410p68cf8g56nmjmwna6i7szz6d9w9d2pyl57hvim";
  };

  keymap = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/atom/atom/1aa013ca7a4418498cfcb15b644d2142a0247a0c/dot-atom/keymap.cson;
    sha256 = "0gaq9042ssrsq06v1fnlgn8zbbqprynn4i4nv857pmwcsnwd8did";
  };

  snippets = pkgs.fetchurl {
    url = https://raw.githubusercontent.com/atom/atom/6fc3a364e1c43921fe0987e4e91ca254b364d33e/dot-atom/snippets.cson;
    sha256 = "1r7jmgilqn54yg4p4mjnlngzi485qqj9k6cf52ayn0d8hrp1a2rk";
  };

  styles = pkgs.writeText "styles.less" ''
    /*
     * Core Manipulation
     *
     * Italic text
     * Notification relocation
     */
    atom-text-editor {
      text-rendering: optimizeLegibility;
      -webkit-font-smoothing: antialiased;

      .cursor {
        transition: opacity 200ms;
      }

      .syntax--this,
      .syntax--null,
      .syntax--boolean,
      .syntax--comment,
      .syntax--attribute-name,
      .syntax--control:not(.syntax--at-rule),
      .syntax--storage.syntax--type:not(.syntax--arrow):not(.syntax--class) {
        font-style: italic;
      }
    }

    atom-notifications {
      top: auto;
      bottom: 20px;
    }

    /*
     * Package Manipulation
     */

    status-bar .inline-block {
      max-width: 100%;
    }
  '';
in {
  home = {
    file = {
      ".atom/config.cson" = {
        source = config;
      };

      ".atom/init.coffee" = {
        source = init;
      };

      ".atom/keymap.cson" = {
        source = keymap;
      };

      ".atom/snippets.cson" = {
        source = snippets;
      };

      ".atom/styles.less" = {
        source = styles;
      };
    };
  };
}
