# -*- encoding: utf-8 -*-

# Window move/resize steps in pixel per keypress
set :increase_step, 5

# Window screen border snapping
set :border_snap, 10

# Default starting gravity for windows. Comment out to use gravity of
# currently active client
set :default_gravity, :ct

# Make dialog windows urgent and draw focus
set :urgent_dialogs, false

# Honor resize size hints globally
set :honor_size_hints, false

# Enable gravity tiling for all gravities
set :gravity_tiling, true 

# Enable click-to-focus focus model
set :click_to_focus, false

# Skip pointer movement on e.g. gravity change
set :skip_pointer_warp, false

# Skip pointer movement to urgent windows
set :skip_urgent_warp, false

# Set the WM_NAME of subtle (Java quirk)
# set :wmname, "LG3D"

#
# Screen
#

screen 1 do
  top    [ ]
  bottom [ ]
end

# Example for a second screen:
#screen 2 do
#  top    [ :views, :title, :spacer ]
#  bottom [ ]
#end

#
# Styles
#

# Style for all style elements
style :all do
  background  "#202020"
  icon        "#757575"
  border      "#303030", 0
  padding     0, 3
  font        "-*-*-*-*-*-*-14-*-*-*-*-*-*-*"
  #font        "xft:sans-8"
end

#
#  Gravities
#

# Top left
#   OR       OR
# | | | |  |  |  |
# | | | |  | | | |
# |  |  |  | | | |

# Other
#   | |
# | | | |
#   | |

# First gravity | left side | right side
#
#
gravity :l_side, [ 1, 6, 49, 90 ]
gravity :r_side, [ 50, 6, 49, 90 ]

#
gravity :tl_a1,     [   1,   6,  32,  30 ]
gravity :tl_a2,     [   1,   6,  48,  30 ]
gravity :tl_a3,     [   1,   6,  65,  30 ]

gravity :tl_b1,     [   1,   6,  32,  45 ]
gravity :tl_b2,     [   1,   6,  48,  45 ]
gravity :tl_b3,     [   1,   6,  65,  45 ]

gravity :tl_c1,     [   1,   6,  32,  60 ]
gravity :tl_c2,     [   1,   6,  48,  60 ]
gravity :tl_c3,     [   1,   6,  65,  60 ]

# Top center
gravity :tc_a1,     [   1,   6, 98,  43 ]
gravity :tc_a2,     [   1,   6, 98,  60 ]
gravity :tc_a3,     [   1,   6, 98,  30 ]

gravity :tc_b1,     [  34,   6,  32,  30 ]
gravity :tc_b2,     [  34,   6,  32,  45 ]
gravity :tc_b3,     [  34,   6,  32,  60 ]

# Top right
gravity :tr_a1,     [  67,   6,  32,  30 ]
gravity :tr_a2,     [  50,   6,  49,  30 ]
gravity :tr_a3,     [  34,   6,  65,  30 ]

gravity :tr_b1,     [  67,   6,  32,  45 ]
gravity :tr_b2,     [  50,   6,  49,  45 ]
gravity :tr_b3,     [  34,   6,  65,  45 ]

gravity :tr_c1,     [  67,   6,  32,  60 ]
gravity :tr_c2,     [  50,   6,  49,  60 ]
gravity :tr_c3,     [  34,   6,  65,  60 ]

# Left
gravity :l_a1,      [   1,  37,  32,  29 ]
gravity :l_a2,      [   1,  37,  48,  29 ]
gravity :l_a3,      [   1,  37,  65,  29 ]

gravity :l_b1,      [   1,   6,  32, 90 ]
gravity :l_b2,      [   1,   6,  48, 90 ]
gravity :l_b3,      [   1,   6,  65, 90 ]

# Center
gravity :ct,        [ 1, 6, 98, 90 ]
gravity :ct33,      [  34,  37,  32,  29 ] 
gravity :ct66,      [  25,  25,  50,  50 ], :vert
gravity :ct40,      [  1,  37,  98,  29 ]

# Right
gravity :r_a1,      [  67,  37,  32,  29 ]
gravity :r_a2,      [  50,  37,  49,  29 ]
gravity :r_a3,      [  34,  37,  65,  29 ]

gravity :r_b1,      [  67,   6,  33, 90 ]
gravity :r_b2,      [  50,   6,  49, 90 ]
gravity :r_b3,      [  34,   6,  65, 90 ]

# Bottom left
gravity :bl_a1,     [   1,  67,  32,  29 ]
gravity :bl_a2,     [   1,  67,  48,  29 ]
gravity :bl_a3,     [   1,  67,  65,  29 ]

gravity :bl_b1,     [   1,  52,  32,  44 ]
gravity :bl_b2,     [   1,  52,  48,  44 ]
gravity :bl_b3,     [   1,  52,  65,  44 ]

gravity :bl_c1,     [   1,  38,  32,  58 ]
gravity :bl_c2,     [   1,  38,  48,  58 ]
gravity :bl_c3,     [   1,  38,  65,  58 ]
     
# Bottom center
gravity :bc_a1,     [   1,  52, 98,  44 ]
gravity :bc_a2,     [   1,  37, 98,  59 ]
gravity :bc_a3,     [   1,  67, 98,  29 ]

gravity :bc_b1,     [  34,  67,  32,  29 ]
gravity :bc_b2,     [  34,  52,  32,  44 ]
gravity :bc_b3,     [  34,  37,  32,  59 ]

# Bottom right
gravity :br_a1,     [  67,  67,  32,  29 ]
gravity :br_a2,     [  50,  67,  49,  29 ]
gravity :br_a3,     [  34,  67,  65,  29 ]

gravity :br_b1,     [  67,  52,  32,  44 ]
gravity :br_b2,     [  50,  52,  49,  44 ]
gravity :br_b3,     [  34,  52,  32,  44 ]

gravity :br_c1,     [  67,  37,  32,  59 ]
gravity :br_c2,     [  50,  37,  49,  59 ]
gravity :br_c3,     [  34,  37,  65,  59 ]

# Special
gravity :sp_br,     [  70,  85,  30,  15 ]
gravity :sp_bl,     [   0,  85,  30,  15 ]
gravity :sp_tr,     [  70,   7,  30,  15 ]
gravity :sp_tl,     [   0,   7,  30,  15 ]

# Gimp
gravity :gimp_image,        [  24,   8,  50, 66 ]
gravity :gimp_toolbox,      [   3,   10,  10, 75 ]
gravity :gimp_dock,         [  85,   7,  12, 90 ]

#
# Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4

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
grab "W-F1",      [ :l_side, :r_side ]
grab "W-F2",      [ :tc_b1, :tc_b2, :tc_b3, :tc_a3, :tc_a1, :tc_a2 ]
grab "W-F3",      [ :tr_a1, :tr_a2, :tr_a3, :tr_b1, :tr_b2, :tr_b3, :tr_c1, :tr_c2, :tr_c3 ]
grab "W-F4",      [ :r_a1, :r_a2, :r_a3, :r_b1, :r_b2, :r_b3 ]
grab "W-F5",      [ :br_a1, :br_a2, :br_a3, :br_b1, :br_b2, :br_b3, :br_c1, :br_c2, :br_c3 ]
grab "W-F6",      [ :bc_b1, :bc_b2, :bc_b3, :bc_a3, :bc_a1, :bc_a2 ]
grab "W-F7",      [ :bl_a1, :bl_a2, :bl_a3, :bl_b1, :bl_b2, :bl_b3, :bl_c1, :bl_c2, :bl_c3 ]
grab "W-F8",      [ :l_a1, :l_a2, :l_a3, :l_b1, :l_b2, :l_b3 ]
grab "W-F9",      [ :ct33, :ct66, :ct, :ct40 ]
grab "W-F10",     [ :sp_br, :sp_bl, :sp_tr, :sp_tl ]

# Exec programs
grab "W-Return", "kitty"
grab "W-p", "rofi -show run -width 40 -lines 2 -line-padding 4"

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

# Simple tags
tag "terms" do
    match :instance => "xterm|[u]?rxvt|termite|kitty"
end

tag "browser", "uzbl|opera|firefox|navigator|vivaldi"

# Placement
tag "editor" do
  match  "[g]?vim"
  resize true
end

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

gravity :pp,     [   33,   9,  34,  19 ]
gravity :we,     [   4,   13,  28,  72 ]
gravity :mu,     [   68,   13,  28,  72 ]
gravity :ma,     [   33,   30,  34,  60 ]

tag "pwd" do
    match "pwd"
    gravity :pp
end

tag "chat" do
    match :instance => "weechat"
    gravity :we
end

tag "music" do
    match :instance => "ncmpcpp|cava"
    gravity :mu
end

tag "mail" do
    match :instance => "mutt"
    gravity :ma
end

#
# View
#

view "terms", "terms|default"
view "www",   "browser"
view "console", "pwd|music|chat|mail"
view "gimp",  "gimp_.*"
view "dev",   "editor"

#
# Snippet
#

def goto_next_view(vArr)
    cindx = vArr.index(Subtlext::View.current);

    #Find the next view beyond all existing
    for i in 1..vArr.size do
        cV = vArr[(i + cindx) % vArr.size];

        # Verify that the potential next view isn't displayed on another screens
        if (Subtlext::View.visible.index(cV) == nil) then
            containsClients = false;
            # Check if the view has clients and if those clients are not only sticky one.
            cV.clients.each {|c|
                containsClients = !(cV.tags & c.tags).empty?;
                if(containsClients)
                    break;
                end
            }

            if (containsClients) then
                cV.jump;
                break;
            end;
        end
    end
end

grab "W-Tab" do
    goto_next_view(Subtlext::View[:all]);
end

grab "W-S-Tab" do
    goto_next_view(Subtlext::View[:all].reverse);
end

#
# Autorun
#

on :start do
    Subtlext::Client.spawn( "kitty" )
    Subtlext::Client.spawn( "vivaldi_sec" )
    Subtlext::Client.spawn( "sh ~/.config/polybar/launch.sh" )
    Subtlext::Client.spawn( "sh ~/.config/subtle/init_desktop_2.sh" )
end

on :reload do
    Subtlext::Client.spawn( "sh ~/.config/polybar/launch.sh" )
end
