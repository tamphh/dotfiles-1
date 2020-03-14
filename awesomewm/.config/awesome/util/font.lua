local widget = require("util.widgets")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

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

return font
