---------------------------
-- Worker awesome theme --
---------------------------

local theme_name = "worker"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local gshape = require("gears.shape")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layouts/"
local xrdb = xresources.get_current_theme()
local wibox = require("wibox")
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"

local theme = {}

-- Get colors from .Xresources and set fallback colors
theme.alert_light = xrdb.color3 or "#E49186"

theme.bg_normal     = M.x.background
theme.bg_focus      = M.x.secondary
theme.bg_urgent     = M.x.error
--theme.bg_minimize   = "#444444"
--theme.bg_systray    = theme.xbackground

theme.fg_normal     = M.x.on_background
theme.fg_focus      = M.x.on_background
theme.fg_urgent     = M.x.on_error
theme.fg_minimize   = M.x.on_background

theme.border_width  = dpi(3)
theme.screen_margin = dpi(6)
theme.useless_gap   = dpi(1)
theme.border_normal = M.x.background
theme.border_focus  = M.x.background
theme.border_radius = dpi(18)

-- general padding
theme.general_padding = { left = dpi(0), right = dpi(0), top = dpi(0), bottom = dpi(0) }

-- smart border
theme.double_border = false
theme.double_border_normal = M.x.background
theme.double_border_focus = M.x.on_background

-- {{{ Tooltip

theme.tooltip_bg = M.x.surface
theme.tooltip_fg = M.x.on_surface

-- }}} 

-- {{{ TITLEBAR 

theme.titlebar_fg_normal = M.x.on_background
theme.titlebar_bg_normal = M.x.background
theme.titlebar_fg_focus = M.x.on_background
theme.titlebar_bg_focus = M.x.background
theme.titlebars_enabled = true
theme.titlebar_title_enabled = true 
theme.titlebar_internal_border = true
theme.titlebar_internal_border_colors = { M.x.primary, M.x.secondary } -- 1:focus, 2:unfocus
theme.titlebar_buttons_enabled = true
theme.titlebars_imitate_borders = false
theme.titlebars_imitate_borders_size = 2
theme.titlebar_size = dpi(20)
-- }}} End TITLEBAR

-- Gravities
theme.gravity_ncmpcpp = { 16, 12, 31, 45 }
theme.gravity_cava = { 16, 61, 31, 19 }
theme.gravity_music_term = { 49, 12, 34, 68 }

-- Top bar
theme.wibar_size = dpi(40)
theme.wibar_bg = M.x.background .. "fa"
theme.wibar_border_radius = dpi(0)
theme.wibar_position = "top"

-- {{{ TAGLIST

-- Nerd Font icon here
theme.tagnames = {" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 10 "}
-- mini_taglist
theme.taglist_text_occupied = {"-","-","-","-","-","-","-","-","-","-"}
theme.taglist_text_focused = {"-","-","-","-","-","-","-","-","-","-"}
theme.taglist_text_urgent = {"-","-","-","-","-","-","-","-","-","-"}
theme.taglist_text_empty = {"-","-","-","-","-","-","-","-","-","-"}

theme.taglist_bg_focus = M.x.background
theme.taglist_bg = M.x.background .. "fa"

-- icon_taglist
theme.ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, theme.ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- different color on each taglists
--theme.taglist_text_color_empty = { theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark, theme.grey_dark }

--theme.taglist_text_color_occupied = { theme.grey, theme.primary, theme.secondary, theme.grey, theme.primary, theme.secondary, theme.grey, theme.primary, theme.secondary, theme.grey }

--theme.taglist_text_color_focused = { theme.grey_light, theme.primary_light, theme.secondary_light, theme.grey_light, theme.primary_light, theme.secondary_light, theme.grey_light, theme.primary_light, theme.secondary_light, theme.grey_light }

--theme.taglist_text_color_urgent = { theme.alert_dark, theme.alert, theme.alert_light, theme.alert_dark, theme.alert, theme.alert_light, theme.alert_dark, theme.alert, theme.alert_light, theme.alert }

theme.taglist_layout = wibox.layout.fixed.horizontal -- horizontal or vertical

-- }}} TAGLIST END

-- {{{ MENU

theme.menu_submenu_icon = themes_path.."theme_name../submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- }}} End MENU

theme.wallpaper = os.getenv("HOME").."/images/"..M.name..".jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, M.x.secondary, M.x.on_secondary -- height, bg, fg
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = nil

-- {{{ Tasklist

--theme.tasklist_disable_task_name = true
--theme.tasklist_disable_icon = false
theme.tasklist_spacing = dpi(4)
theme.tasklist_align = "center"
theme.tasklist_fg_normal = M.x.on_background
theme.tasklist_bg_normal = M.x.background.."29"
theme.tasklist_bg_focus = M.x.background.."29"
theme.tasklist_bg_urgent = M.x.error.."29"

-- }}} End Tasklist

-- {{{ WIDGETS

theme.widget_spacing = dpi(20) -- space between each widgets
-- popup (distance between the bar and the popup, 0 is pasted at the bar)
theme.widget_popup_padding = dpi(3)

-- Hostname
theme.widget_hostname_text_icon = '<span foreground="'..M.x.primary..'">  </span>'

-- Tor
theme.widget_tor_icon = "  﨩  "
theme.widget_tor_fg_enable = M.x.primary
theme.widget_tor_fg_disable = M.x.primary
theme.widget_tor_bg = M.x.background

-- Mails
theme.widget_email_read_icon = "  "
theme.widget_email_unread_icon = "  "
theme.widget_email_fg_read = M.x.on_background
theme.widget_email_fg_unread = M.x.on_background
theme.widget_email_bg = M.x.background
theme.widget_email_layout = 'horizontal' -- horizontal or vertical
theme.widget_email_type = 'button' -- button or text

-- Wifi str
theme.widget_wifi_str_fg = M.x.primary
theme.widget_wifi_str_bg = M.x.background .. "00"
theme.widget_wifi_layout = 'horizontal' -- horizontal or vertical

-- Battery
theme.widget_battery_icon_discharging = ""
theme.widget_battery_icon_charging = ""
theme.widget_battery_icon_full = ""
theme.widget_battery_icon_ac = "臘"
theme.widget_battery_bg = M.x.background

-- mpc
theme.widget_mpc_fg = M.x.on_background
theme.widget_mpc_bg = M.x.background
theme.widget_mpc_layout = 'horizontal' -- horizontal or vertical

-- Date
theme.widget_date_icon = ""
theme.widget_date_fg = M.x.on_background
theme.widget_date_bg = M.x.background
theme.widget_date_layout = 'horizontal' -- horizontal or vertical

-- Screenshot
theme.widget_scrot_fg = M.x.on_background
theme.widget_scrot_icon = ''

-- button music
theme.widget_button_music_layout = 'horizontal'

-- Button mpc
theme.widget_mpc_button_icon = "ﱘ"

-- }}} End WIDGET

return theme
