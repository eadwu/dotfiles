{ pkgs, ... }:

let
  keybindings = pkgs.writeText "keybindings.json" ''
    // Place your key bindings in this file to overwrite the defaults
    [
      // REDEFINITIONS
      {
        "key": "alt+x",
        "command": "editor.action.toggleWordWrap"
      },
      {
        "key": "alt+z",
        "command": "-editor.action.toggleWordWrap"
      },
      // DISABLING
      {
        "key": "space",
        "command": "-list.toggleExpand",
        "when": "listFocus"
      },
      {
        "key": "ctrl+=",
        "command": "-workbench.action.zoomIn"
      },
      {
        "key": "ctrl+-",
        "command": "-workbench.action.zoomOut"
      },
      {
        "key": "ctrl+shift+g",
        "command": "-workbench.action.files.openFileFolder"
      },
      {
        "key": "ctrl+shift+=",
        "command": "-workbench.action.zoomIn"
      }
    ]
  '';

  settings = pkgs.writeText "settings.json" ''
    {
      "editor.codeActionsOnSave": {
        "source.organizeImports": true
      },
      "editor.cursorBlinking": "smooth",
      "editor.fontFamily": "'IBM Plex Mono', 'Anonymous Pro'",
      "editor.fontLigatures": true,
      "editor.fontSize": 16,
      "editor.fontWeight": "normal",
      "editor.formatOnSave": true,
      "editor.lineHeight": 24,
      "editor.lineNumbers": "relative",
      "editor.multiCursorModifier": "ctrlCmd",
      "editor.quickSuggestions": {
        "other": true,
        "comments": true,
        "strings": true
      },
      "editor.renderIndentGuides": false,
      "editor.renderWhitespace": "boundary",
      "editor.rulers": [
        100
      ],
      "editor.smoothScrolling": true,
      "editor.snippetSuggestions": "top",
      "editor.tabSize": 2,
      "editor.wordWrap": "off",
      "editor.minimap.showSlider": "always",
      "workbench.colorCustomizations": {
        "activityBarBadge.background": "#616161",
        "list.activeSelectionForeground": "#616161",
        "list.inactiveSelectionForeground": "#616161",
        "list.highlightForeground": "#616161",
        "scrollbarSlider.activeBackground": "#61616150",
        "editorSuggestWidget.highlightForeground": "#616161",
        "textLink.foreground": "#616161",
        "progressBar.background": "#616161",
        "pickerGroup.foreground": "#616161",
        "tab.activeBorder": "#616161",
        "notificationLink.foreground": "#616161",
        "editorWidget.border": "#616161"
      },
      "workbench.colorTheme": "Material Theme Darker",
      "workbench.iconTheme": "eq-material-theme-icons-darker",
      "workbench.sideBar.location": "right",
      "window.menuBarVisibility": "toggle",
      "files.associations": {
        "bspwmrc": "shellscript",
        "sxhkdrc": "shellscript",
        "*.pug": "jade",
        "*.conkyrc": "lua",
        "*.xmobarrc": "haskell",
        ".Xresources": "shellscript"
      },
      "files.exclude": {
        "**/.git": false,
        "**/.svn": true,
        "**/.hg": true,
        "**/CVS": true,
        "**/.DS_Store": false
      },
      "files.insertFinalNewline": true,
      "files.trimTrailingWhitespace": true,
      "explorer.confirmDelete": false,
      "explorer.confirmDragAndDrop": false,
      "explorer.decorations.badges": false,
      "explorer.decorations.colors": true,
      "terminal.external.linuxExec": "st",
      "terminal.integrated.experimentalTextureCachingStrategy": "dynamic",
      "update.channel": "none",
      "html.format.contentUnformatted": "pre,code,style,textarea",
      "html.format.extraLiners": "",
      "html.format.wrapLineLength": 0,
      "php.validate.run": "onType",
      "javascript.format.insertSpaceAfterConstructor": true,
      "javascript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces": true,
      "javascript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets": true,
      "javascript.format.insertSpaceBeforeFunctionParenthesis": true,
      "javascript.referencesCodeLens.enabled": true,
      "typescript.autoImportSuggestions.enabled": false,
      "typescript.format.insertSpaceAfterConstructor": true,
      "typescript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces": true,
      "typescript.format.insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets": true,
      "typescript.format.insertSpaceBeforeFunctionParenthesis": true,
      "typescript.implementationsCodeLens.enabled": true,
      "typescript.referencesCodeLens.enabled": true,
      "typescript.tsc.autoDetect": "watch",
      "extensions.autoUpdate": false,
      "git.autofetch": true,
      "git.confirmSync": false,
      "git.enableCommitSigning": true,
      "git.enableSmartCommit": true,
      "azure.resourceFilter": [
        "1058e020-f627-455f-ad47-64c8e6f99abf/375098e1-715e-41c8-b623-a5ff11033edc"
      ],
      "C_Cpp.clang_format_path": "/run/current-system/sw/bin/clang-format",
      "C_Cpp.clang_format_fallbackStyle": "LLVM",
      "C_Cpp.formatting": "Disabled",
      "cmake.cmakePath": "/run/current-system/sw/bin/cmake",
      "docker.attachShellCommand.linuxContainer": "/bin/zsh",
      "eslint.packageManager": "yarn",
      "eslint.validate": [
        "html",
        "javascript",
        "javascriptreact"
      ],
      "filesize.use24HourFormat": false,
      "FSharp.codeOutline": false,
      "FSharp.fsiFilePath": "/run/current-system/sw/bin/fsharpi",
      "FSharp.logLanguageServiceRequests": "both",
      "FSharp.logLanguageServiceRequestsOutputWindowLevel": "DEBUG",
      "FSharp.monoPath": "/run/current-system/sw/bin/mono",
      "gitlens.advanced.messages": {
        "suppressCommitHasNoPreviousCommitWarning": false,
        "suppressCommitNotFoundWarning": false,
        "suppressFileNotUnderSourceControlWarning": false,
        "suppressGitVersionWarning": false,
        "suppressLineUncommittedWarning": false,
        "suppressNoRepositoryWarning": false,
        "suppressResultsExplorerNotice": true,
        "suppressShowKeyBindingsNotice": true,
        "suppressUpdateNotice": false,
        "suppressWelcomeNotice": true
      },
      "gitlens.codeLens.scopes": [
        "document",
        "containers",
        "blocks"
      ],
      "gitlens.historyExplorer.enabled": true,
      "gitlens.keymap": "alternate",
      "java.completion.importOrder": [
        "extra",
        "java",
        "javax",
        "com",
        "org"
      ],
      "java.home": "/run/current-system/sw",
      "java.implementationsCodeLens.enabled": true,
      "java.referencesCodeLens.enabled": true,
      "java.saveActions.organizeImports": true,
      "jupyter.appendResults": false,
      "latex-workshop.chktex.enabled": true,
      "latex-workshop.chktex.path": "/run/current-system/sw/bin/chktex",
      "latex-workshop.latex.clean.enabled": true,
      "latex-workshop.latex.tools": [
        {
          "name": "latexmk",
          "command": "latexmk",
          "args": [
            "-f",
            "-cd",
            "-pdf",
            "-file-line-error",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-outdir=../",
            "-xelatex",
            "%DOC%"
          ]
        },
        {
          "name": "pdflatex",
          "command": "pdflatex",
          "args": [
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "%DOC%"
          ]
        },
        {
          "name": "bibtex",
          "command": "bibtex",
          "args": [
            "%DOCFILE%"
          ]
        }
      ],
      "latex-workshop.latexindent.path": "/run/current-system/sw/bin/latexindent",
      "latex-workshop.synctex.path": "/run/current-system/sw/bin/synctex",
      "latex-workshop.texcount.path": "/run/current-system/sw/bin/texcount",
      "latex-workshop.view.pdf.viewer": "tab",
      "materialTheme.accent": "Graphite",
      "npm.packageManager": "yarn",
      "path-intellisense.showHiddenFiles": true,
      "prettier.bracketSpacing": true,
      "prettier.disableLanguages": [
        "typescript",
        "typescriptreact"
      ],
      "prettier.eslintIntegration": true,
      "prettier.printWidth": 120,
      "prettier.requireConfig": true,
      "prettier.singleQuote": true,
      "prettier.stylelintIntegration": true,
      "python.linting.pep8Path": "/run/current-system/sw/bin/autopep8",
      "python.linting.pylintPath": "/run/current-system/sw/bin/pylint",
      "python.pythonPath": "/run/current-system/sw/bin/python3",
      "rust-client.rustupPath": "/run/current-system/sw/bin/rustup",
      "rust-client.updateOnStartup": true,
      "sync.autoDownload": false,
      "sync.autoUpload": false,
      "sync.askGistName": false,
      "sync.forceDownload": false,
      "sync.gist": "a2d589678ad127b1351ec7f8f0019298",
      "sync.host": "",
      "sync.lastDownload": "",
      "sync.lastUpload": "2018-06-18T01:47:07.306Z",
      "sync.pathPrefix": "",
      "sync.quietSync": true,
      "sync.removeExtensions": true,
      "sync.syncExtensions": false,
      "tslint.packageManager": "yarn",
      "tslint.validateWithDefaultConfig": true
    }
  '';
in {
  xdg = {
    configFile = {
      "Code/User/keybindings.json" = {
        source = keybindings;
      };

      "Code/User/settings.json" = {
        source = settings;
      };
    };
  };
}
