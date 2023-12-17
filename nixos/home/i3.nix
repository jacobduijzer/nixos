# Inspired by: https://github.com/PrimaMateria/nixos/blob/master/modules/i3.nix
{config, lib, pkgs, ... }:
let
  mod = "Mod4";

  monitorExternal = "HDMI-1";
  monitorLaptop = "eDP-1";

  colorBackground = "#000000";
  colorDominant = "#FF8E0D";

  cmdAppMenu = "rofi -show drun";
  cmdBrowser = "/etc/profiles/per-user/jacob/bin/vivaldi";
  cmdLock = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 10 2";
  #cmdLock = "/home/jacob/.dotfiles/scripts/blur-lock.sh";
  cmdPolybar = "exec --no-startup-id /home/jacob/.dotfiles/scripts/polybar.sh";
  cmdTerminal = "/etc/profiles/per-user/jacob/bin/alacritty";
  cmdWallpaper = "exec --no-startup-id ${pkgs.feh}/bin/feh feh --bg-center /home/jacob/.dotfiles/nixos/desktop/wallpapers/nixos-wallpaper-blue.png";


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
        inner = 15;
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

          "${mod}+Return" = "exec ${cmdTerminal}";
          "${mod}+Shift+Return" = "exec ${cmdBrowser}";
          "${mod}+space" = "exec ${cmdAppMenu}";
          "${mod}+Shift+Escape" = "exec ${cmdLock}";
      };

      bars = [];

      startup = [
         { command = "$cmdWallpaper"; notification = false; }
         { command = "$cmdPolybar"; notification = false; }
      ];

    };
      extraConfig = ''
        title_align center
        default_border pixel 1
        default_floating_border pixel 0
      '';

  };

  #services.polybar = {
  #  enable = true;
	#	package = pkgs.polybar.override {
  #    i3Support = true;
  #    alsaSupport = true;
  #    iwSupport = true;
  #    githubSupport = true;
  #  };
  #  config = {
  #    #"bar/top" = {
  #    #  monitor = "eDP1";
  #    #  width = "100%";
  #    #  height = "3%";
  #    #  radius = 0;
  #    #  # Just sticking them together in the center for now
  #    #  modules-center = "date i3";
  #    #};
  #    #"bar/external" = {
  #    #  "inherit" = "bar/main";
  #    #  monitor = "HDMI-1";
  #    #  bottom = false;
  #    #  modules-center = "i3";
  #    #};
  #    "module/date" = {
  #      type = "internal/date";
  #      internal = 5;
  #      date = "%Y-%m-%d";
  #      time = "%H:%M";
  #      label = "%date% %time%";
  #    };
  #    "module/i3" = {
  #      type = "internal/i3";
  #      scroll-up = "i3wm-wsnext";
  #      scroll-down = "i3wm-wsprev";
  #    };
  #  };
  #  script = ''
  #  ${cmdPolybar} top &
  #  '';
  #};
}  
