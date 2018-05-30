#
# Default options
#

set :increase_step, 1
set :border_snap, 10
set :default_gravity, :ct
set :urgent_dialogs, false
set :honor_size_hints, false
set :gravity_tiling, true
set :click_to_focus, false
set :skip_pointer_warp, true 
set :skip_urgent_warp, true 

#
# Screen & bar, we use polybar
#

screen 1 do
  top    [ ]
  bottom [ ]
end

#screen 2 do
#  top    [ ]
#  bottom [ ]
#end

#
# Styles
#

style :all do
    padding      0
    margin       0
    font        "-*-*-*-*-*-*-14-*-*-*-*-*-*-*"
    border      "#ff3030", 0
    background  "#202020"
end

style :views do 
    style :focus do
        border "#ffec26", 0
    end
end

style :clients do
    border "#00ff00", 0
    padding      0
    margin_left  7
    margin_right   7
    margin_top   7
    margin_bottom   7
end

#
#  Gravities
#

# Center
gravity :ct, [ 5, 14, 90, 79 ]
gravity :ct66, [ 25, 25, 50, 50 ]

# Gimp
gravity :gimp_image, [ 5, 14, 90, 79 ]
gravity :gimp_toolbox, [ 4, 5, 12, 93 ]
gravity :gimp_dock, [ 84, 5, 12, 93 ]

#
# Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4
grab "W-S-5", :ViewJump5

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4
grab "W-5", :ViewSwitch5

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4
grab "W-A-5", :ScreenJump5

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-Left",  :WindowLeft
grab "W-Down",  :WindowDown
grab "W-Up",    :WindowUp
grab "W-Right", :WindowRight

# Kill current window
grab "W-z", :WindowKill

# Cycle between given gravities
grab "W-F1", [ :float_l, :float_r ]
grab "W-F2", [ :ct, :ct66 ]
grab "W-F3", [ :d1, :d2, :d3 ]
grab "W-F4", [ :pp, :we, :mu, :ca, :ma ]

# Exec programs
grab "W-Return", "termite"
grab "W-p", "rofi -show run"

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

# custom grab
grab "C-A-Right", "mpc next"
grab "C-A-Left", "mpc prev"
grab "S-A-d", "mpc del 0"
grab "C-A-Up", "mpc volume +2"
grab "C-A-Down", "mpc volume -2"
grab "G-F9", "xbacklight +1"
grab "G-F8", "xbacklight -1"

#
# Tags
#

tag "terms" do
    match :instance => "xterm|[u]?rxvt|termite|kitty"
end

tag "browser", "uzbl|opera|firefox|navigator|vivaldi"

tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim"
  resize true
end

tag "gravity" do
  gravity :ct
end

# Modes
tag "stick" do
  match "mplayer|mpv"
  float true
  stick true
end

tag "imgs" do
  match "sxiv|feh"
  gravity :ct66
end

tag "float" do
  match "display"
  float true
end

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox-*"
  gravity :gimp_toolbox
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
end

tag "gimp_scum" do
  match role: "gimp-.*|screenshot"
end

## programs on view console [4]
gravity :pp, [ 34, 14, 32, 21 ]
gravity :we, [ 5, 14, 29, 79 ]
gravity :mu, [ 66, 14, 29, 41 ]
gravity :ca, [ 66, 55, 29, 38 ]
gravity :ma, [ 34, 35, 32, 58 ]

tag "pwd" do
    match "pwd"
    gravity :pp
end

tag "chat" do
    match :instance => "weechat"
    gravity :we
end

tag "music" do
    match :instance => "ncmpcpp"
    gravity :mu
end

tag "cava" do
    match :instance => "cava"
    gravity :ca
end

tag "mail" do
    match :instance => "mutt"
    gravity :ma
end

## programs on view dev [3]
gravity :d1, [ 5, 14, 30, 79 ]
gravity :d2, [ 35, 14, 30, 79 ]
gravity :d3, [ 65, 14, 30, 79 ]

tag "code_1" do
  match "code-1"
  padding 0
  margin 0
  gravity :d1
end

tag "code_2" do
  match "code-2"
  gravity :d2
end

tag "code_3" do
  match "code-3"
  gravity :d3
end

tag "code_4" do
  match "code-4"
  gravity :d1
end

tag "code_5" do
  match "code-5"
  gravity :d2
end

tag "code_6" do
  match "code-6"
  gravity :d3
end

## view on default terms [1]
gravity :float_l, [ 12, 14, 38, 79 ]
gravity :float_r, [ 50, 14, 38, 79 ]

#
# View
#

view "terms", "terms|imgs|default"
view "www",   "browser"
view "dev",   "code_.*"
view "console", "pwd|music|cava|chat|mail"
view "gimp",  "gimp_.*"

#
# Autorun
#

on :start do
    Subtlext::Client.spawn( "termite" )
    Subtlext::Client.spawn( "firejail vivaldi" )
    Subtlext::Client.spawn( "sh ~/.config/polybar/launch.sh" )
    Subtlext::Client.spawn( "sh ~/.config/subtle/init_desktop_3.sh" )
    Subtlext::Client.spawn( "sh ~/.config/subtle/init_desktop_4.sh" )
end

on :reload do
    Subtlext::Client.spawn( "sh ~/.config/polybar/launch.sh" )
end
