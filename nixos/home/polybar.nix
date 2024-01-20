{ pkgs, config, ... }:
let
  icons = {
    cpu = "";
    memory = "";
    date = "";
    microphone = "";
    microphone-muted = "";
    microphone-disconnected = "";
    wifi = "";
    up = "";
    down = "";
    ethernet = "";
    envelope = "";
  };

  cmdPolybar = "/home/jacob/.dotfiles/scripts/polybar.sh";
  #unstable = import (fetchTarball "https://github.com/NixOs/nixpkgs/archive/nixos-unstable.tar.gz") { config.allowUnfree = true; };
  
in {
  services = {
    polybar = {
      enable = true;

      package = pkgs.polybar.override {
        alsaSupport = true;
        githubSupport = true;
        mpdSupport = true;
        pulseSupport = true;
        i3Support = true;
        #i3GapsSupport = true;
      };

      config = let
        background = "#99000000";
        background-alt = "#99000000";

        foreground = "#ffffff";
        foreground-alt = "#ffdddddd";

        primary = "#99000000";
        secondary = "#FF8E0D";
        alert = "#b03a3a";

        fonts = {
          font-0 = "JetBrainsMono Nerd Font:style=Regular:size=14";
          font-1 = "unifont:fontformat=truetype:size=10:antialias=false;0";
          font-2 = "Envy Code R:pixelsize=10;0";
          font-3 = "Font Awesome 5 Free:style=Regular:pixelsize=10;1";
          font-4 = "Font Awesome 5 Free:style=Solid:pixelsize=10;1";
          font-5 = "Font Awesome 5 Brands:pixelsize=10;1";
        };
      in {
        "bar/main" = fonts // {
          #monitor = "\${env:MONITOR}";
          monitor = "eDP-1";
          height = 40;
          radius = 0;
          fixed-center = true;
          bottom = true;

          background = background;
          foreground = foreground;

          line-size = 2;
          line-color = "#f00";

          border-size = 0;

          padding-left = 1;
          padding-right = 1;

          module-margin-left = 1;
          module-margin-right = 1;

          modules-left = "date";
          modules-center = "i3"; #"xwindow";
          modules-right = "lock pulseaudio battery";
          #modules-right =
          #  "filesystem wlan eth memory cpu battery temperature headsetswitch";

          tray-position = "none";
          tray-padding = 3;

          scroll-up = "i3wm-wsnext";
          scroll-down = "i3wm-wsprev";
        };

        "bar/eDP-1" = fonts // {
          "inherit" = "bar/main";
          #monitor = "\${env:MONITOR}";
          monitor = "eDP-1";
          width = "100%";
          modules-center = "i3"; #"xwindow";
        };

        "bar/HDMI-1" = fonts // {
          "inherit" = "bar/main";
          # TODO: set monitor before starting
          #monitor = "\${env:MONITOR}";
          monitor = "HDMI-1";
          width = "100%";
          bottom = false;
          modules-left = "date";
        };

        "settings" = {
          screenchange-reload = "true";
          pseudo-transparency = true;
        };

        "global/wm" = {
          margin-top = 2;
          margin-bottom = 2;
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = "%title:0:30:...%";
        };

        "module/pulseaudio" = {
          type = "internal/pulseaudio"; 
          format-volume = "<ramp-volume> <label-volume>";
          ramp-volume-0 = "󰕿";
          ramp-volume-0-foreground = foreground;
          ramp-volume-1 = "󰖀";
          ramp-volume-1-foreground = foreground;
          ramp-volume-2 = "";
          ramp-volume-2-foreground = foreground;

          label-volume = "%percentage%%";

          label-muted = "󰖁 "; 
          label-muted-foreground = secondary;

          #use-ui-max = true;
          #interval = 5;
          #format-volume = "<ramp-volume> <label-volume>";
          #label-volume = "bla";
          #label-muted-foreground = "#666";

          #ramp-volume-0 = "🔈";
          #ramp-volume-1 = "🔉";
          #ramp-volume-2 = "🔊";

          #click-right = pavucontrol
        };

        "module/i3" = {
          type = "internal/i3";
          format = "<label-state> <label-mode>";
          index-sort = true;
          wrapping-scroll = false;

          # Only show workspaces on the same output as the bar
          pin-workspaces = true;

          label-mode-padding = 2;
          label-mode-foreground = secondary;
          label-mode-background = primary;

          # focused = "Active workspace on focused monitor";
          label-focused = "%index%";
          label-focused-underline= secondary;
          label-focused-background = primary;
          label-focused-padding = 2;

          # unfocused = "Inactive workspace on any monitor";
          label-unfocused = "%index%";
          label-unfocused-background = background;
          label-unfocused-padding = 2;

          # visible = "Active workspace on unfocused monitor";
          label-visible = "%index%";
          label-visible-underline = foreground;
          label-visible-padding = 2;

          # urgent = "Workspace with urgency hint set";
          label-urgent = "%index%";
          label-urgent-background = secondary;
          label-urgent-padding = 2;

          label-separator = "|";
          label-separator-padding = 2;
          label-separator-foreground = secondary;
        };

        "module/eth" = {
          type = "internal/network";
          interval = "3.0";

          format-connected-underline = "#06FFCC";
          format-disconnected-underline = "#06FFCC";
          format-connected-prefix-foreground = foreground-alt;
          label-connected =
            "${icons.ethernet} %ifname% (${icons.up} %upspeed:9% ${icons.down} %downspeed:9%)";

          # format-disconnected = "<label-disconnected>";
          # label-disconnected = "";
          # label-disconnected-foreground = foreground-alt;
        };

        "module/wlan" = {
          type = "internal/network";
          interval = "3.0";

          format-connected = "<ramp-signal> <label-connected>";
          label-connected =
            "%essid% ${icons.wifi} (${icons.up} %upspeed:9% ${icons.down} %downspeed:9%)";

          ramp-signal-0 = "▁";
          ramp-signal-1 = "▂";
          ramp-signal-2 = "▃";
          ramp-signal-3 = "▄";
          ramp-signal-4 = "▅";
          ramp-signal-5 = "▆";
          ramp-signal-6 = "▇";
          ramp-signal-7 = "█";
          ramp-signal-foreground = foreground-alt;
        };

        "module/date" = {
          type = "internal/date";
          interval = "5";

          date = "%a %b %d";
          date-alt = "%Y-%m-%d";

          time = "%H:%M";
          time-alt = "%H:%M";

          label = "${icons.date} %date% %time%";
        };


        "module/xkeyboard" = {
          type = "internal/xkeyboard";
          blacklist-0 = "num lock";

          format-prefix = " ";
          format-prefix-foreground = foreground-alt;

          label-layout = "%layout%";

          label-indicator-padding = "2";
          label-indicator-margin = "1";
          label-indicator-background = secondary;
        };

        "module/xbacklight" = {
          type = "internal/xbacklight";

          format = "<label> <bar>";
          label = "BL";

          bar-width = "10";
          bar-indicator = "|";
          bar-indicator-foreground = "#ff";
          bar-indicator-font = "2";
          bar-fill = "─";
          bar-fill-font = "2";
          bar-fill-foreground = "#9f78e1";
          bar-empty = "─";
          bar-empty-font = "2";
          bar-empty-foreground = foreground-alt;
        };

        "module/backlight-acpi" = {
          "inherit" = "module/xbacklight";
          type = "internal/backlight";
          card = "intel_backlight";
        };

        "module/battery" = {
          type = "internal/battery";
          battery = "BAT0";
          adapter = "AC";
          full-at = "98";

          format-charging = "<animation-charging> <label-charging>";

          format-discharging = "<ramp-capacity> <label-discharging>";

          format-full-prefix = " ";
          format-full-prefix-foreground = foreground;

          ramp-capacity-0 = "";
          ramp-capacity-1 = "";
          ramp-capacity-2 = "";
          ramp-capacity-foreground = foreground;

          animation-charging-0 = "";
          animation-charging-1 = "";
          # animation-charging-2 = "";
          animation-charging-foreground = foreground;
          animation-charging-framerate = "750";
        };

        "module/powermenu" = {
          type = "custom/menu";

          format-spacing = "1";

          label-open = "";
          label-open-foreground = secondary;
          label-close = " cancel";
          label-close-foreground = secondary;
          label-separator = "|";
          label-separator-foreground = foreground-alt;

          menu-0-0 = "reboot";
          menu-0-0-exec = "menu-open-1";
          menu-0-1 = "power off";
          menu-0-1-exec = "menu-open-2";

          menu-1-0 = "cancel";
          menu-1-0-exec = "menu-open-0";
          menu-1-1 = "reboot";
          menu-1-1-exec = "systemctl reboot";

          menu-2-0 = "power off";
          menu-2-0-exec = "systemctl poweroff";
          menu-2-1 = "cancel";
          menu-2-1-exec = "menu-open-0";
        };

        "module/lock" = {
          type = "custom/script";
          exec = "/home/jacob/.dotfiles/scripts/lock.sh status";
          interval = 5;
          click-left = "/home/jacob/.dotfiles/scripts/lock.sh toggle";
        };

        "module/headsetswitch" = let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          grep = "${pkgs.gnugrep}/bin/grep";
          sed = "${pkgs.gnused}/bin/sed";
        in {
          type = "custom/script";
          format-underline = "#0628FF";
          label = "%output%";
          exec = __concatStringsSep " " [
            "${pactl} info"
            "| ${grep} 'Default Sink'"
            "| ${sed} 's/.*analog-stereo//'"
            "| ${sed} 's/.*analog-stereo//'"
            "| ${sed} 's/.*auto_null/${icons.microphone-disconnected}/'"
            "| ${sed} 's/.*hdmi-stereo-extra.*/HDMI/'"
            "| ${sed} 's/.*headset_head_unit/${icons.microphone}/'"
            "| ${sed} 's/.*a2dp_sink/${icons.microphone-muted}/'"
            "| ${sed} 's/.*hdmi-stereo/HDMI/'"
          ];

          tail = true;
          interval = 2;
          click-left =
            "${pactl} set-card-profile bluez_card.2C_41_A1_83_C7_98 a2dp_sink";
          click-right =
            "${pactl} set-card-profile bluez_card.2C_41_A1_83_C7_98 headset_head_unit";
        };

        #"module/spotify" = let
        #  polybar-spotify =
        #    pkgs.callPackage /home/manveru/github/manveru/polybar-spotify { };
        #  # polybar-spotify = import (fetchGit {
        #  #   url = "https://github.com/manveru/polybar-spotify.git";
        #  #   ref = "0.1.1";
        #  # }) {};
        #in {
        #  type = "custom/script";
        #  exec =
        #    "${polybar-spotify}/bin/polybar-spotify %xesam:artist% - %xesam:title%";
        #  tail = true;
        #  interval = 2;
        #  click-left =
        #    "dbus-send --session --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause";
        #};

        "module/notmuch" = {
          type = "custom/script";
          exec =
            "echo -n '${icons.envelope} '; ${pkgs.notmuch}/bin/notmuch search tag:unread | wc -l";
          tail = true;
          interval = 10;
          click-left = "${pkgs.astroid}/bin/astroid";
        };

        "module/adventofcode_1" = {
          type = "custom/script";
          exec = "/home/jacob/Projects/github/AdventOfCode/adventofcode.sh -c /home/jacob/.aoc_cookie.txt -i 3285402 -n 'Jacob Duijzer' -l 'IT&Care'";
          click-right = "exec /etc/profiles/per-user/jacob/bin/vivaldi https://adventofcode.com/2023/leaderboard/private/view/3285402";
          interval = 900;
        };

        "module/adventofcode_2" = {
          type = "custom/script";
          exec = "/home/jacob/Projects/github/AdventOfCode/adventofcode.sh -c /home/jacob/.aoc_cookie.txt -i 1538851 -n 'Jacob Duijzer' -l 'TRIT'";
          click-right = "exec /etc/profiles/per-user/jacob/bin/vivaldi https://adventofcode.com/2023/leaderboard/private/view/1538851";
          interval = 900;
        };

      };

    script = ''
      ${cmdPolybar}
    '';

    };
  };
}
