{ pkgs, ... }:

{
  xdg = {
    configFile = {
      "Code/User/keybindings.json" = {
        source = code/keybindings.json;
      };

      "Code/User/settings.json" = {
        source = code/settings.json;
      };
    };
  };
}
