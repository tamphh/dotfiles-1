local awful = require("awful")
local wibox = require("wibox")
local gtable = require("gears.table")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local ncmpcpp = require("widgets.mpc")({ 
  mode = "titlebar", font = M.f.h4, fg = "primary", overlay = "primary"
})

beautiful.titlebar_bg_focus = beautiful.titlebar_bg_focus or M.x.background
beautiful.titlebar_bg = beautiful.titlebar_bg or M.x.background
beautiful.titlebar_bg_normal = beautiful.titlebar_bg_normal or M.x.background
local size = beautiful.titlebar_size or nil

client.connect_signal("request::titlebars", function(c)

  local buttons = gtable.join(
  awful.button({}, 1, function()
    c:emit_signal("request::activate", "titlebar", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({}, 3, function()
    c:emit_signal("request::activate", "titlebar", { raise = true })
    awful.mouse.client.resize(c)
  end)
  )

  local position = beautiful.titlebar_position or 'top'
  awful.titlebar(c, { position = position, size = size }) : setup {
    nil, -- Left
    { -- Middle
      { -- Title
        align  = "center",
        widget = beautiful.titlebar_title_enabled and awful.titlebar.widget.titlewidget(c) or wibox.widget.textbox()
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton (c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }

  -- bottom bar for ncmpcpp
  if c.class == "music_n" and position ~= 'left' then
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
