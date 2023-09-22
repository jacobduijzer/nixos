{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
		#${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
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

#workspaces button {
    color: #bebebe;
    background: transparent;
    padding: 0px 6px 0 6px;
    margin: 5px 7px 0 7px;
    border-radius: 4px;
}

#workspaces button.focused {
    color: white;
}

#mode {
    margin: 0px 15px 0px 15px;
    padding: 0px 12px 0px 12px;
    color: black;
    background: white;
}

@keyframes critical {
    to {
    color: rgba(187,56,0, 1);
    }
}

#battery,
#clock {
	padding: 4px;
	margin: 4px;
}

#tray {
    margin: 7px 15px 0 4px;
    background: rgba(40,40,40, .65);
    border-radius: 6px;
    padding: 1px 5px 1px 5px;
}
	'';

	settings = [{
		height = 34;
		layer = "top";
		position = "top";
		tray = { spacing = 10; };
		modules-left = [ "clock" ];
		modules-center = [ "sway/workspaces" ];
		modules-right = [
		"pulseaudio"
		"battery"
	];
	battery = {
		format = "{capacity}% {icon}";
		format-alt = "{time} {icon}";
		format-charging = "{capacity}% ";
		format-icons = [ "" "" "" "" "" ];
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
		format-bluetooth-muted = " {icon} {format_source}";
		format-icons = {
			car = "";
			default = [ "" "" "" ];
			handsfree = "";
			headphones = "";
			headset = "";
			phone = "";
			portable = "";
		};
		format-muted = " {format_source}";
		format-source = "{volume}% ";
		format-source-muted = "";
		on-click = "pavucontrol";
	};
    }];
  };
}
