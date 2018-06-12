{ }:

''
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
''
