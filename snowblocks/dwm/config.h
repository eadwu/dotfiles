/* See LICENSE file for copyright and license details. */

#include "fibonacci.c"
#include <X11/XF86keysym.h>

/* appearance */
static const char* fonts[] = {
    "-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1",
};
static const char dmenufont[]
    = "-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1";

static const unsigned int borderpx = 0; /* border pixel of windows */
static const unsigned int snap = 32; /* snap pixel */
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 0; /* 0 means bottom bar */

static const char normbordercolor[] = "#333333";
static const char normbgcolor[] = "#1c1c1c";
static const char normfgcolor[] = "#666666";
static const char selbordercolor[] = "#666666";
static const char selbgcolor[] = "#1c1c1c";
static const char selfgcolor[] = "#eeeeee";

/* tagging */
static const char* tags[] = { "web", "code", "model", "social", "other" };

/* xprop(1):
 * WM_CLASS(STRING) = instance, class
 * WM_NAME(STRING) = title
 */
// class, instance, title, tags mask, isfloating, monitor
static const Rule rules[] = {
    // Assign windows to tags
    { "Vivaldi-stable", NULL, NULL, 1, 0, -1 },
    { "Code", NULL, NULL, 2, 0, -1 },
    { "Blender", NULL, NULL, 3, 0, -1 },
    { "discord", NULL, NULL, 4, 0, -1 },
    { "EVE", NULL, NULL, 5, 0, -1 },
    // Floating windows
    { "Steam", NULL, NULL, 0, 1, -1 },
    { "Zenity", NULL, NULL, 0, 1, -1 },
    { "Nitrogen", NULL, NULL, 0, 1, -1 },
    { "Oblogout", NULL, NULL, 0, 1, -1 },
    { "Pinentry", NULL, NULL, 0, 1, -1 },
    { "Xfce4-screenshooter", NULL, NULL, 0, 1, -1 },
    { "Xfce4-notifyd-config ", NULL, NULL, 0, 1, -1 },
};

/* layout(s) */
static const float mfact = 0.52; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1; /* number of clients in master area */
static const int resizehints
    = 0; /* 1 means respect size hints in tiled resizals */

// symbol, arrange function
static const Layout layouts[] = {
    { "[M]", monocle },
    { "[@]", spiral },
};

/* commands */
static char dmenumon[2]
    = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char* dmenucmd[]
    = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor,
          "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char* roficmd[] = { "rofi", "-show", "drun", NULL };
static const char* termcmd[] = { "urxvt", NULL };

static const char* kbdupcmd[] = { "sudo", "kbd_backlight", "5", "+", NULL };
static const char* kbddowncmd[] = { "sudo", "kbd_backlight", "5", "-", NULL };
static const char* monupcmd[] = { "sudo", "mon_backlight", "5", "+", NULL };
static const char* mondowncmd[] = { "sudo", "mon_backlight", "5", "-", NULL };
static const char* voldowncmd[]
    = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "-5%", NULL };
static const char* volupcmd[]
    = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "+5%", NULL };
static const char* mutecmd[]
    = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY, TAG)                                                      \
    { MODKEY, KEY, view, { .ui = 1 << TAG } },                                 \
        { MODKEY | ShiftMask, KEY, tag, { .ui = 1 << TAG } },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
    {                                                                          \
        .v = (const char* []) { "/usr/bin/env sh", "-c", cmd, NULL }           \
    }

static Key keys[] = {
    // general
    { MODKEY, XK_z, spawn, { .v = roficmd } },
    { MODKEY, XK_grave, spawn, { .v = termcmd } },
    // power off
    { 0, XF86XK_PowerOff, spawn,
        SHCMD("scrot /tmp/screenshot.png && oblogout") },
    // volume
    { 0, XF86XK_AudioMute, spawn, { .v = mutecmd } },
    { 0, XF86XK_AudioLowerVolume, spawn, { .v = voldowncmd } },
    { 0, XF86XK_AudioRaiseVolume, spawn, { .v = volupcmd } },
    // monitor brightness
    { 0, XF86XK_MonBrightnessDown, spawn, { .v = mondowncmd } },
    { 0, XF86XK_MonBrightnessUp, spawn, { .v = monupcmd } },
    // keyboard brightness
    { 0, XF86XK_KbdBrightnessDown, spawn, { .v = kbddowncmd } },
    { 0, XF86XK_KbdBrightnessUp, spawn, { .v = kbdupcmd } },
    // Other
    // { MODKEY, XK_b, togglebar, { 0 } },
    // { MODKEY, XK_j, focusstack, { .i = +1 } },
    // { MODKEY, XK_k, focusstack, { .i = -1 } },
    // { MODKEY, XK_i, incnmaster, { .i = +1 } },
    // { MODKEY, XK_d, incnmaster, { .i = -1 } },
    // { MODKEY, XK_h, setmfact, { .f = -0.05 } },
    // { MODKEY, XK_l, setmfact, { .f = +0.05 } },
    // { MODKEY, XK_Return, zoom, { 0 } },
    // { MODKEY, XK_Tab, view, { 0 } },
    { MODKEY | ShiftMask, XK_q, killclient, { 0 } },
    { MODKEY | ControlMask, XK_comma, cyclelayout, { .i = -1 } },
    { MODKEY | ControlMask, XK_period, cyclelayout, { .i = +1 } },
    { MODKEY, XK_space, togglefloating, { 0 } },
    // { MODKEY, XK_0, view, { .ui = ~0 } },
    // { MODKEY | ShiftMask, XK_0, tag, { .ui = ~0 } },
    // { MODKEY, XK_comma, focusmon, { .i = -1 } },
    // { MODKEY, XK_period, focusmon, { .i = +1 } },
    // { MODKEY | ShiftMask, XK_comma, tagmon, { .i = -1 } },
    // { MODKEY | ShiftMask, XK_period, tagmon, { .i = +1 } },
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8)
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or
 * ClkRootWin */
// click, event mask, button, function argument
static Button buttons[] = {
    { ClkLtSymbol, 0, Button1, setlayout, { 0 } },
    { ClkLtSymbol, 0, Button3, setlayout, { .v = &layouts[2] } },
    { ClkWinTitle, 0, Button2, zoom, { 0 } },
    { ClkStatusText, 0, Button2, spawn, { .v = termcmd } },
    { ClkClientWin, MODKEY, Button1, movemouse, { 0 } },
    { ClkClientWin, MODKEY, Button2, togglefloating, { 0 } },
    { ClkClientWin, MODKEY, Button3, resizemouse, { 0 } },
    { ClkTagBar, 0, Button1, view, { 0 } },
    { ClkTagBar, 0, Button3, toggleview, { 0 } },
    { ClkTagBar, MODKEY, Button1, tag, { 0 } },
    { ClkTagBar, MODKEY, Button3, toggletag, { 0 } },
};
