local wibox = require("wibox")
local beautiful = require("beautiful")

-- a table with different level of opacity
local dp = {}
dp["00dp"] = 0.00
dp["01dp"] = 0.05
dp["02dp"] = 0.07
dp["03dp"] = 0.08
dp["04dp"] = 0.09
dp["06dp"] = 0.11
dp["08dp"] = 0.12
dp["12dp"] = 0.14
dp["16dp"] = 0.15
dp["24dp"] = 0.16

local mat = {}

function bg_surface(color)
  local color = color or beautiful.surface or "#121212"
  local w = wibox.container.background()
  w.opacity = 1
  w.bg = color
  return w
end

function mat.bg_overlay(level, color)
  local level = level or 0.00
  local color = color or beautiful.on_surface or "#ffffff"
  local w = wibox.container.background()
  w.bg = color
  w.opacity = level
  return w
end

-- overlay color match with the text or button
-- https://material.io/design/interaction/states.html#anatomy
-- overlay apply a color background with X% transparency on the surface color
function mat.overlay(level, bg)
  return wibox.widget {
    bg_surface(bg),
    widget = bg_overlay(level)
  }
end

-- https://material.io/design/interaction/states.html#anatomy
-- classed by white/dark surface or primary/secondary color
local state = {}
state["enabled"] = { 0, 0 }
state["hover"] = { 0.04, 0.08 }
state["focus"] = { 0.12, 0.24 }
state["selected"] = { 0.08, 0.16 }
state["activated"] = { 0.12, 0.24 }
state["pressed"] = { 0.12, 0.32 }
state["dragged"] = { 0.08, 0.16 }

-- https://material.io/design/interaction/states.html#hover
-- args, 1:number (1 for white/dark, 2 for primary/secondary)
-- args, 2:string (color), 3:string (color)
function mat.button(n, surface, overlay)
  local surface = bg_surface(surface)
  local bg_base = overlay or state["enabled"][n]
  local overlay = bg_overlay(bg_base)
  local w = wibox.widget {
    surface,
    widget = overlay
  }
  mat.button_signal(overlay, n)
  --mat.button_signal(overlay, n)
  --overlay:connect_signal("button::release", function(c) overlay.opacity = bg_base end)
  --overlay:connect_signal("button::press", function(c) 
  --  overlay.opacity = state["pressed"][n] 
  --end)
  return w
end

function mat.button_signal(w, n)
  local bg_base = state["enabled"][n]
  w:connect_signal("mouse::leave", function(c) w.opacity = bg_base end)
  w:connect_signal("mouse::enter", function(c) 
    w.opacity = state["focus"][n] 
  end)
end

return mat
