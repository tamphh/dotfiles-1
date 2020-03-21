local helpers = require("helpers")
local abutton = require("awful.button")
local gtable = require("gears.table")
local font = require("util.font")
local wibox = require("wibox")
local awful = require("awful")

local root_icon = class()

function root_icon:init(args)
  -- options
  self.fg = args.fg or M.x.on_background
  self.bg = args.bg or M.x.background
  self.icon = args.icon or ""
  self.command = args.command or nil
  -- base widgets
  self.wicon = font.button(self.icon, self.fg)
  self.w = self:spec()
end

function root_icon:make_widget()
  self:color()
  self:action()
end

-- with different level of opacity
function root_icon:color()
  self.wicon.markup = helpers.colorize_text(self.icon, self.fg, 50)
  self.w:connect_signal("mouse::enter", function()
    self.wicon.markup = helpers.colorize_text(self.icon, self.fg, 70)
  end)
  self.w:connect_signal("mouse::leave", function()
    self.wicon.markup = helpers.colorize_text(self.icon, self.fg, 50)
  end)
  self.w:connect_signal("button::press", function()
    self.wicon.markup = helpers.colorize_text(self.icon, self.fg, 100)
  end)
  self.w:connect_signal("button::release", function()
    self.wicon.markup = helpers.colorize_text(self.icon, self.fg, 50)
  end)
end

function root_icon:action()
  if not self.command then return end
  self.w:buttons(gtable.join(
    awful.button({}, 1, function()
      self.command()
    end)
  ))
end

-- https://material.io/design/iconography/system-icons.html#system-icon-metrics
function root_icon:spec()
  self.wicon.forced_height = 24
  self.wicon.forced_width = 24
  return wibox.widget {
    {
      --{
        self.wicon,
      --  bg = M.x.on_surface .. M.e.dp02,
      --  widget = wibox.container.background
      --},
      margins = 12,
      widget = wibox.container.margin
    },
    --bg = M.x.on_surface .. M.e.dp01,
    widget = wibox.container.background
  }
end

local new_icon = class(root_icon)

function new_icon:init(args)
  root_icon.init(self, args)
  root_icon.make_widget(self)
  return self.w
end

return new_icon
