{ pkgs, ... }:

{
  xdg.configFile = {
    "Code/User/keybindings.json".source = ./code/keybindings.json;
    "Code/User/settings.json".source = ./code/settings.json;
    "Code - Insiders/User/keybindings.json".source = ./code/keybindings.json;
    "Code - Insiders/User/settings.json".source = ./code/settings.json;
  };

  home.packages = with pkgs; [
    vscode-with-extensions
    # dbaeumer.vscode-eslint
    nodePackages.eslint
    # ms-python.python
    python3Packages.autopep8
    python3Packages.flake8
    python3Packages.mypy
    python3Packages.pep8
    python3Packages.pydocstyle
    python3Packages.pylama
    python3Packages.pylint
    python3Packages.pytest
    python3Packages.yapf
  ];
}
