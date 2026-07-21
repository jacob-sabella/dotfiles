-- Keybindings.
--
-- Layout is carried over from the pre-CachyOS config (SUPER+Q terminal,
-- SUPER+C close, flat workspaces 1-10). Where the original bind called a
-- tool that is not installed on this machine, it is routed to the noctalia
-- equivalent instead. Binds with no working equivalent are left commented
-- out with the package needed to restore them.

local mod   = "SUPER"
local modS  = "SUPER + SHIFT"
local modC  = "SUPER + CONTROL"
local modA  = "SUPER + ALT"
local modCS = "SUPER + CONTROL + SHIFT"

local noctCall     = "noctalia msg "
local launchPrefix = "uwsm app -- "
local terminal     = "ghostty"
local home         = os.getenv("HOME")

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

hl.bind(mod  .. " + Q",      hl.dsp.exec_cmd(launchPrefix .. terminal))
hl.bind(mod  .. " + C",      hl.dsp.window.close())
hl.bind(mod  .. " + M",      hl.dsp.exit())
hl.bind(mod  .. " + E",      hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mod  .. " + P",      hl.dsp.window.pin())
hl.bind(mod  .. " + J",      hl.dsp.layout("togglesplit"))
hl.bind(mod  .. " + F",      hl.dsp.window.fullscreen())
hl.bind(modS .. " + F",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(modC .. " + F",      hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod  .. " + Escape", hl.dsp.exec_cmd("hyprctl kill"))

-- Focus movement. The original routed left/right through the sidepanels
-- module; that module is not carried over (it targeted the 32:9 monitor).
hl.bind(mod .. " + Left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + Up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mod .. " + Down",  hl.dsp.focus({ direction = "down"  }))

-- Move & resize with mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())

------------------
---- LAUNCHER ----
------------------

-- Original used hyprlauncher / rofi -show drun; both absent, so these go to
-- the noctalia launcher.
hl.bind(mod .. " + R",     hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
hl.bind(mod .. " + Space", hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))
hl.bind(mod .. " + Slash", hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"))

-- Original: rofi -show window
hl.bind("ALT + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher"))

-- Original: hyprlock
hl.bind(mod .. " + L", hl.dsp.exec_cmd(noctCall .. "session lock"))

-- Original: alacritty -e pulsemixer
hl.bind(mod .. " + V", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"))

-- Edit this config
hl.bind(modS .. " + H", hl.dsp.exec_cmd(terminal .. " -e micro " .. home .. "/.config/hypr/config/binds.lua"))

hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. terminal .. " -e btop"))
hl.bind(modS .. " + B",             hl.dsp.exec_cmd(launchPrefix .. BROWSER))

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

-- Original used pamixer / playerctl / adjust_brightness; none installed.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume-up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "mic-mute"),    { locked = true })

hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(noctCall .. "media next"),     { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(noctCall .. "media previous"), { locked = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctCall .. "brightness-up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness-down"), { locked = true, repeating = true })

-------------------
---- UTILITIES ----
-------------------

-- Screenshots. Original used hyprshot; routed to noctalia, keeping the
-- original key layout (plain Print = region, SUPER+Print = window/output).
hl.bind("Print",             hl.dsp.exec_cmd(noctCall .. "screenshot-region"))
hl.bind(mod   .. " + Print", hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen"))
hl.bind(modS  .. " + Print", hl.dsp.exec_cmd(noctCall .. "screenshot-region"))
hl.bind(modCS .. " + Print", hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen"))

hl.bind(mod  .. " + BackSlash", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(modS .. " + W",         hl.dsp.exec_cmd(noctCall .. "panel-toggle wallpaper"))
hl.bind(modA .. " + S",         hl.dsp.exec_cmd(home .. "/.local/bin/hyprshade-rofi"))

-------------------------------
---- WORKSPACES & MONITORS ----
-------------------------------

-- Flat workspaces 1-10, as in the original config.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod  .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(modS .. " + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
hl.bind(mod  .. " + S", hl.dsp.workspace.toggle_special("first"))
hl.bind(modS .. " + S", hl.dsp.window.move({ workspace = "special:first", silent = true }))

-----------------------------------------------------------------------
-- Disabled: the tool these called is not installed on this machine.
-- Install the noted package, then uncomment.
-----------------------------------------------------------------------

-- pyprland (pypr): scratchpads and zoom
-- hl.bind(modS .. " + BackSlash", hl.dsp.exec_cmd("pypr toggle term"))
-- hl.bind(modS .. " + T",         hl.dsp.exec_cmd("pypr toggle tron"))
-- hl.bind(modS .. " + S",         hl.dsp.exec_cmd("pypr toggle spotify"))
-- hl.bind(mod  .. " + Z",         hl.dsp.exec_cmd("pypr zoom"))
-- hl.bind(mod  .. " + equal",     hl.dsp.exec_cmd("pypr zoom ++"))
-- hl.bind(mod  .. " + minus",     hl.dsp.exec_cmd("pypr zoom --"))

-- hyprexpo plugin (hyprland-plugins): workspace overview
-- hl.bind(mod .. " + Tab", hl.dsp.global("hyprexpo:expo", "toggle"))

-- scrcpy + start_scrcpy script: phone mirroring
-- hl.bind(modS .. " + P", hl.dsp.exec_cmd(home .. "/.local/bin/start_scrcpy"))

-- wf-recorder is installed but the hypr-record-select script was not carried
-- over; restore it from the old repo to re-enable region/window recording.
-- hl.bind(modC .. " + Print", hl.dsp.exec_cmd(home .. "/.local/bin/hypr-record-select"))
