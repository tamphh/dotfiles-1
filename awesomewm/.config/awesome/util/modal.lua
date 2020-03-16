local wibox = require("wibox")
local beautiful = require("beautiful")
local ascreen = require("awful.screen")
local helpers = require("helpers")
local abutton = require("awful.button")
local gtable = require("gears.table")

-- hexa code for transparency in percent
-- https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
local t = {}
t["32"] = "52"
t["8"] = "14"
t["7"] = "12"
t["5"] = "0D"

local modal = {}

function modal:init()
  self.w = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "dock" })
  self.w.bg = beautiful.on_surface .. t["5"]
  self.w.width = ascreen.focused().geometry.width
  self.w.height = ascreen.focused().geometry.height
  return self.w
end

function modal:add_buttons(f)
  if type(f) ~= "function" then return end
  self.w:buttons(gtable.join(
    abutton({}, 2, function() f() end), -- middle click
    abutton({}, 3, function() f() end) -- right click
  ))
end

-- place a widget at the center of the focused screen
function modal:run(w)
  self.w:setup {
    nil,
    {
      {
        nil,
        {
          {
            {
              nil,
              w,
              expand = "none",
              layout = wibox.layout.align.vertical
            },
            margins = 18,
            widget = wibox.container.margin
          },
          shape = helpers.rrect(18),
          bg = beautiful.surface,
          widget = wibox.container.background
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      layout = wibox.layout.fixed.vertical
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
  }
end

return setmetatable({}, { __index = modal })
