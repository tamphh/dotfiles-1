local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local keygrabber = require("awful.keygrabber")
local beautiful = require("beautiful")
local helpers = require("helpers")
local btext = require("util.mat-button.text")

-- keylogger
local exit_screen_grabber

function exit_screen_hide()
  keygrabber.stop(exit_screen_grabber)
  exit_screen.visible = false
end

local poweroff_command = function() 
  awful.spawn("sudo systemctl poweroff")
  exit_screen_hide()
end

local poweroff = btext({ fgcolor = "error",
  icon = "⭘",
  text = "<b>P</b>oweroff",
  width = 110,
  command = poweroff_command
})

local exit_command = function() 
  awesome.quit()
end

--local exit_command = function()
--  local naughty = require("naughty")
--  naughty.notify({ text = "hello" })
--end

local exit = btext({ fgcolor = "primary",
  icon = ">>",
  text = "<b>E</b>xit",
  width = 110,
  command = exit_command
})
-- {{{ END Exit part

-- {{{ Lock part
local lock_command = function() 
  exit_screen_hide()
  lock_screen_show()
end

local lock = btext({ fgcolor = "secondary",
  icon = "",
  text = "<b>L</b>ock",
  width = 110,
  command = lock_command
})

-- get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

exit_screen = wibox({ x = 0, y = 0, visible = false, ontop = true, type = "dock" })
exit_screen.bg = beautiful.surface .. "55"
exit_screen.width = screen_width
exit_screen.height = screen_height

function exit_screen_show()
  local grabber = keygrabber {
    keybindings = {
      { {}, 'p', function() poweroff_command() end },
      { {}, 'e', function() exit_command() end },
      { {}, 'l', function() lock_command() end },
      { {}, 'q', function() exit_screen_hide() end },
    },
    stop_key = "Escape",
    stop_callback = function() exit_screen_hide() end,
  }

  if grabber.is_running and exit_screen.visible == false then
    grabber:stop()
  elseif exit_screen.visible == false then
    grabber:stop()
  end

  grabber:start()
  exit_screen.visible = true
end

-- buttons
exit_screen:buttons(gears.table.join(
  -- Middle click - Hide exit_screen
  awful.button({ }, 2, function ()
    exit_screen_hide()
  end),
  -- Right click - Hide exit_screen
  awful.button({ }, 3, function ()
    exit_screen_hide()
  end)
))

exit_screen:setup {
  nil,
  {
    {
      nil,
      {
        {
          {
            nil,
            {
              poweroff,
              exit,
              lock,
              spacing = 12,
              layout = wibox.layout.fixed.horizontal
            },
            expand = "none",
            layout = wibox.layout.align.vertical
          },
          margins = 18,
          widget = wibox.container.margin
        },
        shape = helpers.rrect(18),
        bg = beautiful.grey_dark,
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
