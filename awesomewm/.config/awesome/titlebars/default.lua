local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local titlebar = require("util.titlebar")

beautiful.titlebar_bg_focus = beautiful.titlebar_bg_focus or M.x.background
beautiful.titlebar_bg = beautiful.titlebar_bg or M.x.background
beautiful.titlebar_bg_normal = beautiful.titlebar_bg_normal or M.x.background
local size = beautiful.titlebar_size or nil

client.connect_signal("request::titlebars", function(c)

  local position = beautiful.titlebar_position or 'top'

  if not titlebar.is_titlebar_off(c) then
    awful.titlebar(c, { position = position, size = size }) : setup {
      nil, -- Left
      { -- Middle
        { -- Title
          align  = "center",
          widget = beautiful.titlebar_title_enabled and awful.titlebar.widget.titlewidget(c) or wibox.widget.textbox()
        },
        buttons = titlebar.button(c),
        layout  = wibox.layout.flex.horizontal
      },
      { -- Right
        titlebar.button_minimize(c),
        titlebar.button_maximize(c),
        titlebar.button_close(c),
        layout = wibox.layout.fixed.horizontal
      },
      expand = "none",
      layout = wibox.layout.align.horizontal
    }
  end

  -- bottom bar for ncmpcpp
  if c.class == "music_n" and position ~= 'left' then
    titlebar.ncmpcpp(c)
  end
end)
