local wibox = require("wibox")
local widget = require("util.widgets")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local font = require("util.font")

-- opacity state for button dark theme
-- https://material.io/design/color/dark-theme.html#states
local o = { bg={}, fg={} }
o["bg"]["none"] = "00" -- 0%
o["bg"]["hovered"] = "0A" -- 4%
o["bg"]["focused"] = "1F" -- 12%

o["fg"]["disable"] = 38
o["fg"]["enable"] = 87
o["fg"]["enable_focus"] = 100

-- TODO: enhance or delete this
local mat_colors = {}
mat_colors["primary"] = { beautiful.primary, beautiful.primary }
mat_colors["secondary"] = { beautiful.secondary, beautiful.secondary }
mat_colors["error"] = { beautiful.error, beautiful.error }
mat_colors["surface"] = { beautiful.on_surface, beautiful.on_surface }

local mat_tabs = class()

function mat_tabs:init(args)
  -- options
  self.font_text = args.font_text or beautiful.font_button or "Iosevka Term Medium 14"
  self.texts = args.texts or {}
  self.fg = args.fg or beautiful.on_surface
  self.bg = args.bg or beautiful.surface
  self.fg_text = args.fg_text or beautiful.on_surface
  self.bg_overlay = args.bg_overlay or beautiful.on_surface
  self.layout = args.layout or "horizontal"
  self.rrect = args.rrect or 1
  self.width = args.width or nil
  self.height = args.height or 48 -- default for one row
  self.colorline_enable = self.colorline_enable or beautiful.primary
  self.fg_enable = self.fg_enable or beautiful.on_surface
  self.containers = args.containers or {}
  -- widgets
  self.wtexts = {}
  self.wlines = {}
  self.wbgs = {}
  self.tab = wibox.widget { layout = wibox.layout.fixed.horizontal }
  self.w = wibox.widget { layout = wibox.layout.fixed.vertical, spacing = 8 }
end

function mat_tabs:create_tabs()
  for k,v in pairs(self.texts) do
    self.wtexts[k] = font.button(v, self.fg, o.fg.disable)

    self.wbgs[k] = wibox.widget {
      bg = self.bg_overlay .. o.bg.none,
      widget = wibox.container.background
    }

    self.wlines[k] = wibox.widget {
      bottom = 2,
      color = self.bg,
      widget = wibox.container.margin
    }

    -- margin for fixed tabs https://material.io/components/tabs/tabs.html#specs
    local margin = wibox.widget {
      top = dpi(12), bottom = dpi(12),
      left = dpi(16), right = dpi(16),
      forced_height = dpi(self.height),
      widget = wibox.container.margin
    }

    local button = wibox.widget {
      nil,
      {
        {
          {
            self.wtexts[k],
            widget = margin
          },
          widget = self.wlines[k]
        },
        widget = self.wbgs[k],
      },
      expand = "none",
      layout = wibox.layout.align.horizontal
    }

    self:signals(k, button)
    self.tab:add(button)
  end
end

function mat_tabs:signals(index, w)
  w:connect_signal("mouse::leave", function() 
    self.wbgs[index].bg = self.bg_overlay .. o.bg.none
  end)
  w:connect_signal("mouse::enter", function() 
    self.wbgs[index].bg = self.bg_overlay .. o.bg.hovered
  end)
  w:connect_signal("button::release", function() 
    self.wbgs[index].bg = self.bg_overlay .. o.bg.hovered
  end)
  w:connect_signal("button::press", function()
    self.wbgs[index].bg = self.bg_overlay .. o.bg.focused
    self:switch(index)
    self:enable(index)
  end)
end

function mat_tabs:enable(index)
  local index = index or 1
  -- clear previous line,
  -- with material, only one element should be active per tab
  for k,v in pairs(self.texts) do
    self.wlines[k].color = self.bg -- remove old enable line
    self.wtexts[k].markup = helpers.colorize_text(v, self.fg, o.fg.disable)
  end
  self.wlines[index].color = self.colorline_enable
  self.wtexts[index].markup = helpers.colorize_text(self.texts[index], self.fg_enable)
end

function mat_tabs:widget_centered()
  return wibox.widget { -- return the tab widget centered
    nil,
    self.tab,
    expand = "none",
    layout = wibox.layout.align.horizontal
  }
end

function mat_tabs:switch(index)
  local index = index or 1 -- default switch on the 1st container
  self.w:reset()
  self.w:add(self:widget_centered())
  self.w:add(self.containers[index])
end

local new_tab = class(mat_tabs)

function new_tab:init(args)
  mat_tabs.init(self, args)
  mat_tabs.create_tabs(self)
  mat_tabs.switch(self)
  mat_tabs.enable(self)
  return self.w
end

return new_tab
