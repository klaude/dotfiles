------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Dell Inc. DELL U2722DE FTJ2DH3
-- External monitor, centered horizontally
hl.monitor({
    output = "DP-3",
    mode = "2560x1440@59.95",
    position = "-130x0",
    scale = 1,
})

-- California Institute of Technology 0x1402
-- Laptop monitor, under the external monitor
hl.monitor({
    output = "eDP-1",
    mode = "2880x1800@90",
    position = "0x1440",
    scale = 1.25,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local fileManager = "Thunar"
local menu = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("swaync &")
    hl.exec_cmd("blueman-applet &")
    -- Wallpaper
    hl.exec_cmd("swaybg --mode fill --image ~/Documents/Wallpapers/wallhaven-w58vvr.jpg")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Toolkit Backend Variables
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables#toolkit-backend-variables
-- GTK: Use wayland if available. If not: try x11, then any other GDK backend.
hl.env("GDK_BACKEND", "wayland,x11,*")
-- Qt: Use wayland if available, fall back to x11 if not.
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- Run SDL2 applications on Wayland. Remove or set to x11 if games that provide
-- older versions of SDL cause compatibility issues
hl.env("SDL_VIDEODRIVER", "wayland")
-- Clutter package already has wayland enabled, this variable will force Clutter
-- applications to try and use the Wayland backend
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG Specifications
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables#qt-variables
-- XDG specific environment variables are often detected through portals and
-- applications that may set those for you, however it is not a bad idea to set
-- them explicitly.
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Qt Variables
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables#qt-variables
-- (From the Qt documentation) enables automatic scaling, based on the monitor’s
-- pixel density
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
-- Disables window decorations on Qt applications
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- Tells Qt based applications to pick your theme from qt5ct, use with Kvantum.
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- Electron >28 apps (may help)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    -- https://wiki.hypr.land/Configuring/Basics/Variables#general
    general = {
        gaps_in = 3,
        gaps_out = 0,
        border_size = 0,

        -- Set to true to enable resizing windows by clicking and dragging on
        -- borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
        -- before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables#decoration
    decoration = {
        rounding = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.1,

        shadow = {
            enabled = false,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables#blur
        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        -- You probably want this
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        -- Set to 0 or 1 to disable the anime mascot wallpapers
        force_default_wallpaper = 1,
        -- If true disables the random hyprland logo / anime girl background. :(
        disable_hyprland_logo = true,
    },
})

---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables#input
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,

        -- -1.0 - 1.0, 0 means no modification.
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
            tap_to_click = false,
        },

        touchdevice = {
            enabled = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Sets "Windows" key as main modifier
local mainMod = "SUPER"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd("rofi -show"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("rofi -show ssh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})

-- Set full opacity on Firefox video popout even if it's not focused
hl.window_rule({
    name = "firefox-video-popout",
    match = {
        title = "^Picture-in-Picture$",
        class = "^org.mozilla.firefox$",
    },
    opacity = "opacity 1.0 override",
})

-- Set full opacity on MPV windows even if it's not focused
hl.window_rule({
    name = "mpv",
    match = {
        class = "^mpv$",
    },
    opacity = "opacity 1.0 override",
})

-- Set full opacity for development windows
hl.window_rule({
    name = "jetbrains",
    match = {
        class = "^jetbrains(.*)$",
    },
    opacity = "opacity 1.0 override",
})

-- Force Moonlight to 1920x1080 to match gamestream settings
hl.window_rule({
    name = "moonlight",
    match = {
        title = ".*Moonlight",
    },
    max_size = { 1920, 1080 },
})
