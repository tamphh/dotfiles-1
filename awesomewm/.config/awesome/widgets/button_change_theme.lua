local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("util.widgets")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi
local gtable = require('gears.table')
local icons = require("icons.default")
local font = require("util.font")

-- beautiful vars
local icon = beautiful.widget_change_theme_icon or '嗀'
local icon_reload = beautiful.widget_change_theme_icon_reload or '勒'
local fg = beautiful.widget_change_theme_fg or M.x.on_background
local bg = beautiful.widget_change_theme_bg or M.x.background
local l = beautiful.widget_change_theme_layout or 'horizontal'
local space = beautiful.widget_spacing or dpi(1)

-- for the popup
local fg_p = M.x.on_surface
local bg_p = M.x.surface
local padding = beautiful.widget_popup_padding or 1

-- widget creation
local text = font.button(icon, fg)
local rld = font.button(icon_reload, fg)
local wi = widget.box(l, { text, rld }, space)

local popup_anonymous = widget.imagebox(80, icons["anonymous"])
local popup_connected = widget.imagebox(80, icons["connected"])
local popup_miami = widget.imagebox(80, icons["miami"])
local popup_machine = widget.imagebox(80, icons["machine"])
local popup_morpho = widget.imagebox(80, icons["morpho"])
local popup_worker = widget.imagebox(80, icons["worker"])

local w_position -- the position of the popup depend of the wibar
w_position = widget.check_popup_position(beautiful.wibar_position)

local w = awful.popup {
  widget = {
      nil,
      {
        {
          {
            font.h6("Change theme", fg),
            layout = wibox.layout.align.vertical
          },
          {
            popup_anonymous,
            popup_connected,
            popup_machine,
            popup_miami,
            popup_morpho,
            popup_worker,
            forced_num_rows = 2,
            forced_num_cols = 3,
            layout = wibox.layout.grid,
          },
          layout = wibox.layout.align.vertical
        },
        margins = 5,
        widget = wibox.container.margin
      },
      layout = wibox.layout.fixed.horizontal
  },
  visible = false, -- do not show at start
  ontop = true,
  hide_on_right_click = true,
  preferred_positions = w_position,
  offset = { y = padding, x = padding }, -- no pasted on the bar
  bg = bg_p,
}

-- attach popup to widget
w:bind_to_widget(text)
text:buttons(gtable.join(
  awful.button({}, 3, function()
    w.visible = false
  end)
))

-- audio.sh arguments are: [music_details] [path of your music directory]
local miami_change_script = "~/.config/awesome/widgets/change-theme.sh --change miami"
widget.add_left_click_action(popup_miami, miami_change_script, true, "miniterm")

local machine_change_script = "~/.config/awesome/widgets/change-theme.sh --change machine"
widget.add_left_click_action(popup_machine, machine_change_script, true, "miniterm")

local connected_change_script = "~/.config/awesome/widgets/change-theme.sh --change connected"
widget.add_left_click_action(popup_connected, connected_change_script, true, "miniterm")

local anonymous_change_script = "~/.config/awesome/widgets/change-theme.sh --change anonymous"
widget.add_left_click_action(popup_anonymous, anonymous_change_script, true, "miniterm")

local morpho_change_script = "~/.config/awesome/widgets/change-theme.sh --change morpho"
widget.add_left_click_action(popup_morpho, morpho_change_script, true, "miniterm")

local worker_change_script = "~/.config/awesome/widgets/change-theme.sh --change worker"
widget.add_left_click_action(popup_worker, worker_change_script, true, "miniterm")

rld:buttons(gtable.join(
  awful.button({ }, 1, function()
    awesome.restart()
  end)
))

return wi
