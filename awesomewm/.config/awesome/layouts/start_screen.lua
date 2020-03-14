local wibox = require("wibox")
local gtable = require("gears.table")
local awful = require("awful")
local beautiful = require("beautiful")
local widget = require("util.widgets")
local button = require("util.buttons")
local font = require("util.font")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local theme = require("loaded-theme")
local app = require("util.app")
local btext = require("util.mat-button.text")

local function start_screen_hide()
  local s = awful.screen.focused()
  s.start_screen.visible = false
end

local exec_prog = function(cmd)
  app.start(cmd, nil, nil, start_screen_hide)
end

local function open_link(url)
  app.open_link(url, start_screen_hide)
end

local max_feeds = 4
local feed_width = 380
local feed_height = 248

-- base for rss
local rss_threatpost = wibox.widget {
  spacing = 8,
  layout = wibox.layout.fixed.vertical
}

local rss_ycombinator = wibox.widget {
  spacing = 8,
  layout = wibox.layout.fixed.vertical
}

local function rss_links(rss, feed_name, w)
  w:reset()
  local f, s, b
  for i = 1, max_feeds do
    f = function() open_link(rss[feed_name].link[i]) end
    s = #rss[feed_name].title[i] > 28 and -- cut the text if too long
      string.sub(rss[feed_name].title[i], 1, 28) .. "..." or
      rss[feed_name].title[i]
    b = button.text_list(s, f, "surface")
    b.forced_width = 320
    w:add(b)
  end
end

local function make_rss_widget(title, w)
  return wibox.widget {
    {
      {
        {
          align = "left",
          widget = font.caption(title, beautiful.primary),
        },
        left = 5, bottom = 8,
        widget = wibox.container.margin
      },
      w,
      layout = wibox.layout.fixed.vertical
    },
    margins = 10,
    widget = wibox.container.margin
  }
end

local threatpost_widget = make_rss_widget("threatpost", rss_threatpost)
local ycombinator_widget = make_rss_widget("ycombinator", rss_ycombinator)

-- signal rss
awesome.connect_signal("daemon::rss", function(rss)
  if rss.threatpost then
    rss_links(rss, "threatpost", rss_threatpost)
  end
  if rss.ycombinator then
    rss_links(rss, "ycombinator", rss_ycombinator)
  end
end)

-- images
local theme_picture_container = wibox.container.background()
theme_picture_container.forced_height = dpi(100)
theme_picture_container.forced_width = dpi(160)

local theme_picture = wibox.widget {
  wibox.widget.imagebox(beautiful.wallpaper),
  widget = theme_picture_container
}

local theme_name = font.h6(theme.name, beautiful.on_surface, 87)
local picture_widget = widget.box('vertical', { theme_picture, theme_name })

-- quotes
local quotes = {
  "Change is neither good nor bad. It simply is.",
  "You're good. Get better. Stop asking for things.",
  "Why does everybody need to talk about everything?",
  "Today's a good day for Armageddon.",
  "In the highest level a man has the look of knowing nothing.",
  "Even if it seems certain that you will lose, retaliate.",
  "The end is important in all things.",
  "Having only wisdom and talent is the lowest tier of usefulness.",
  "Fear stimulates my imagination.",
  "I'm living like there's no tomorrow, cause there isn't one."
}
local quote_title = font.h4("", beautiful.on_surface, 38)
local quote = font.body_text(quotes[math.random(#quotes)])
local quote_widget = widget.box("vertical", { quote_title, quote }, dpi(8))

-- date
local day = wibox.widget.textclock("%d")
day.font = beautiful.font_h4
day.align = "center"

local month = wibox.widget.textclock("%B")
month.font = beautiful.font_body_1
month.align = "left"
month.text = month.text:sub(1,3)
month:connect_signal("widget::redraw_needed", function()
  month.text = month.text:sub(1,3)
end)

local date_widget = wibox.widget {
  {
    day,
    fg = beautiful.primary,
    widget = wibox.container.background
  },
  {
    month,
    fg = beautiful.secondary,
    widget = wibox.container.background
  },
  layout = wibox.layout.fixed.vertical
}

-- function for buttons
local launch_term = function(cmd)
  app.start(cmd, true, nil, start_screen_hide)
end

-- buttons apps
local gimp_cmd = function() exec_prog("gimp") end
local gimp = btext({ fgcolor = "primary", icon = "", command = gimp_cmd })

local game_cmd = function() exec_prog("lutris") end
local game = btext({ fgcolor = "secondary", icon = "", command = game_cmd })

local pentest_cmd = function() launch_term("msfconsole") end
local pentest = btext({ fgcolor = "error", icon = "ﮊ", command = pentest_cmd })

local buttons_widget = widget.box('vertical', { gimp,game,pentest })

-- buttons path
local image_cmd = function() launch_term(env.file_browser .. " ~/images") end
local image = btext({ fg_text = "primary",
  text = "IMAGES", command = image_cmd, width = 80
})

local torrent_cmd = function() launch_term(env.file_browser .. " ~/torrents") end
local torrent = btext({ fg_text = "secondary",
  text = "TORRENTS", command = torrent_cmd, width = 80
})

local movie_cmd = function() launch_term(env.file_browser .. " ~/videos") end
local movie = btext({ fg_text = "error",
  text = "MOVIES", command = movie_cmd, width = 80
})

local buttons_path_1_widget = widget.box('horizontal', { image,torrent }, 15)
local buttons_path_2_widget = widget.box('horizontal', { movie })

-- buttons url
local github_cmd = function() open_link("https://github.com/szorfein") end
local github = btext({ fgcolor = "primary", icon = "", command = github_cmd })

local twitter_cmd = function() open_link("https://twitter.com/szorfein") end
local twitter = btext({ fgcolor = "secondary", icon = "", command = twitter_cmd })

local reddit_cmd = function() open_link("https://reddit.com/user/szorfein") end
local reddit = btext({ fgcolor = "error", icon = "", command = reddit_cmd })

local buttons_url_widget = widget.box('vertical', { github, twitter, reddit })

-- Minimal TodoList
local todo_textbox = wibox.widget.textbox() -- to store the prompt
local history_file = os.getenv("HOME").."/.todoslist"
local todo_max = 6
local todo_list = wibox.layout.fixed.vertical()

local function update_history()
  local history = io.open(history_file, "r")
  if history == nil then return end

  local lines = {}
  todo_list:reset()
  for line in history:lines() do
    table.insert(lines, line)
  end
  history:close()

  for k,v in pairs(lines) do
    if k > todo_max or not v then return end
    local t = font.text_list(v)
    local f = function() remove_todo(v) end -- serve to store the actual line
    local b = btext({ fg_text = "secondary", text = " ", command = f })
    local w = widget.box('horizontal', { b, t })
    todo_list:add(w)
  end
end

function remove_todo(line)
  local line = string.gsub(line, "/", "\\/") -- if contain slash
  local command = "[ -f "..history_file.." ] && sed -i '/"..line.."/d' "..history_file
  awful.spawn.easy_async_with_shell(command, function()
    update_history()
  end)
end

local function exec_prompt()
  awful.prompt.run {
    prompt = " > ",
    fg = beautiful.fg_grey , 
    history_path = os.getenv("HOME").."/.history_todo",
    textbox = todo_textbox,
    exe_callback = function(input)
      if not input or #input == 0 then return end
      local command = "echo "..input.." >> "..history_file
      awful.spawn.easy_async_with_shell(command, function()
        update_history()
      end)
    end
  }
end

local todo_new = btext({ fgcolor = "primary", icon = "",
  font_icon = beautiful.font_button,
  fg_text = "primary", text = " New task",
  command = exec_prompt, layout = "horizontal"
})
local todo_widget = widget.box("horizontal", { todo_new, todo_textbox })

update_history() -- init once the todo

local function boxes(w, width, height, margin)
  local width, height = width, height or 1, 1
  local margin = margin or 1
  local boxed_widget = wibox.widget {
    {
      {
        nil,
        {
          {
            nil,
            w,
            expand = "none",
            layout = wibox.layout.align.vertical
          },
          margins = dpi(10),
          widget = wibox.container.margin,
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      bg = beautiful.grey_dark,
      forced_height = dpi(height),
      forced_width = dpi(width),
      shape = helpers.rrect(10),
      widget = wibox.container.background
    },
    margins = dpi(margin),
    color = "#00000000",
    widget = wibox.container.margin
  }
  return boxed_widget
end

local startscreen = class()

function startscreen:init(s)

  -- the start_screen
  s.start_screen = wibox({ visible = false, ontop = true, type = "dock", screen = s })
  s.start_screen.bg = beautiful.grey .. "00"
  awful.placement.maximize(s.start_screen)

  s.start_screen:buttons(gtable.join(
    awful.button({}, 3, function() start_screen_hide() end)
  ))

  s.start_screen:setup {
    nil,
    {
      nil,
      {
        {
          boxes(date_widget, 100, 120, 1),
          boxes(buttons_widget, 100, 376, 1),
          layout = wibox.layout.fixed.vertical
        },
        {
          nil,
          {
            boxes(picture_widget, 210, 200, 1),
            boxes(quote_widget, 210, 200, 1),
            layout = wibox.layout.fixed.vertical
          },
          nil,
          expand = "none",
          layout = wibox.layout.align.vertical
        },
        {
          boxes(threatpost_widget, feed_width, feed_height, 1),
          boxes(ycombinator_widget, feed_width, feed_height, 1),
          layout = wibox.layout.fixed.vertical
        },
        {
          nil,
          {
            boxes(todo_widget, 210, 50, 0),
            boxes(todo_list, 210, 200, 1),
            boxes(buttons_path_1_widget, 210, 80, 1),
            boxes(buttons_path_2_widget, 210, 80, 1),
            layout = wibox.layout.fixed.vertical
          },
          nil,
          expand = "none",
          layout = wibox.layout.align.vertical
        },
        {
          boxes(buttons_url_widget, 100, 376, 1),
          layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.horizontal
      },
      nil,
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
  }
end

return startscreen
