local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

beautiful.titlebar_bg_focus = M.x.background
beautiful.titlebar_bg = M.x.background
beautiful.titlebar_bg_normal = M.x.background

local ncmpcpp = require("widgets.mpc")({ 
  mode = "titlebar", font = M.f.h4, fg = "primary", overlay = "primary"
})

client.connect_signal("request::titlebars", function(c)
    -- bottom bar for ncmpcpp
    if c.class == "music_n" then
      awful.titlebar(c, {
        position = "bottom", size = dpi(50)
      }) : setup {
        nil,
        ncmpcpp,
        expand = "none",
        layout = wibox.layout.align.horizontal
      }
    end
end)
