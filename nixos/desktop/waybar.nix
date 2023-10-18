{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font";
    font-size: 15px;
    min-height: 0;
}

window#waybar {
    background: transparent;
    color: #bebebe;
}
button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
}

#workspaces button {
    color: #bebebe;
    background: transparent;
    padding: 0px 6px 0 6px;
    margin: 5px 7px 0 7px;
    border-radius: 4px;
}

#workspaces button:hover {
}


#workspaces button.focused {
    color: white;
    font-weight: 900;
}


@keyframes critical {
    to {
    color: rgba(187,56,0, 1);
    }
}

#mode,
#battery,
#network,
#clock {
	padding: 4px;
	margin: 4px;
}

    '';

    settings = [{
      height = 34;
      tray = { spacing = 10; };
      layer = "top";
      position = "top";
        modules-left = [ "clock" "idle_inhibitor" "sway/mode"   ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [
          "pulseaudio"
          "network"
          "network#wired"
          "battery"
        ];

            battery = {
        format = "{icon} {capacity}%";
        format-alt = "{icon} {time}";
        format-charging = " {capacity}%";
        format-icons = [ " " " " " " " " " " ];
        format-plugged = " {capacity}%";
        states = {
          critical = 15;
          warning = 30;
        };
      };

      clock = {
        format = "{:%d-%m-%Y %H:%M}";
      };

      pulseaudio = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = " {volume}%";
        format-bluetooth-muted = "󰝟 {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = "<span color='red'>󰝟</span> {format_source}";
        format-source = " {volume}%";
        format-source-muted = "<span color='red'></span>";
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "󰖩";
        format = "󰖪";
      };

      "network#wired" = {
        format-ethernet = "󰈁";
        format = "󰈂";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󱜤 ";
          deactivated = "󱠎 ";
        };
      };
    }];
  };
}
