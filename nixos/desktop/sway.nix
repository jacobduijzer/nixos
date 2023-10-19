# Nice example here: https://github.com/Riey/home.nix/blob/master/sway.nix 

{ pkgs, lib, ... }:
{
  services.xserver.excludePackages = [ pkgs.xterm ];

  home-manager.users.jacob = { pkgs, config, lib, ... }: {
    home.packages = with pkgs; [
      swaybg
      waybar
      mako
      nwg-launchers
      autotiling
      wayshot
      brightnessctl
    ];
    
    programs.swaylock = {
      enable = true;
      settings = {
        clock = true;
        screenshots = true;
        effect-blur = "7x5";
        indicator-radius = 100;
        indicator-thickness = 7;
        key-hl-color = "880033";
        line-color = "000000";
        inside-color = "000000";
        separator-color = "000000";
        ring-color = "ff8e0d";
        text-color = "ffffff";
        grace = 1;
      };
    };

    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 285;
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 15000";
        }
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
    };

    services.kanshi = {
      enable = true;
      systemdTarget = "sway-session.target";
      profiles = {
        default = {
          outputs = [
          {
            criteria = "IVO 0x8C44 Unknown";
            mode = "1920x1200";
            position = "960,0";
          }
          {
            criteria = "Iiyama North America PL3288UH 1169605112752";
            mode = "3840x2160";
            position = "0,1200";
          }];
        };
        living = {
          outputs = [{
            criteria = "Iiyama North America PLX2483H 1127940905490";
            mode = "1920x1080";
            position = "0,0";
          }{
            criteria = "IVO 0x8C44 Unknown";
            mode = "1920x1200";
            position = "0,1080";
          }];
        };
        rockstars = {
          outputs = [
            {
              criteria = "IVO 0x8C44 Unknown";
              mode = "1920x1200";
              position = "320,1440";
            }
            {
              criteria = "HP Inc. HP E27u G4 CN41200S9D";
              mode = "2560x1440";
              position = "0,0";
            }
          ];
        };
        itandcare = {
          outputs = [
            {
              criteria = "Dell Inc. DELL U2415 7MT016C93KPS";
              mode = "1920x1200";
              position = "0,0";
            }
            {
              criteria = "IVO 0x8C44 Unknown";
              mode = "1920x1200";
              position = "0,1200";
            }
          ];
        };
        itandcare2 = {
          outputs = [
            {
              criteria = "Dell Inc. DELL U2415 7MT016CD0J7S";
              mode = "1920x1200";
              position = "0,0";
            }
            {
              criteria = "IVO 0x8C44 Unknown";
              mode = "1920x1200";
              position = "0,1200";
            }
          ];
        };      };
    };

    services.swayosd.enable = true;
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      wrapperFeatures.base = true;

      extraSessionCommands = ''
        _JAVA_AWT_WM_NONREPARENTING=1
        XDG_SESSION_TYPE=wayland
        XDG_SESSION_DESKTOP=sway
        XDG_CURRENT_DESKTOP=sway
        QT_QPA_PLATFORM=wayland
        #QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        CLUTTER_BACKEND=wayland
        SDL_VIDEODRIVER=wayland
        #MOZ_ENABLE_WAYLAND = "1";
        #NIXOS_OZONE_WL = "1";
      '';
      config = {
        fonts = {
          names = [ "JetBrainsMono Nerd Font" "FontAwesome" ];
          size = 12.0;
        };  
        terminal = "alacritty";
        modifier = "Mod4";

        bars = [{ command = "waybar"; }];

        output = {
          "*" = {
            background = "~/.dotfiles/nixos/desktop/wallpapers/nixos-wallpaper-dark.png fill";
          };
          #"eDP-1" = {
          #  position = "0,1080";
          #};
          #"HDMI-A-1" = {
          #  position = "0,0";
          #};
        };

        startup = [
          { command = "autotiling"; }
        ];

        keybindings = 
        let
          mod = "Mod4";
          term = "alacritty";
          app-menu = "rofi";
          power-menu = "nwgbar";
          lockscreen = "swaylock";
        in {
          # Start terminal
          "${mod}+Return" = "exec ${term}";

          "${mod}+space" = "exec ${app-menu} -show drun";

          "${mod}+Mod1+space" = "exec /usr/bin/bwmenu";
          # Start browser
          "${mod}+Shift+Return" = "exec /etc/profiles/per-user/jacob/bin/vivaldi";
          # Lock screen with blur
          "${mod}+Shift+Escape" = "exec ${lockscreen}";
		
          "${mod}+Escape" = "exec ${power-menu}";
          # Kill programs
          "${mod}+Shift+q" = "kill";
          # Reload the configuration file
          "${mod}+Shift+c" = "reload";
          # Screenshot
          "${mod}+Print" = "exec grimshot --notify save area - | swappy -f -";
          # Exit sway (logs you out of your Wayland session)
          "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          # Move your focus around
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          # Or use $mod+[up|down|left|right]
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          # Move the focused window with the same, but add Shift
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          # Ditto, with arrow keys
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
          # move workspace to different monitor
          "${mod}+Control+Left" = "move workspace to output left";
          "${mod}+Control+Down" = "move workspace to output down";
          "${mod}+Control+Up" = "move workspace to output up";
          "${mod}+Control+Right" = "move workspace to output right";
          "${mod}+Control+h" = "move workspace to output left";
          "${mod}+Control+j" = "move workspace to output down";
          "${mod}+Control+k" = "move workspace to output up";
          "${mod}+Control+l" = "move workspace to output right";
          # Switch to workspace
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          # Move focused container to workspace
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+sHIFT+9" = "MOve container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
          # Layout
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          # Switch the current container between different layout styles
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          # Make the current focus fullscreen
          "${mod}+f" = "fullscreen";
          # Toggle the current focus between tiling and floating mode
          "${mod}+Shift+space" = "floating toggle";

          # Scratchpad:
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+Shift+equal" = "scratchpad show";

          "${mod}+r" = "mode resize";
          "${mod}+t" = "exec swaymsg opacity 0.4";
          "${mod}+Shift+t" = "exec swaymsg opacity 1";

          # Audio
          "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "XF86Calculator" = "exec playerctl play-pause";
          # Sink volume raise optionally with --device
          "XF86AudioRaiseVolume" = "exec swayosd --output-volume raise";
          # Sink volume lower optionally with --device
          "XF86AudioLowerVolume" = "exec swayosd --output-volume lower";
          # Sink volume toggle mute
          "XF86AudioMute" = "exec swayosd --output-volume mute-toggle";
          # Mute input
          "XF86AudioMute+Shift" = "exec swayosd --input-volume mute-toggle";
          # Source volume toggle mute
          "XF86AudioMicMute" =  "exec swayosd --input-volume mute-toggle";
          # Brightness raise
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessUp+shift" = "exec light -s sysfs/leds/tpacpi::kbd_backlight -A 100";
          # Brightness lower
          "XF86MonBrightnessDown" = "exec light -U 5";
          "XF86MonBrightnessDown+shift" = "exec light -s sysfs/leds/tpacpi::kbd_backlight -U 100";
        };
      };
	extraConfig = ''
# colors
set $orange = "#FF8E0D"
set $bground = "#285577"
set $white = "#FFFFFF"

# general settings
focus_follows_mouse no
default_border pixel 1
default_floating_border none
hide_edge_borders smart

# workspaces
set $monitorUp HDMI-A-1
set $monitorLaptop eDP-1

workspace 1 output $monitorUp
workspace 2 output $monitorUp
workspace 3 output $monitorUp
workspace 4 output $monitorUp
workspace 5 output $monitorUp
workspace 6 output $monitorUp
workspace 7 output $monitorLaptop
workspace 8 output $monitorLaptop
workspace 9 output $monitorLaptop
workspace 0 output $monitorLaptop

# set colors
# class		border	bground	text
#client.focused "$orange" "$bground" "$white" 
client.focused "#FF8E0D" "#FF8E0D" "#ffffff" "#FF8E0D"

# move to workspaces
for_window [class="jetbrains-rider"] move to workspace 3
for_window [class="Spotify"] move to workspace 7
for_window [class="Ferdium"] move to workspace 8
for_window [class="Slack"] move to workspace 9
for_window [instance="teams.microsoft.com"] move to workspace 10

# bind keyctl for bwmenu (bitwarden)
exec --no-startup-id keyctl link @u @s

# reload kanshi
exec_always "systemctl --user restart kanshi.service"
	'';


    };
  };
}
