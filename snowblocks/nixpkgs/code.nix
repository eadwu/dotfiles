{ ... }:

{
  xdg = {
    configFile = {
      "Code/User/keybindings.json" = {
        source = code/keybindings.json;
      };

      "Code/User/settings.json" = {
        source = code/settings.json;
      };

      "Code - Insiders/User/keybindings.json" = {
        source = code/keybindings.json;
      };

      "Code - Insiders/User/settings.json" = {
        source = code/settings.json;
      };
    };
  };
}
