-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

-- Primary. Matched by desc: so it follows the panel across ports (DP-3 or
-- HDMI-A-1). Currently driven over HDMI at 3840x1080@120. NOTE: over HDMI this
-- panel only advertises up to 3840x1080@120 -- the higher modes (5120x1440@120,
-- native 7680x2160@120) need DisplayPort. Back on DP you can bump to those.
-- To re-apply a mode live (only works while this VT is the active console):
--   hyprctl eval "hl.monitor({ output = 'desc:Samsung Electric Company Odyssey G95NC HNTX300255', mode = '3840x1080@59.97', position = 'auto', scale = 'auto' })"
hl.monitor({
    output    = MONITOR1,
    mode      = "3840x1080@119.97",
    position  = "auto",
    scale     = "auto",
})

-- Remote HDMI extender to the TV. The link drops and re-handshakes on its own,
-- so pin everything: a fixed mode means a reconnect never renegotiates, and vrr
-- is forced off because the extender reports vrr_capable inconsistently.
--
-- DISABLED: the Samsung is now on HDMI-A-1 (this rule's connector), so leaving
-- this active would apply 1920x1080@60/vrr=0 to the Samsung and fight the
-- desc:-matched rule above. Re-enable this (and move the Samsung back to DP)
-- when the TV extender is reconnected.
-- hl.monitor({
--     output    = MONITOR2,
--     mode      = "1920x1080@60",
--     position  = "auto",
--     scale     = 1,
--     vrr       = 0,
-- })
