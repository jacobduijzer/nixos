{ dmenu, i3status }:
''
# Alt key is Mod1, and Windows key is Mod4
set $mod Mod4
set $mod4 Mod1

#set $monitorUp DP-2-8
set $monitorUp DP-3
set $monitorLaptop eDP-1

# IT&Care
#set $monitorLeft DVI-I-1-2
#set $monitorlaptop DVI-I-2-2

# This is the Solarized color palette.
#set $base03    #002b36
#set $base02    #073642
#set $base01    #586e75
#set $base00    #657b83
#set $base0     #839496
#set $base1     #93a1a1
#set $base2     #eee8d5
#set $base3     #fdf6e3
#set $yellow    #b58900
#set $orange    #cb4b10
#set $red       #dc322f
#set $magenta   #d33682
#set $violet    #6c71c4
#set $blue      #268bd2
#set $cyan      #2aa198
#set $green     #859900
set $realOrange #FF8E0D

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

workspace 1 output $monitorUp
workspace 2 output $monitorUp
workspace 3 output $monitorUp
workspace 4 output $monitorUp
workspace 5 output $monitorUp
workspace 6 output $monitorUp
workspace 7 output $monitorLaptop
workspace 8 output $monitorLaptop
workspace 9 output $monitorLaptop
workspace 10 output $monitorLaptop
 
# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

hide_edge_borders smart 

# start a terminal
bindsym $mod+Return exec /etc/profiles/per-user/jacob/bin/alacritty

# start slop (zoom / magnify>
bindsym $mod+z exec slop -r relscrzoom

# start a web browser
bindsym $mod+Shift+Return exec /etc/profiles/per-user/jacob/bin/vivaldi

# screenshots
bindsym $mod+Print exec /home/jacob/.nix-profile/bin/flameshot gui

# volume keys
bindsym XF86AudioRaiseVolume exec "pactl set-sink-volume @DEFAULT_SINK@ +1%"
bindsym XF86AudioLowerVolume exec "pactl set-sink-volume @DEFAULT_SINK@ -1%"
bindsym XF86AudioMute exec "amixer -q sset Master,0 toggle"
bindsym XF86Calculator exec "~/.dotfiles/polybar/modules/polybar-spotify-play-pause/spotify-play-pause.sh toggle"

# brightness
bindsym XF86MonBrightnessDown exec "/home/jacob/scripts/brightness.sh - eDP-1 0.05"
bindsym XF86MonBrightnessUp exec "/home/jacob/scripts/brightness.sh + eDP-1 0.05"

# kill focused window
bindsym $mod+Shift+q kill

# rofi app and window launchers
bindsym $mod+space exec rofi -show drun 
bindsym $mod+Shift+space exec rofi -show run 
#bindsym $mod+Ctrl+space exec rofi -show window 
#bindsym $mod+Ctrl+space exec --no-startup-id ~/.dotfiles/i3/layout_manager.sh
bindsym $mod+Mod1+space exec /usr/bin/bwmenu
bindsym $mod+Ctrl+space exec rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'

# change focus
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# move windows in workspaces
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# move to other screen
bindsym $mod+shift+p move workspace to output right

# move to monitorLaptop
bindsym $mod+Ctrl+h move workspace to output left
bindsym $mod+Ctrl+j move workspace to output down 
bindsym $mod+Ctrl+k move workspace to output up 
bindsym $mod+Ctrl+l move workspace to output right

# toggle split orientation
#bindsym $mod+Ctrl+Mod1+v layout splitv
#bindsym $mod+Ctrl+Mod1+h layout splith

bindsym $mod+BackSpace split toggle

# split in horizontal orientation
#bindsym $mod+Ctrl+h split h

# split in vertical orientation
#bindsym $mod+Ctrl+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change gaps interactively
bindsym $mod+minus gaps inner current minus 6
bindsym $mod+plus gaps inner current plus 6

# show/hide keybindings
bindsym $mod+Shift+question exec --no-startup-id /usr/bin/conky-toggle.sh

# toggle tiling / floating
bindsym $mod+Shift+f floating toggle

# change focus between tiling / floating windows
#bindsym $mod+Shift+t focus mode_toggle
bindsym $mod+Shift+t layout tabbed
bindsym $mod+Shift+s layout toggle split 

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10

# cycle between workspace
bindsym $mod+Tab workspace back_and_forth

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1; workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2; workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3; workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4; workspace $ws4 
bindsym $mod+Shift+5 move container to workspace $ws5; workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6; workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7; workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8; workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9; workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10; workspace $ws10

# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# lock the screen
#bindsym $mod+Escape exec $HOME/.dotfiles/i3/i3lock.sh
#bindsym $mod+Escape exec betterlockscreen -l dimblur
bindsym $mod+Shift+Escape exec ~/.dotfiles/i3/blur-lock.sh

bindsym $mod+Shift+x mode "$mode_system"
set $mode_system Lock: l | Logout: o | Suspend: u | Hibernate: h | Reboot: r | Shutdown: s
mode "$mode_system" {
  bindsym l exec --no-startup-id $HOME/.dotfiles/i3/i3exit.sh lock, mode "default"
  bindsym o exec --no-startup-id $HOME/.dotfiles/i3/i3exit.sh logout, mode "default"
  bindsym u exec --no-startup-id $HOME/.dotfiles/i3/i3exit.sh suspend, mode "default"
  bindsym h exec --no-startup-id $HOME/.dotfiles/i3/i3exit.sh hibernate, mode "default"
  bindsym r exec --no-startup-id $HOME/.dotfiles/i3/i3exit.sh reboot, mode "default"
  bindsym s exec --no-startup-id $HOME/.dotfiles/i3/i3exit.sh shutdown, mode "default"

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}

# scratchpad
bindsym $mod+Shift+minus move scratchpad
bindsym $mod+Ctrl+minus scratchpad show
bindsym $mod+F12 scratchpad show

# code scratchpad
for_window [class="(?i)macs"] floating enable 
for_window [floating] floating enable, resize set 1400 1200, move position center
for_window [class="Yad" title="yad-calendar"] floating enable

bindsym $mod+m mode "Move Mode"
mode "Move Mode" {
  bindsym 1 exec --no-startup-id $HOME/.dotfiles/i3/movewindow.sh 1
  bindsym 2 exec --no-startup-id $HOME/.dotfiles/i3/movewindow.sh 2
  bindsym 3 exec --no-startup-id $HOME/.dotfiles/i3/movewindow.sh 3
  bindsym 4 exec --no-startup-id $HOME/.dotfiles/i3/movewindow.sh 4
  bindsym 5 exec --no-startup-id $HOME/.dotfiles/i3/movewindow.sh 5

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
  bindsym $mod+m mode "default"
}

# shortcuts for common system configuration tasks
# resize window (you can also use the mouse for that)
mode "Resize Mode" {
        # These bindings trigger as soon as you enter the resize mode
        bindsym Left resize shrink width 6 px or 6 ppt
        bindsym Down resize grow height 6 px or 6 ppt
        bindsym Up resize shrink height 6 px or 6 ppt
        bindsym Right resize grow width 6 px or 6 ppt

        bindsym Shift+Left resize shrink width 12 px or 12 ppt
        bindsym Shift+Down resize grow height 12 px or 12 ppt
        bindsym Shift+Up resize shrink height 12 px or 12 ppt
        bindsym Shift+Right resize grow width 12 px or 12 ppt

        bindsym h resize shrink width 6 px or 6 ppt
        bindsym k resize grow height 6 px or 6 ppt
        bindsym j resize shrink height 6 px or 6 ppt
        bindsym l resize grow width 6 px or 6 ppt

        bindsym Shift+h resize shrink width 12 px or 12 ppt
        bindsym Shift+k resize grow height 12 px or 12 ppt
        bindsym Shift+j resize shrink height 12 px or 12 ppt
        bindsym Shift+l resize grow width 12 px or 12 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}
bindsym $mod+x exec autorandr --change
bindsym $mod+r mode "Resize Mode"
# border on all windows
for_window [class=.*] border pixel 1

# default_border pixel 1
default_floating_border pixel 0

# Gaps (i3-gaps)
gaps inner 0
gaps outer 0 

# Only enable gaps on a workspace when there is at least one container
smart_gaps on

# class                 border      bground text    indicator child_border
client.focused          $realOrange #285577  #FFFFFF #FF8E0D  $realOrange 
client.focused_inactive #000000 #5F676A #FFFFFF #484E50   #5F676A
client.unfocused        #000000 #222222 #888888 #292D2E   #222222
client.urgent           #2F343A #900000 #FFFFFF #900000   #900000
client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C
client.background       #FFFFFF

# Enable popup during fullscreen
popup_during_fullscreen leave_fullscreen

# window focus follows your mouse movements as the mouse crosses window borders
focus_follows_mouse yes

# Run programs when i3 starts
#exec --no-startup-id $HOME/.dotfiles/scripts/home_dual_top.sh
#exec --no-startup-id $HOME/.dotfiles/i3/wallpaper.sh
#exec --no-startup-id /usr/bin/dunst

# Compositor
#exec --no-startup-id picom --config $HOME/.config/picom/picom.conf

# Menu bar
#exec --no-startup-id $HOME/.config/polybar/launch.sh
exec --no-startup-id /run/current-system/sw/bin/polybar

# Clipboard manager
#exec --no-startup-id greenclip daemon
#exec --no-startup-id /usr/bin/clipit 
#exec --no-startup-id xautolock -time 10 -locker "$HOME/.dotfiles/i3/i3lock.sh"
# hides mouse when not using
#exec --no-startup-id unclutter --timeout 2 --jitter 5  

# Auto-resize Rider with other window
#bindsym $mod+Shift+z exec --no-startup-id $HOME/.dotfiles/i3/window_resizer.sh

# Screen binding for touch
#exec --no-startup-id xinput --map-to-output 'ELAN901C:00 04F3:2C29' eDP-1

# Assign apps to workspaces
for_window [class="Spotify"] move to workspace $ws7
for_window [class="Ferdi"] move to workspace $ws8
for_window [class="Slack"] move to workspace $ws9
for_window [class="Microsoft Teams - initializing..."] move to workspace $ws10
''
