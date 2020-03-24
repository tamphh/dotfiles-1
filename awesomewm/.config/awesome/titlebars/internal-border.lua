local awful = require("awful")
local wibox = require("wibox")
local gtable = require("gears.table")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local font = require("util.font")
local btext = require("util.mat-button")

-- vars
local position = beautiful.titlebar_position or 'top'
local t_font = M.f.subtile_1
local ncmpcpp = require("widgets.mpc")({ 
  mode = "titlebar", font = M.f.h4, fg = "primary", overlay = "primary"
})

local function is_titlebar_off(c)
  local client_off = { 'Brave-browser', 'Lutris', 'music_n' } -- from the rc.lua
  for _,v in pairs(client_off) do
    if v == c.class then
      return true 
    end
  end
  return false
end

-- functions for windows
local window_close = function(c)
  c:kill()
end

-- if buttons are enable
local gen_button = function(c, icon, fg, fg_light, cmd)
  local r_margin = dpi(11)
  local t_margin = dpi(4)
  local func = function() cmd(c) end
  local button = btext({ text = icon, fg_text = fg, overlay = fg_light, command = func })

  return wibox.widget {
    button,
    top = t_margin,
    right = r_margin,
    widget = wibox.container.margin
  }
end

local function title(c)
  return wibox.widget {
    align = "center",
    font = t_font,
    widget = is_titlebar_off(c) and wibox.widget.textbox() or awful.titlebar.widget.titlewidget(c)
  }
end

local function border(c)
  local w = wibox.widget {
    color = M.x.primary,
    bottom = 2,
    widget = wibox.container.margin
  }
  c:connect_signal("unfocus", function(c)
    w.color = M.x.secondary
  end)
  c:connect_signal("focus", function(c)
    w.color = M.x.primary
  end)
  return w
end

local function margin(c)
  local width = c.width / 3
  local w = wibox.widget {
    left = width, right = width,
    widget = wibox.container.margin
  }
  c:connect_signal("property::size", function(c)
    local width = c.width / 3
    w.left = width
    w.right = width
  end)
  return w
end

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

  if not is_titlebar_off(c) then 
    awful.titlebar(c, 
      { font = t_font, position = position }
    ) : setup {
      nil, -- Left
      { -- Middle
        {
          {
            title(c),
            layout  = wibox.layout.flex.horizontal
          },
          widget = border(c),
        },
        buttons = buttons,
        widget = margin(c)
      },
      { -- Right
        gen_button(c, '', "error", "error", window_close),
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.align.horizontal
    }
  end

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


client.connect_signal("property::maximized", function(c)
  -- Another bottom line on rare clients
  if c.maximized and c.class ~= "music_n" then
    awful.titlebar(c, { size = 20, position = "bottom" }) : setup {
      nil,
      {
        {
          {
            {
              align = "center",
              font = t_font,
              widget = wibox.widget.textbox(),
            },
            layout  = wibox.layout.flex.horizontal
          },
          widget = border(c),
        },
        buttons = buttons,
        widget = margin(c)
      },
      nil,
      layout = wibox.layout.align.horizontal
    }
  else
    if c.class ~= "music_n" then awful.titlebar.hide(c, "bottom") end
  end
end)
