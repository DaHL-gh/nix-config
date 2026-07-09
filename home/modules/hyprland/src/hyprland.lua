function cat(args)
    return table.concat(args, " + ")
end

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "kitty"
local menu     = "noctalia-shell ipc call launcher toggle"

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

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("default", { type = "bezier", points = { { 0.35, 0.15 }, { 0.25, 1 } } })
hl.curve("easeIn", { type = "bezier", points = { { 0.3, 0.82 }, { 0.42, 1 } } })
hl.curve("easeOut", { type = "bezier", points = { { 0, 0 }, { 0.58, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "default", style = "popin" })

hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "default", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "default", style = "fade" })

hl.animation({ leaf = "fade", enabled = false, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "default" })

hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = false, speed = 30, bezier = "default", style = "loop" })

hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2, bezier = "default", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2, bezier = "default", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "default", style = "slidefadevert" })
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

    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.9,
        focus_fit_method = 0,
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
hl.bind(cat({ mainMod, "Return" }), hl.dsp.exec_cmd(terminal))
hl.bind(cat({ mainMod, "Q" }), hl.dsp.window.close())
hl.bind(cat({ mainMod, "space" }), hl.dsp.exec_cmd(menu))
hl.bind(cat({ mainMod, "CTRL + l" }), hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu lock"))

hl.bind(cat({ mainMod, "F" }), hl.dsp.window.float({ action = "toggle" }))
hl.bind(cat({ mainMod, "P" }), hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + G", hl.dsp.layout("togglesplit"))
hl.bind(cat({ mainMod, "Delete" }), hl.dsp.exit())

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Move Focus
hl.bind(cat({ mainMod, "left" }), hl.dsp.focus({ direction = "left" }))
hl.bind(cat({ mainMod, "right" }), hl.dsp.focus({ direction = "right" }))
hl.bind(cat({ mainMod, "up" }), hl.dsp.focus({ direction = "up" }))
hl.bind(cat({ mainMod, "down" }), hl.dsp.focus({ direction = "down" }))
hl.bind(cat({ mainMod, "h" }), hl.dsp.focus({ direction = "left" }))
hl.bind(cat({ mainMod, "l" }), hl.dsp.focus({ direction = "right" }))
hl.bind(cat({ mainMod, "k" }), hl.dsp.focus({ direction = "up" }))
hl.bind(cat({ mainMod, "j" }), hl.dsp.focus({ direction = "down" }))

-- Move Window
hl.bind(cat({ mainMod, "SHIFT + h" }), hl.dsp.window.move({ direction = "left" }))
hl.bind(cat({ mainMod, "SHIFT + l" }), hl.dsp.window.move({ direction = "right" }))
hl.bind(cat({ mainMod, "SHIFT + k" }), hl.dsp.window.move({ direction = "up" }))
hl.bind(cat({ mainMod, "SHIFT + j" }), hl.dsp.window.move({ direction = "down" }))

-- Resize
hl.bind(cat({ mainMod, "ALT + h" }), hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(cat({ mainMod, "ALT + l" }), hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(cat({ mainMod, "ALT + j" }), hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(cat({ mainMod, "ALT + k" }), hl.dsp.window.resize({ x = 0, y = -50, relative = true }))

-- Workspaces
hl.bind(cat({ mainMod, "SHIFT + S" }), hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(cat({ mainMod, "S" }), hl.dsp.workspace.toggle_special("magic"))

for i = 1, 9 do
    hl.bind(cat({ mainMod, i }), hl.dsp.focus({ workspace = i }))
    hl.bind(cat({ mainMod, "SHIFT", i }), hl.dsp.window.move({ workspace = i, follow = false }))
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
local satty_args =
'--filename - --floating-hack --resize 1000x600 --early-exit --copy-command "wl-copy" --output-filename ~/Pictures/Screenshots/satty-$(date "+%Y%m%d-%H:%M:%S").png'
hl.bind("PRINT",
    hl.dsp.exec_cmd('grim -o "$(hyprctl monitors -j | jq -r \'.[] | select(.focused==true) | .name\')" - | satty ' ..
        satty_args))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty ' .. satty_args))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- fix slurp visible selection boundary
hl.layer_rule({
    match = { namespace = "selection" },
    no_anim = true,
})

hl.window_rule({
    name = "allow-tearing",
    match = {
        class = "^.*$",
    },
    immediate = true,
})

local function split_layout()
    hl.config({
        scrolling = {
            fullscreen_on_one_column = false,
            focus_fit_method = 1,
        },
    })

    hl.dispatch(hl.dsp.layout("colresize all 0.5"))
end

local function single_layout()
    hl.config({
        scrolling = {
            fullscreen_on_one_column = true,
            focus_fit_method = 0,
        },
    })

    hl.dispatch(hl.dsp.layout("colresize all 0.9"))
end

local layout_state = "focus"

hl.bind(cat({ mainMod, "b" }), function()
    layout_state = layout_state == "single" and "split" or "single"
    if layout_state == "single" then
        single_layout()
    end
    if layout_state == "split" then
        split_layout()
    end
end)
