-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- CUSTOM HYPRLAND CONFIG (LUA)                          --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local menu        = "noctalia-shell ipc call launcher toggle"

hl.monitor({
    output   = "eDP-1",
    mode     = "2880x1800@120",
    scale    = 1.5,
    bitdepth = 10,
})
-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- ANIMATIONS -------
-----------------------

hl.curve("linear",  { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("default", { type = "bezier", points = { {0.35, 0.15}, {0.25, 1} } })
hl.curve("easeIn",  { type = "bezier", points = { {0.3, 0.82}, {0.42, 1} } })
hl.curve("easeOut", { type = "bezier", points = { {0, 0}, {0.58, 1} } })

hl.animation({ leaf = "windows",       enabled = true, speed = 2,  bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 2,  bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 3,  bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsMove",   enabled = true, speed = 2,  bezier = "default", style = "popin" })

hl.animation({ leaf = "layersIn",      enabled = true, speed = 3,  bezier = "default", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 3,  bezier = "default", style = "fade" })

hl.animation({ leaf = "fade",          enabled = false, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 5,  bezier = "default" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2,  bezier = "default" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 5,  bezier = "default" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 2,  bezier = "default" })

hl.animation({ leaf = "border",        enabled = true,  speed = 1,  bezier = "default" })
hl.animation({ leaf = "borderangle",   enabled = false, speed = 30, bezier = "default", style = "loop" })

hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2,  bezier = "default", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2,  bezier = "default", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 3, bezier = "default", style = "slidefadevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "default", style = "slidefadevert" })

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 6,
        border_size = 1,
        allow_tearing = true,
        layout = "scrolling",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 10,
            render_power = 3,
            color = 0xee1a1a1a,
        },
        blur = {
            enabled = true,
            size = 1,
            passes = 2,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
        },
    },

    dwindle = { preserve_split = true, smart_split = false },
    xwayland = { force_zero_scaling = true },
    misc = { force_default_wallpaper = -1, disable_hyprland_logo = false, vrr = true },

    input = {
        kb_layout = "us, ru",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity = 0,
        repeat_delay = 300,
        repeat_rate = 40,
        force_no_accel = true,
        touchpad = { natural_scroll = false },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu lock"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move Window
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Resize
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))

-- Workspaces
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end


-- Multimedia
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true })

-- Screenshots
local satty_args = '--filename - --floating-hack --resize 1000x600 --early-exit --copy-command "wl-copy" --output-filename ~/Pictures/Screenshots/satty-$(date "+%Y%m%d-%H:%M:%S").png'
hl.bind("PRINT", hl.dsp.exec_cmd('grim -o "$(hyprctl monitors -j | jq -r \'.[] | select(.focused==true) | .name\')" - | satty ' .. satty_args))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty ' .. satty_args))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.layer_rule({
    match = { namespace = "selection" },
    no_anim = true,
})
