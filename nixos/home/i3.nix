# Inspired by: https://github.com/PrimaMateria/nixos/blob/master/modules/i3.nix
{config, lib, pkgs, ... }:
let
  mod = "Mod4";

  monitorExternal = "HDMI-1";
  monitorLaptop = "eDP-1";

  colorBackground = "#000000";
  colorDominant = "#FF8E0D";

  cmdAppMenu = "rofi -show drun";
  cmdBitwarden = "/usr/bin/bwmenu";
  cmdBrowser = "/etc/profiles/per-user/jacob/bin/vivaldi";
  cmdLock = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 2";
  cmdTerminal = "/etc/profiles/per-user/jacob/bin/alacritty";


in {
  imports = [
    ./polybar.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      #fonts = ["DejaVu Sans Mono, FontAwesome 6"];
      gaps = {
        inner = 10;
      };

      colors = {
        focused = {
          border = "${colorDominant}";
          background = "#000000";
          text = "#ffffff";
          indicator = "FF8E0D";
          childBorder = "${colorDominant}";
        };
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = "${monitorExternal}"; }
        { workspace = "2"; output = "${monitorExternal}"; }
        { workspace = "3"; output = "${monitorExternal}"; }
        { workspace = "4"; output = "${monitorExternal}"; }
        { workspace = "5"; output = "${monitorExternal}"; }
        { workspace = "6"; output = "${monitorExternal}"; }
        { workspace = "7"; output = "${monitorLaptop}"; }
        { workspace = "8"; output = "${monitorLaptop}"; }
        { workspace = "9"; output = "${monitorLaptop}"; }
        { workspace = "10"; output = "${monitorLaptop}"; }
      ];
      
      window  = {
        hideEdgeBorders = "none";
        commands = [
          {
            criteria = { class = "(?i)macs"; };
            command = "floating enable";
          }
        ];
      };
      keybindings = lib.mkOptionDefault {
					#"${mod}+BackSpace" = "workspace back_and_forth";
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

          "${mod}+Shift+0" = "move container to workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";

          # change focus, vi bindings
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # move windows in workspace, vi bindings
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # move windows to workspace, vi bindings
          "${mod}+Ctrl+h" = "move workspace to output left";
          "${mod}+Ctrl+j" = "move workspace to output down";
          "${mod}+Ctrl+k" = "move workspace to output up";
          "${mod}+Ctrl+l" = "move workspace to output right";

          # toggle between horizontal or vertical split
          "${mod}+BackSpace" = "split toggle";

          # change gaps
          "${mod}+minus" = "gaps inner current minus 2";
          "${mod}+plus" = "gaps inner current plus 2";

          # reload & restart i3
          "${mod}+Shift+r" = "restart";
          "${mod}+Shitf+c" = "reload";

          # scratchpad
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+Ctrl+minus" = "scratchpad show";

          # toggle tiling / floating
          "${mod}+Shift+f" = "floating toggle";

          "${mod}+Return" = "exec ${cmdTerminal}";
          "${mod}+Shift+Return" = "exec ${cmdBrowser}";
          "${mod}+space" = "exec ${cmdAppMenu}";
          "${mod}+Mod1+space" = "exec ${cmdBitwarden}";
          "${mod}+Shift+Escape" = "exec ${cmdLock}";

          # volume keys
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";

          #screenshots
          "${mod}+Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
      };

      bars = [];

      startup = [
         { command = "$cmdWallpaper"; notification = false; }
         { command = "/home/jacob/.dotfiles/scripts/polybar.sh"; notification = false; }
         { command = "${pkgs.unclutter}/bin/unclutter -idle 2 -jitter 5 -noevents"; }
         { command = "${pkgs.feh}/bin/feh --bg-center /home/jacob/.dotfiles/nixos/desktop/wallpapers/nixos-wallpaper-blue.png"; }
         { command = "${pkgs.xautolock}/bin/xautolock -time 10 -locker \"i3lock-fancy-rapid 10 2\""; }

      ];

    };
      extraConfig = ''
        title_align center
        default_border pixel 1
        default_floating_border pixel 0
      '';

  };
}  
