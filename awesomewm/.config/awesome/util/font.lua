local widget = require("util.widgets")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- opacity for helper text and dark theme
-- https://material.io/design/color/dark-theme.html#ui-application
local p = {}
p["high"] = 87
p["medium"] = 60
p["disable"] = 38

function make_widget(font, text, color, alpha)
  local alpha = alpha or 100
  local w = widget.create_base_text(font)
  w.markup = helpers.colorize_text(text, color, alpha)
  return w
end

local font = {}

function font.h1(text, fg) 
  local color = fg or beautiful.on_surface
  local font = beautiful.font_h1 or "Iosevka Light 60"
  return make_widget(font, text, color)
end

function font.h4(text, fg, alpha) 
  local color = fg or beautiful.on_surface
  local font = beautiful.font_h4 or "Iosevka Regular 32"
  local alpha = alpha or 100
  return make_widget(font, text, color, alpha)
end

function font.h6(text, fg, alpha) 
  local color = fg or beautiful.on_surface
  local font = beautiful.font_h6 or "Iosevka Medium 20"
  local alpha = alpha or 100
  return make_widget(font, text, color, alpha)
end

function font.text_list(text, fg, alpha)
  local color = fg or beautiful.on_surface
  local font = beautiful.font_subtile_1 or "Iosevka Term Bold 16"
  local alpha = alpha or 70
  return make_widget(font, text, color, alpha)
end

function font.body_title(text, fg)
  local color = fg or beautiful.on_surface
  local font = beautiful.font_body_1 or "Iosevka Term Regular 16"
  return make_widget(font, text, color)
end

function font.body_text(text, fg, alpha)
  local color = fg or beautiful.on_surface
  local font = beautiful.font_body_2 or "Iosevka Term Regular 14"
  local alpha = alpha or 87
  local w = widget.create_base_text(font)
  w.markup = helpers.colorize_text(text, color, alpha)
  return w
end

function font.caption(text, fg)
  local color = fg or beautiful.on_secondary
  local font = beautiful.font_caption or "Iosevka Term Regular 16"
  return make_widget(font, text, color)
end

function font.overline(text, fg, alpha, bg)
  local color = fg or beautiful.on_secondary
  local colorline = bg or beautiful.primary
  local font = beautiful.font_overline or "Iosevka Regular 10"
  local alpha = alpha or 60
  local t = widget.create_base_text(font)
  t.markup = helpers.colorize_text(text, color, alpha)
  local wibox = require("wibox")
  local gshape = require("gears.shape")
  local shape_line = function(cr, width, height)
    -- translate X moving to the right
    -- translate Y bring down the line (20-24 for a bottom line)
    gshape.transform(gshape.rounded_rect)
    : translate(width/3,23) (cr, width/3, -1, 2)
  end
  return wibox.widget {
    {
      t,
      bottom = 6,
      widget = wibox.container.margin
    },
    shape = shape_line,
    opacity = 0.7,
    shape_border_color = colorline,
    shape_border_width = 2,
    widget = wibox.container.background
  }
end

return font
