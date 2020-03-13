local wibox = require("wibox")
local awful = require("awful")
local mat = require("util.mat")
local gtable = require("gears.table")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")

local mat_colors = {}
mat_colors["primary"] = { beautiful.primary, beautiful.on_primary }
mat_colors["secondary"] = { beautiful.secondary, beautiful.on_secondary }
mat_colors["error"] = { beautiful.error, beautiful.on_error }
mat_colors["surface"] = { beautiful.surface, beautiful.on_surface }

local mat_button = class()

function mat_button:init(args)
  self.font_text = "Iosevka Term Medium 14"
  self.font_icon = "Iosevka Light 60"
  self.icon = args.icon or ""  
  self.text = args.text or ""
  self.fg_text = mat_colors["surface"]
  self.layout = "vertical"
  self.rrect = 10
  self.command = args.command or nil

  self.colors = args.fgcolor and mat_colors[args.fgcolor] or mat_colors["surface"]
  self.wicon = widget.create_text(self.icon, self.colors[1], self.font_icon)
  self.wtext = widget.create_text(self.text, self.fg_text[2], self.font_text)
  self.background = mat.bg_overlay(0.00, self.colors[1])
  self.w = wibox.widget {
    {
      self.wicon,
      self.wtext,
      layout = wibox.layout.fixed[self.layout],
    },
    {
      { -- widget to fill the background
        image = nil,
        widget = wibox.widget.imagebox
      },
      shape = helpers.rrect(self.rrect),
      widget = self.background,
    },
    forced_width = 110,
    layout = wibox.layout.stack
  }
end

function mat_button:add_action()
  self.w:buttons(gtable.join(
    awful.button({}, 1, function() 
      self.command()
    end)
  ))
end

function mat_button:hover()
  self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], 60)
  self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], 60)
  self.background.opacity = 0.00

  self.w:connect_signal("mouse::leave", function() 
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], 60)
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], 60)
    self.background.opacity = 0.00
  end)
  self.w:connect_signal("mouse::enter", function() 
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], 87)
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], 87)
    self.background.opacity = 0.05
  end)
  self.w:connect_signal("button::release", function() 
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], 60)
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], 60)
    self.background.opacity = 0.05
  end)
  self.w:connect_signal("button::press", function()
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1])
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2])
    self.background.opacity = 0.08
  end)
end

local new_button = class(mat_button)

function new_button:init(args)
  mat_button.init(self, args)
  mat_button.add_action(self)
  mat_button.hover(self)
  return self.w
end

return new_button
