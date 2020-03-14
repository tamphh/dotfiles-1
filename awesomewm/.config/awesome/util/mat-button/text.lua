local wibox = require("wibox")
local awful = require("awful")
local mat = require("util.mat")
local gtable = require("gears.table")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- opacity color on dark theme
-- https://material.io/design/iconography/system-icons.html#color
local b = {}
b["focus"] = 100
b["normal"] = 70
b["inactive"] = 50

local mat_colors = {}
mat_colors["primary"] = { beautiful.primary, beautiful.primary }
mat_colors["secondary"] = { beautiful.secondary, beautiful.secondary }
mat_colors["error"] = { beautiful.error, beautiful.error }
mat_colors["surface"] = { beautiful.on_surface, beautiful.on_surface }

local mat_button = class()

function mat_button:init(args)
  self.font_text = args.font_text or beautiful.font_button or "Iosevka Term Medium 14"
  self.font_icon = args.font_icon or beautiful.font_h1 or "Iosevka Light 60"
  self.icon = args.icon or ""  
  self.text = args.text or ""
  self.fg_text = args.fg_text and mat_colors[args.fg_text] or mat_colors["surface"]
  self.layout = args.layout or "vertical"
  self.rrect = 10
  self.width = args.width or nil
  self.height = args.height or nil
  self.command = args.command or nil
  self.colors = args.fgcolor and mat_colors[args.fgcolor] or mat_colors["surface"]
  self.wicon = widget.create_text(self.icon, self.colors[1], self.font_icon)
  self.wtext = args.wtext or widget.create_text(self.text, self.fg_text[2], self.font_text)
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
    forced_width = self.width,
    forced_height = self.height,
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
  self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], b["normal"])
  self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], b["normal"])
  self.background.opacity = 0.00

  self.w:connect_signal("mouse::leave", function() 
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], b["normal"])
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], b["normal"])
    self.background.opacity = 0.00
  end)
  self.w:connect_signal("mouse::enter", function() 
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], b["focus"])
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], b["focus"])
    self.background.opacity = 0.05
  end)
  self.w:connect_signal("button::release", function() 
    self.wicon.markup = helpers.colorize_text(self.icon, self.colors[1], b["normal"])
    self.wtext.markup = helpers.colorize_text(self.text, self.fg_text[2], b["normal"])
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
